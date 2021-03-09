import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'abstract_github_view.dart';

class PubspecDependenciesView extends AbstractGithubView {
  final List<String> showDependencies;
  const PubspecDependenciesView({
    @required String owner,
    @required String repository,
    @required String ref,
    String path = 'pubspec.yaml',
    Client client,
    this.showDependencies,
    Key key,
  }) : super(
          owner: owner,
          repository: repository,
          ref: ref,
          path: path,
          client: client,
          key: key,
        );

  @override
  Widget buildWidget(BuildContext context, String responseBody) {
    final pubspec = Pubspec.parse(responseBody);
    final Map<String, String> dependencies = {};
    final Map<String, String> devDependencies = {};

    if (this.showDependencies != null) {
      for (String key in this.showDependencies) {
        var value = pubspec.dependencies[key];
        if (value != null && value is HostedDependency) {
          dependencies[key] = value.version.toString();
          continue;
        }
        value = pubspec.devDependencies[key];
        if (value != null && value is HostedDependency) {
          devDependencies[key] = value.version.toString();
        }
      }
    } else {
      pubspec.dependencies.forEach((key, value) {
        if (value is HostedDependency) {
          dependencies[key] = value.version.toString();
        }
      });

      pubspec.devDependencies.forEach((key, value) {
        if (value is HostedDependency) {
          devDependencies[key] = value.version.toString();
        }
      });
    }

    String code = '';

    if (dependencies.isNotEmpty) {
      code = 'dependencies:';
      dependencies.forEach((key, value) {
        code += '\n  $key: $value';
      });
    }

    if (devDependencies.isNotEmpty) {
      if (code.isNotEmpty) code += '\n\n';
      code += 'dev_dependencies:';
      devDependencies.forEach((key, value) {
        code += '\n  $key: $value';
      });
    }

    return SyntaxView(
      code: code,
      syntax: Syntax.YAML,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      withZoom: true,
      withLinesCount: false,
    );
  }
}

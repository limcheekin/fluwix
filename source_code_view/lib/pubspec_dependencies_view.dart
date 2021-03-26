import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:url_launcher/link.dart';
import 'abstract_github_view.dart';
import 'copy_button.dart';
import 'multiple_requests_http_client.dart';

class PubspecDependenciesView extends AbstractGithubView {
  final List<String> showDependencies;
  const PubspecDependenciesView({
    @required String owner,
    @required String repository,
    @required String ref,
    String path = 'pubspec.yaml',
    MultipleRequestsHttpClient client,
    this.showDependencies,
    bool wantKeepAlive = true,
    Key key,
  }) : super(
          owner: owner,
          repository: repository,
          ref: ref,
          path: path,
          client: client,
          wantKeepAlive: wantKeepAlive,
          key: key,
        );

  @override
  _PubspecDependenciesViewState createState() =>
      _PubspecDependenciesViewState();
}

class _PubspecDependenciesViewState
    extends AbstractGithubViewState<PubspecDependenciesView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<Response>(
          future: this.getGithubContent,
          builder: (context, snapshot) {
            final linkText = this
                .widget
                .path
                .substring(this.widget.path.lastIndexOf('/') + 1);
            if (snapshot.connectionState == ConnectionState.done) {
              if (this.widget.client != null) {
                this.widget.client.close();
              }
              final response = snapshot.data;
              String code;
              if (snapshot.hasData && response.statusCode == 200) {
                code = _getCode(response.body);
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Link(
                            uri: Uri.parse(this.widget.linkUrl),
                            builder:
                                (BuildContext context, FollowLink followLink) =>
                                    TextButton(
                              onPressed: followLink,
                              child: Text(
                                linkText,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: this.widget.hasCopyButton &&
                                snapshot.hasData &&
                                response.statusCode == 200
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CopyButton(text: code))
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  _buildWidget(context, snapshot, code),
                ],
              );
            }
            return super.buildShimmer(linkText);
          },
        ),
      ),
    );
  }

  String _getCode(String responseBody) {
    final pubspec = Pubspec.parse(responseBody);
    final Map<String, String> dependencies = {};
    final Map<String, String> devDependencies = {};

    if (this.widget.showDependencies != null) {
      for (String key in this.widget.showDependencies) {
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
    return code;
  }

  Widget _buildWidget(
      BuildContext context, AsyncSnapshot<Response> snapshot, String code) {
    if (snapshot.hasData) {
      final response = snapshot.data;
      return response.statusCode == 200
          ? SyntaxView(
              code: code,
              syntax: Syntax.YAML,
              syntaxTheme: SyntaxTheme.vscodeDark(),
              withZoom: true,
              withLinesCount: false,
            )
          : super.buildGithubErrorWidget(
              'Failed to fetch content from ${this.widget.apiUrl}! '
              'Please click the link above to access the github content.');
    } else {
      print(snapshot.error);
      return super.buildGithubErrorWidget('Connection error! '
          'Please click the link above to access the github content.');
    }
  }

  @override
  Widget buildWidget(BuildContext context, String responseBody) {
    throw UnimplementedError('buildWidget method never be invoked');
  }
}

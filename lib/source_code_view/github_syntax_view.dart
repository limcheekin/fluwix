import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart';
import 'abstract_github_view.dart';

class GithubSyntaxView extends AbstractGithubView {
  const GithubSyntaxView({
    @required String owner,
    @required String repository,
    @required String ref,
    @required String path,
    Client client,
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
    return SyntaxView(
      code: responseBody,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    );
  }
}

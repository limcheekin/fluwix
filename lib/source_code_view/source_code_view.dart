import 'package:flutter/material.dart';

import 'github_syntax_view.dart';

class SourceCodeView extends StatelessWidget {
  final String apiUrl;
  final String linkUrl;
  final List<String> paths;

  SourceCodeView(
      {@required this.apiUrl,
      @required this.linkUrl,
      @required this.paths,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (String path in this.paths)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GithubSyntaxView(
              apiUrl: apiUrl,
              linkUrl: linkUrl,
              path: path,
            ),
          )
      ],
    );
  }
}

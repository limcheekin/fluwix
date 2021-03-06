import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../common/presentation/widgets/load_progress_indicator.dart';

class MarkdownScreen extends StatelessWidget {
  MarkdownScreen({Key key}) : super(key: key);
  static const GITHUB_URL =
      'https://api.github.com/repos/limcheekin/flutter-widgets-explorer/contents/intro.md';

  // REF: https://flutter.dev/docs/cookbook/networking/fetch-data#5-display-the-data
  Future<Response> _fetchGithubContent(String url) async {
    return http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/vnd.github.v3.raw',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markdown View'),
      ),
      body: FutureBuilder<Response>(
        future: _fetchGithubContent(GITHUB_URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final response = snapshot.data;
            return Markdown(
              data: response.statusCode == 200
                  ? response.body
                  : 'Failed to fetch content from $GITHUB_URL',
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return LoadProgressIndicator();
        },
      ),
    );
  }
}

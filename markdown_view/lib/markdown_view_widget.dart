import 'package:common_ui/load_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MarkdownViewWidget extends StatelessWidget {
  const MarkdownViewWidget({Key? key}) : super(key: key);
  static const githubUrl =
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
    return FutureBuilder<Response>(
      future: _fetchGithubContent(githubUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final response = snapshot.data;
          return Markdown(
            data: response?.statusCode == 200 && response?.body != null
                ? response!.body
                : 'Failed to fetch content from $githubUrl',
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const LoadProgressIndicator();
      },
    );
  }
}

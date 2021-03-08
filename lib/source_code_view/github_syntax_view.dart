import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widgets_explorer/common/presentation/widgets/load_progress_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'copy_button.dart';

class GithubSyntaxView extends StatelessWidget {
  final String apiUrl;
  final String linkUrl;
  final String path;
  final Client client;

  const GithubSyntaxView({
    @required this.apiUrl,
    @required this.linkUrl,
    @required this.path,
    this.client,
    Key key,
  }) : super(key: key);

  // REF: https://flutter.dev/docs/cookbook/networking/fetch-data#5-display-the-data
  Future<Response> _fetchGithubContent(String url) {
    if (client != null) {
      return client.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.github.v3.raw',
        },
      );
    } else {
      return http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.github.v3.raw',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Link(
                      uri: Uri.parse('${this.linkUrl}${this.path}'),
                      builder: (BuildContext context, FollowLink followLink) =>
                          TextButton(
                        onPressed: followLink,
                        child: Text(
                          this.path.substring(this.path.lastIndexOf('/') + 1),
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CopyButton(text: ''),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<Response>(
            future: _fetchGithubContent('${this.apiUrl}${this.path}'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final response = snapshot.data;
                return SyntaxView(
                  code: response.statusCode == 200
                      ? response.body
                      : 'Failed to fetch content from ${this.apiUrl}${this.path}!',
                  syntax: Syntax.DART,
                  syntaxTheme: SyntaxTheme.vscodeDark(),
                  withZoom: true,
                  withLinesCount: true,
                  expanded: false,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return LoadProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

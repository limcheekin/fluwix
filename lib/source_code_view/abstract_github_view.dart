import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/link.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'copy_button.dart';
import 'multiple_requests_http_client.dart';

abstract class AbstractGithubView extends StatelessWidget {
  final String apiUrl;
  final String linkUrl;
  final String path;
  final bool hasCopyButton;
  final MultipleRequestsHttpClient client;

  const AbstractGithubView({
    @required String owner,
    @required String repository,
    @required String ref,
    @required this.path,
    this.hasCopyButton = true,
    this.client,
    Key key,
  })  : this.apiUrl =
            'https://api.github.com/repos/$owner/$repository/contents/$path?ref=$ref',
        this.linkUrl = 'https://github.com/$owner/$repository/blob/$ref/$path',
        super(key: key);

  // REF: https://flutter.dev/docs/cookbook/networking/fetch-data#5-display-the-data
  Future<Response> fetchGithubContent(String url) {
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
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<Response>(
          future: fetchGithubContent(this.apiUrl),
          builder: (context, snapshot) {
            final linkText =
                this.path.substring(this.path.lastIndexOf('/') + 1);
            if (snapshot.connectionState == ConnectionState.done) {
              if (client != null) {
                client.close();
              }
              final response = snapshot.data;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Link(
                            uri: Uri.parse(this.linkUrl),
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
                        child: this.hasCopyButton &&
                                snapshot.hasData &&
                                response.statusCode == 200
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CopyButton(text: response.body))
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  _buildWidget(context, snapshot)
                ],
              );
            }
            return buildShimmer(linkText);
          },
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, AsyncSnapshot<Response> snapshot) {
    if (snapshot.hasData) {
      final response = snapshot.data;
      return response.statusCode == 200
          ? buildWidget(context, response.body)
          : buildGithubErrorWidget(
              'Failed to fetch content from ${this.apiUrl}! '
              'Please click the link above to access the github content.');
    } else {
      print(snapshot.error);
      return buildGithubErrorWidget('Connection error! '
          'Please click the link above to access the github content.');
    }
  }

  Widget buildGithubErrorWidget(String error) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(error),
    );
  }

  Widget buildWidget(BuildContext context, String responseBody);

  Widget buildShimmer(String linkText) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Align(
                  alignment: Alignment.centerLeft,
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
              Expanded(
                flex: 1,
                child: this.hasCopyButton
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.copy),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: 100.0,
            width: double.infinity,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

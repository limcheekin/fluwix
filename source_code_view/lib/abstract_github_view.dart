import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/link.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'copy_button.dart';
import 'multiple_requests_http_client.dart';

// REF: https://stackoverflow.com/questions/50696945/flutter-statefulwidget-state-class-inheritance
// REF: https://blog.gskinner.com/archives/2020/08/flutter-extending-statet.html
// REF: https://github.com/diegoveloper/flutter-samples/blob/master/lib/persistent_tabbar/page2.dart
abstract class AbstractGithubView extends StatefulWidget {
  final String apiUrl;
  final String linkUrl;
  final String path;
  final bool hasCopyButton;
  final bool wantKeepAlive;
  final MultipleRequestsHttpClient client;

  const AbstractGithubView({
    @required String owner,
    @required String repository,
    @required String ref,
    @required this.path,
    @required this.wantKeepAlive,
    this.hasCopyButton = true,
    this.client,
    Key key,
  })  : this.apiUrl =
            'https://api.github.com/repos/$owner/$repository/contents/$path?ref=$ref',
        this.linkUrl = 'https://github.com/$owner/$repository/blob/$ref/$path',
        super(key: key);
}

abstract class AbstractGithubViewState<T extends AbstractGithubView>
    extends State<T> with AutomaticKeepAliveClientMixin<T> {
  /* REF: https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
  The future must have been obtained earlier, e.g. during State.initState, State.didUpdateWidget, 
  or State.didChangeDependencies. 
  It must not be created during the State.build or StatelessWidget.build method call when 
  constructing the FutureBuilder. If the future is created at the same time as the FutureBuilder, 
  then every time the FutureBuilder's parent is rebuilt, the asynchronous task will be restarted.
  */
  Future<Response> getGithubContent;

  @override
  void initState() {
    super.initState();
    getGithubContent = _fetchGithubContent();
  }

  Future<Response> _fetchGithubContent() {
    if (this.widget.client != null) {
      return this.widget.client.get(
        Uri.parse(this.widget.apiUrl),
        headers: {
          'Accept': 'application/vnd.github.v3.raw',
        },
      );
    } else {
      return http.get(
        Uri.parse(this.widget.apiUrl),
        headers: {
          'Accept': 'application/vnd.github.v3.raw',
        },
      );
    }
  }

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
              'Failed to fetch content from ${this.widget.apiUrl}! '
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
                child: this.widget.hasCopyButton
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

  @override
  bool get wantKeepAlive => this.widget.wantKeepAlive;
}

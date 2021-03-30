import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:source_code_view/abstract_github_view.dart';
import 'package:source_code_view/multiple_requests_http_client.dart';

class ReadMeView extends AbstractGithubView {
  const ReadMeView({
    @required String owner,
    @required String repository,
    @required String ref,
    @required String path,
    MultipleRequestsHttpClient client,
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
  _ReadMeViewState createState() => _ReadMeViewState();
}

class _ReadMeViewState extends AbstractGithubViewState<ReadMeView> {
  @override
  Widget buildWidget(BuildContext context, String responseBody) {
    return Expanded(
      child: Markdown(
        data: responseBody,
      ),
    );
  }
}

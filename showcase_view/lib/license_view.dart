import 'package:flutter/material.dart';
import 'package:source_code_view/abstract_github_view.dart';
import 'package:source_code_view/multiple_requests_http_client.dart';

class LicenseView extends AbstractGithubView {
  const LicenseView({
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
          hasCopyButton: false,
          key: key,
        );
  @override
  _LicenseViewState createState() => _LicenseViewState();
}

class _LicenseViewState extends AbstractGithubViewState<LicenseView> {
  @override
  Widget buildWidget(BuildContext context, String responseBody) {
    return Text(responseBody);
  }
}

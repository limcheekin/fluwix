import 'package:flutter/material.dart';
import 'pubspec_dependencies_view.dart';
import 'github_syntax_view.dart';
import 'multiple_requests_http_client.dart';

class SourceCodeView extends StatelessWidget {
  final String owner;
  final String repository;
  final String ref;
  final String pubspecPath;
  final List<String> paths;
  final bool isShowDependencies;
  final List<String> showDependencies;
  final MultipleRequestsHttpClient client;

  SourceCodeView({
    @required this.owner,
    @required this.repository,
    @required this.ref,
    @required this.paths,
    this.pubspecPath = 'pubspec.yaml',
    this.isShowDependencies = false,
    this.showDependencies,
    this.client,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleRequestsHttpClient httpClient =
        this.client ?? MultipleRequestsHttpClient();

    return Column(
      children: [
        if (this.isShowDependencies)
          PubspecDependenciesView(
            owner: this.owner,
            repository: this.repository,
            ref: this.ref,
            path: this.pubspecPath,
            client: httpClient,
            showDependencies: this.showDependencies,
          ),
        for (String path in this.paths)
          GithubSyntaxView(
            owner: this.owner,
            repository: this.repository,
            ref: this.ref,
            path: path,
            client: httpClient,
          ),
      ],
    );
  }
}

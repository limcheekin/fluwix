import 'package:flutter/material.dart';
import 'package:flutter_widgets_explorer/source_code_view/pubspec_dependencies_view.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'github_syntax_view.dart';

class SourceCodeView extends StatelessWidget {
  final String owner;
  final String repository;
  final String ref;
  final List<String> paths;
  final Client client;

  SourceCodeView({
    @required this.owner,
    @required this.repository,
    @required this.ref,
    @required this.paths,
    this.client,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Client httpClient = this.client ?? http.Client();

    return Column(
      children: [
        PubspecDependenciesView(
          owner: owner,
          repository: repository,
          ref: ref,
          client: httpClient,
          showDependencies: [
            'flutter_syntax_view',
            'shimmer',
            'flutter_launcher_icons',
          ],
        ),
        for (String path in this.paths)
          GithubSyntaxView(
            owner: owner,
            repository: repository,
            ref: ref,
            path: path,
            client: httpClient,
          ),
      ],
    );
    /*finally {
      if (this.client == null) {
        httpClient.close();
      }
    }*/
  }
}

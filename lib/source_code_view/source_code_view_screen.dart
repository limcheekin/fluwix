import 'package:flutter/material.dart';
import 'source_code_view.dart';

class SourceCodeViewScreen extends StatelessWidget {
  const SourceCodeViewScreen({Key key}) : super(key: key);
  static const owner = 'limcheekin';
  static const repository = 'flutter-widgets-explorer';
  static const branch = 'source_code_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source Code View'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SourceCodeView(
            owner: owner,
            repository: repository,
            ref: branch,
            paths: [
              'lib/source_code_view/multiple_requests_http_client.dart',
              'lib/source_code_view/abstract_github_view.dart',
              'lib/source_code_view/copy_button.dart',
              'lib/source_code_view/github_syntax_view.dart',
              'lib/source_code_view/pubspec_dependencies_view.dart',
              'lib/source_code_view/source_code_view.dart',
              'lib/source_code_view/source_code_view_screen.dart',
            ],
            showDependencies: [
              'http',
              'animate_icons',
              'flutter_syntax_view',
              'shimmer',
              'url_launcher',
              'pubspec_parse',
            ],
          ),
        ),
      ),
    );
  }
}

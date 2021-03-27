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
              'source_code_view/pubspec.yaml',
              'source_code_view/lib/main.dart',
              'common_ui/lib/my_module.dart',
              'source_code_view/lib/source_code_view_screen.dart',
              'source_code_view/lib/source_code_view.dart',
              'source_code_view/lib/abstract_github_view.dart',
              'source_code_view/lib/multiple_requests_http_client.dart',
              'source_code_view/lib/copy_button.dart',
              'source_code_view/lib/github_syntax_view.dart',
              'source_code_view/lib/pubspec_dependencies_view.dart',
            ],
          ),
        ),
      ),
    );
  }
}

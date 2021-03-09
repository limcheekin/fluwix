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
              'lib/source_code_view/source_code_view_screen.dart',
              //'lib/source_code_view/source_code_view.dart',
            ],
          ),
        ),
      ),
    );
  }
}

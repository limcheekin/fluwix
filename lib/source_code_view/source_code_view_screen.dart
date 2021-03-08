import 'package:flutter/material.dart';
import 'package:flutter_widgets_explorer/source_code_view/source_code_view.dart';

class SourceCodeViewScreen extends StatelessWidget {
  const SourceCodeViewScreen({Key key}) : super(key: key);
  static const githubApiUrl =
      'https://api.github.com/repos/limcheekin/flutter-widgets-explorer/contents/';
  static const githubLinkUrl =
      'https://github.com/limcheekin/flutter-widgets-explorer/blob/main/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source Code View'),
      ),
      body: SingleChildScrollView(
        child: SourceCodeView(
          apiUrl: githubApiUrl,
          linkUrl: githubLinkUrl,
          paths: [
            'lib/expansion_collapse_view/expansion_collapse_view_screen.dart',
            'lib/expansion_collapse_view/expansion_panel_screen.dart',
            'lib/expansion_collapse_view/expansion_tile_screen.dart',
          ],
        ),
      ),
    );
  }
}

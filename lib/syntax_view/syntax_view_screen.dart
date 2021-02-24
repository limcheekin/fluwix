import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class SyntaxViewScreen extends StatelessWidget {
  static final String code = """
// Importing core libraries
import 'dart:math';
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}          
var result = fibonacci(20);
/* and there 
    you have it! */
""";

  static final syntaxViews = {
    "Standard": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.standard(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "Dracula": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.dracula(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "AyuLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuLight(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "AyuDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "GravityLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityLight(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "GravityDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "MonokaiSublime": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.monokaiSublime(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "Obsidian": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.obsidian(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "OceanSunset": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.oceanSunset(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "vscodeDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "vscodeLight": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        withZoom: true,
        withLinesCount: true)
  };

  void _saveToClipboard(String text) async {
    ClipboardData data = ClipboardData(text: text);
    await Clipboard.setData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syntax View'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: syntaxViews.length,
          itemBuilder: (BuildContext context, int index) {
            String themeName = syntaxViews.keys.elementAt(index);
            SyntaxView syntaxView = syntaxViews.values.elementAt(index);
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 6.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            print(syntaxView.code);
                            _saveToClipboard(syntaxView.code);
                          },
                        ),
                      ],
                    ),
                  ),
                  //Divider(),
                  if (syntaxView.expanded)
                    Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: syntaxView)
                  else
                    syntaxView
                ],
              ),
            );
          }),
    );
  }
}

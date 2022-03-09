import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class SyntaxViewWidget extends StatelessWidget {
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
    'Standard': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.standard(),
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    ),
    'Dracula': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.dracula(),
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    ),
    'AyuLight': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuLight(),
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    ),
    'AyuDark': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    ),
    'GravityLight': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityLight(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    'GravityDark': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    'MonokaiSublime': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.monokaiSublime(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    'Obsidian': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.obsidian(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    'OceanSunset': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.oceanSunset(),
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    'vscodeDark': SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    ),
    'vscodeLight': SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        withZoom: true,
        withLinesCount: true)
  };

  void _saveToClipboard(String text) async {
    final data = ClipboardData(text: text);
    await Clipboard.setData(data);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: syntaxViews.length,
        itemBuilder: (BuildContext context, int index) {
          final themeName = syntaxViews.keys.elementAt(index);
          final syntaxView = syntaxViews.values.elementAt(index);
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
                if (syntaxView.expanded)
                  Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: syntaxView)
                else
                  syntaxView
              ],
            ),
          );
        });
  }
}

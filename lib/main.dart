import 'package:flutter/material.dart';

import 'nested_list/nested_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Nested List',
      'Tab Buttons',
      'Stock Chart',
    ];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Widgets'),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (BuildContext context, int position) {
                var name = names[position];
                return Card(
                  margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: ListTile(
                    title: Text(name),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      switch (position) {
                        case 0:
                          _gotoScreen(context, NestedListScreen());
                          break;
                        default:
                      }
                    },
                  ),
                );
              },
            ),
          )),
    );
  }

  void _gotoScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => screen,
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_widgets_explorer/common/presentation/widgets/center_text.dart';

class NestedListScreen extends StatefulWidget {
  NestedListScreen({Key key}) : super(key: key);

  @override
  _NestedListScreenState createState() => _NestedListScreenState();
}

class _NestedListScreenState extends State<NestedListScreen> {
  @override
  Widget build(BuildContext context) {
    String title = 'Nested List Screen';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CenterText(title),
    );
  }
}

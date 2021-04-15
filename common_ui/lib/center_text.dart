import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  const CenterText(this.title, {Key key}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}

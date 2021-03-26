import 'package:flutter/material.dart';

class MyModule extends StatelessWidget {
  final String title;
  final Widget home;

  const MyModule({
    required this.title,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: this.home,
    );
  }
}

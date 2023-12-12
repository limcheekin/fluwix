import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final FlutterConsoleController controller = FlutterConsoleController();

  void echoLoop() {
    controller.scan().then((value) {
      controller.print(message: value, endline: true);
      controller.focusNode.requestFocus();
      echoLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    echoLoop();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: FlutterConsole(
        controller: controller,
        height: size.height,
        width: size.width,
      ),
    );
  }
}

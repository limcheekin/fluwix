import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console.dart';

class Console extends StatefulWidget {
  const Console({
    required this.content,
    required this.initFunction,
    required this.executeFunction,
    super.key,
  });
  final String content;
  final Function initFunction;
  final Function executeFunction;

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  late FlutterConsoleController controller;
  static const commandSymbol = '>';

  Future<dynamic> execute(Function function, String message) async {
    controller.print(
      message: '$commandSymbol $message',
      endline: false,
    );
    dynamic result;
    try {
      // ignore: avoid_dynamic_calls
      result = await function();
      controller.print(
        message: ' ✅',
        endline: true,
      );
      if (result != null) {
        // debugPrint('Console: result $result');
        if (result is Iterable) {
          if (result.isNotEmpty) {
            if (result.first is List) {
              // nested list for multiple statements
              final list = result.reduce((value, element) => value + element);
              if (list.isNotEmpty == true) {
                controller.print(
                  message: result.toString(),
                  endline: true,
                );
              }
            } else {
              controller.print(
                message: result.toString(),
                endline: true,
              );
            }
          }
        } else {
          controller.print(
            message: result.toString(),
            endline: true,
          );
        }
      }
    } catch (error, _) {
      controller.print(
        message: ' ❎ $error',
        endline: true,
      );
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    controller = FlutterConsoleController(consoleContent: widget.content);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.initFunction();
      echoLoop();
    });
  }

  void echoLoop() {
    controller.scan().then((value) {
      execute(
        () => widget.executeFunction(value),
        value,
      );
      controller.focusNode.requestFocus();
      echoLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FlutterConsole(
      controller: controller,
      height: size.height,
      width: size.width,
    );
  }
}

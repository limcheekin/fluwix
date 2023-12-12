library flutter_console_widget;

export 'package:flutter_console_widget/flutter_console_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console_controller.dart';
import 'package:flutter_console_widget/selectable_colored_text.dart';

class FlutterConsole extends StatelessWidget {
  const FlutterConsole({
    this.consoleBackground = Colors.black,
    this.consoleTextColor = Colors.white,
    this.consoleSelectedTextBackgroundColor = Colors.white,
    this.consoleSelectedTextColor = Colors.black,
    required this.controller,
    required this.height,
    this.inputBackground = const Color(0xff333333),
    this.inputTextColor = Colors.white,
    Key? key,
    this.scrollColor = Colors.grey,
    required this.width,
  }) : super(key: key);

  final Color consoleBackground;
  final Color consoleTextColor;
  final Color consoleSelectedTextBackgroundColor;
  final Color consoleSelectedTextColor;
  final FlutterConsoleController controller;
  final double height;
  final Color inputBackground;
  final Color inputTextColor;
  final Color scrollColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FlutterConsoleData>(
        valueListenable: controller,
        builder: (context, consoleData, _) {
          return !consoleData.show
              ? const SizedBox.shrink()
              : Container(
                  color: consoleBackground,
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: width,
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                scrollbarTheme:
                                    const ScrollbarThemeData().copyWith(
                              thumbColor:
                                  MaterialStateProperty.all(scrollColor),
                            )),
                            child: Scrollbar(
                              controller: controller.scrollController,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: controller.scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SelectableColoredText(
                                    consoleData.consoleContent,
                                    style: TextStyle(
                                      color: consoleTextColor,
                                    ),
                                    selectedTextColor: consoleSelectedTextColor,
                                    selectedTextBackgroundColor:
                                        consoleSelectedTextBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: inputBackground,
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: inputTextColor,
                              size: 20,
                            ),
                            Flexible(
                              child: TextField(
                                autofocus: true,
                                keyboardType: consoleData.keyboardType,
                                controller: controller.inputController,
                                focusNode: controller.focusNode,
                                cursorColor: inputTextColor,
                                style: TextStyle(color: inputTextColor),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: inputBackground,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    right: 10,
                                    left: 5,
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (!controller.completer.isCompleted) {
                                    controller.completer.complete(
                                      value,
                                    );
                                  }
                                },
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: consoleBackground,
                              ),
                              onPressed: () {
                                if (!controller.completer.isCompleted) {
                                  controller.completer.complete(
                                    controller.inputController.text,
                                  );
                                }
                              },
                              child: const Icon(Icons.done),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}

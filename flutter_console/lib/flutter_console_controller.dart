import 'dart:async';

import 'package:flutter/material.dart';

class FlutterConsoleController extends ValueNotifier<FlutterConsoleData> {
  FlutterConsoleController({
    String consoleContent = '',
  }) : super(
          FlutterConsoleData(
            keyboardType: TextInputType.none,
            consoleContent: consoleContent,
          ),
        );

  final FocusNode focusNode = FocusNode();
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Completer<String> completer = Completer();

  void show() {
    value = value.copyWith(
      show: true,
    );
  }

  void hide() {
    value = value.copyWith(
      show: false,
    );
  }

  void print({required String message, required bool endline}) {
    value = value.copyWith(
      consoleContent: '${value.consoleContent}$message${endline ? '\n' : ''}',
    );

    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
    ).then((value) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<String> scan({TextInputType? keyboardType}) async {
    completer = Completer();
    value = value.copyWith(
      keyboardType: keyboardType,
    );
    final readedValue = await completer.future;
    inputController.clear();
    return readedValue;
  }

  void clear() {
    value = value.copyWith(consoleContent: '');
  }
}

class FlutterConsoleData {
  FlutterConsoleData({
    this.keyboardType = TextInputType.none,
    this.consoleContent = '',
    this.show = true,
  });

  final TextInputType keyboardType;
  final String consoleContent;
  final bool show;

  FlutterConsoleData copyWith({
    TextInputType? keyboardType,
    String? consoleContent,
    bool? show,
  }) =>
      FlutterConsoleData(
        keyboardType: keyboardType ?? this.keyboardType,
        consoleContent: consoleContent ?? this.consoleContent,
        show: show ?? this.show,
      );
}

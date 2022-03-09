import 'package:flutter/material.dart';
import 'package:common_ui/my_module.dart';
import 'wallet_connect_showcase_screen.dart';

void main() {
  runApp(
    const MyModule(
      title: 'Wallet Connect Showcase',
      home: WalletConnectShowcaseScreen(),
    ),
  );
}

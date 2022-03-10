import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'create_widget_stub.dart'
    if (dart.library.io) 'create_widget_mobile.dart'
    if (dart.library.html) 'create_widget_web.dart';

class WalletConnectShowcaseScreen extends StatelessWidget {
  const WalletConnectShowcaseScreen({Key? key}) : super(key: key);

  // Configure the properties for external GitHub repo, for example:
  // https://github.com/miquelbeltran/flutter_material_showcase
  // owner = 'miquelbeltran';
  // repository = 'flutter_material_showcase';
  // branch = 'master';
  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'wallet_connect_showcase';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Wallet Connect Showcase',
      widget: createWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      // $branch/ prefix is not needed for external GitHub repo
      // Please refer to the following sample code:
      // https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart
      readMe: '$branch/README.md',
      codePaths: const [
        '$branch/pubspec.yaml',
        '$branch/lib/wallet_connect_showcase_screen.dart',
        '$branch/lib/create_widget_stub.dart',
        '$branch/lib/create_widget_mobile.dart',
        '$branch/lib/create_widget_web.dart',
        '$branch/lib/wallet_connect_showcase_widget.dart',
        '$branch/lib/wallet_connect_web_showcase_widget.dart',
        '$branch/lib/eth_conversions.dart',
        '$branch/lib/qr_scan_view.dart',
      ],
    );
  }
}

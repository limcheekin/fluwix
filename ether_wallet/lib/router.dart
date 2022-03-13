import '../../model/network_type.dart';
import '../../qrcode_reader_page.dart';
import '../../service/configuration_service.dart';
import '../../utils/route_utils.dart';
import '../../wallet_create_page.dart';
import '../../wallet_import_page.dart';
import '../../wallet_main_page.dart';
import '../../wallet_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'context/setup/wallet_setup_provider.dart';
import 'context/transfer/wallet_transfer_provider.dart';
import 'context/wallet/wallet_provider.dart';
import 'intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) {
      final configurationService = Provider.of<ConfigurationService>(context);
      if (configurationService.didSetupWallet()) {
        return WalletProvider(
            builder: (context, store) => const WalletMainPage('Your wallet'));
      }

      return const IntroPage();
    },
    '/create': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          // ignore: body_might_complete_normally_nullable
          useEffect(() {
            store.generateMnemonic();
          }, []);

          // ignore: prefer_const_constructors
          return WalletCreatePage('Create wallet');
        }),
    '/import': (BuildContext context) => WalletSetupProvider(
          // ignore: prefer_const_constructors
          builder: (context, store) => WalletImportPage('Import wallet'),
        ),
    '/transfer': (BuildContext context) => WalletTransferProvider(
          // ignore: prefer_const_constructors
          builder: (context, store) => WalletTransferPage(
            title: 'Send Tokens',
            network: getRouteArgs<NetworkType>(context),
          ),
        ),
    '/qrcode_reader': (BuildContext context) => QRCodeReaderPage(
          title: 'Scan QRCode',
          onScanned: ModalRoute.of(context)?.settings.arguments as OnScanned?,
        )
  };
}

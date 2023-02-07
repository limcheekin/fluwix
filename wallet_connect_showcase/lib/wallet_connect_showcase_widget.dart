import 'dart:async';
import 'dart:convert';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect/wallet_connect.dart';
import 'eth_conversions.dart';
import 'qr_scan_view.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore_for_file: todo
class WalletConnectShowcaseWidget extends StatefulWidget {
  const WalletConnectShowcaseWidget({Key? key}) : super(key: key);

  @override
  _WalletConnectShowcaseWidgetState createState() =>
      _WalletConnectShowcaseWidgetState();
}

const maticRpcUri =
    'https://rpc-mainnet.maticvigil.com/v1/140d92ff81094f0f3d7babde06603390d7e581be';

enum MenuItems {
  previousSession,
  killSession,
  scanQR,
  pasteCode,
  clearCache,
}

class _WalletConnectShowcaseWidgetState
    extends State<WalletConnectShowcaseWidget> {
  late WCClient _wcClient;
  late SharedPreferences _prefs;
  late WebViewController _webViewController;
  late TextEditingController _textEditingController;
  late String walletAddress, privateKey;
  bool connected = false;
  WCSessionStore? _sessionStore;
  final _web3client = Web3Client(
    maticRpcUri,
    http.Client(),
  );

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize() async {
    _wcClient = WCClient(
      onSessionRequest: _onSessionRequest,
      onFailure: _onSessionError,
      onDisconnect: _onSessionClosed,
      onEthSign: _onSign,
      onEthSignTransaction: _onSignTransaction,
      onEthSendTransaction: _onSendTransaction,
      onCustomRequest: (_, __) {},
      onConnect: _onConnect,
    );
    // TODO: Mention walletAddress and privateKey while connecting
    walletAddress = '';
    privateKey = '';
    _textEditingController = TextEditingController();
    _prefs = await SharedPreferences.getInstance();
    WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<MenuItems>(
            onSelected: (item) {
              switch (item) {
                case MenuItems.previousSession:
                  _connectToPreviousSession();
                  break;
                case MenuItems.killSession:
                  _wcClient.killSession();
                  break;
                case MenuItems.scanQR:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QRScanView()),
                  ).then((value) {
                    if (value != null) {
                      _qrScanHandler(value);
                    }
                  });
                  break;
                case MenuItems.pasteCode:
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'Paste Code',
                      pageBuilder: (context, _, __) {
                        return SimpleDialog(
                          title: const Text('Paste code to connect'),
                          titlePadding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, .0),
                          contentPadding: const EdgeInsets.all(16.0),
                          children: [
                            TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Enter Code'),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('CONTINUE'),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).then((_) {
                    if (_textEditingController.text.isNotEmpty) {
                      _qrScanHandler(_textEditingController.text);
                      _textEditingController.clear();
                    }
                  });
                  break;
                case MenuItems.clearCache:
                  _onClearCache(_webViewController, context);
                  break;
              }
            },
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  value: MenuItems.previousSession,
                  child: Text('Connect Previous Session'),
                ),
                const PopupMenuItem(
                  value: MenuItems.killSession,
                  child: Text('Kill Session'),
                ),
                const PopupMenuItem(
                  value: MenuItems.scanQR,
                  child: Text('Connect via QR'),
                ),
                const PopupMenuItem(
                  value: MenuItems.pasteCode,
                  child: Text('Connect via Code'),
                ),
                const PopupMenuItem(
                  value: MenuItems.clearCache,
                  child: Text('Clear Cache'),
                ),
              ];
            },
          ),
        ),
        Expanded(
          child: WebView(
            initialUrl: 'https://example.walletconnect.org',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
          ),
        ),
      ],
    );
  }

  Future<void> _onClearCache(
      WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cache cleared.'),
    ));
  }

  _qrScanHandler(String value) {
    final session = WCSession.from(value);
    debugPrint('session $session');
    final peerMeta = WCPeerMeta(
      name: "Example Wallet",
      url: "https://example.wallet",
      description: "Example Wallet",
      icons: [
        "https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png"
      ],
    );
    _wcClient.connectNewSession(session: session, peerMeta: peerMeta);
  }

  _connectToPreviousSession() {
    final _sessionSaved = _prefs.getString('session');
    debugPrint('_sessionSaved $_sessionSaved');
    _sessionStore = _sessionSaved != null
        ? WCSessionStore.fromJson(jsonDecode(_sessionSaved))
        : null;
    if (_sessionStore != null) {
      debugPrint('_sessionStore $_sessionStore');
      _wcClient.connectFromSessionStore(_sessionStore!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No previous session found.'),
      ));
    }
  }

  _onConnect() {
    setState(() {
      connected = true;
    });
  }

  _onSessionRequest(int id, WCPeerMeta peerMeta) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Column(
            children: [
              if (peerMeta.icons.isNotEmpty)
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(peerMeta.icons.first),
                ),
              Text(peerMeta.name),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            if (peerMeta.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(peerMeta.description),
              ),
            if (peerMeta.url.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Connection to ${peerMeta.url}'),
              ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      _wcClient.approveSession(
                        accounts: [walletAddress],
                        // TODO: Mention Chain ID while connecting
                        chainId: 1,
                      );
                      _sessionStore = _wcClient.sessionStore;
                      await _prefs.setString('session',
                          jsonEncode(_wcClient.sessionStore.toJson()));
                      Navigator.pop(context);
                    },
                    child: const Text('APPROVE'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      _wcClient.rejectSession();
                      Navigator.pop(context);
                    },
                    child: const Text('REJECT'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onSessionError(dynamic message) {
    setState(() {
      connected = false;
    });
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Error"),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Some Error Occured. $message'),
            ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CLOSE'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onSessionClosed(int? code, String? reason) {
    _prefs.remove('session');
    setState(() {
      connected = false;
    });
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Session Ended"),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Some Error Occured. ERROR CODE: $code'),
            ),
            if (reason != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Failure Reason: $reason'),
              ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CLOSE'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onSignTransaction(
    int id,
    WCEthereumTransaction ethereumTransaction,
  ) {
    _onTransaction(
      id: id,
      ethereumTransaction: ethereumTransaction,
      title: 'Sign Transaction',
      onConfirm: () async {
        final creds = EthPrivateKey.fromHex(privateKey);
        final tx = await _web3client.signTransaction(
          creds,
          _wcEthTxToWeb3Tx(ethereumTransaction),
          chainId: _wcClient.chainId!,
        );
        // final txhash = await _web3client.sendRawTransaction(tx);
        // debugPrint('txhash $txhash');
        _wcClient.approveRequest<String>(
          id: id,
          result: bytesToHex(tx),
        );
        Navigator.pop(context);
      },
      onReject: () {
        _wcClient.rejectRequest(id: id);
        Navigator.pop(context);
      },
    );
  }

  _onSendTransaction(
    int id,
    WCEthereumTransaction ethereumTransaction,
  ) {
    _onTransaction(
      id: id,
      ethereumTransaction: ethereumTransaction,
      title: 'Send Transaction',
      onConfirm: () async {
        final creds = EthPrivateKey.fromHex(privateKey);
        final txhash = await _web3client.sendTransaction(
          creds,
          _wcEthTxToWeb3Tx(ethereumTransaction),
          chainId: _wcClient.chainId!,
        );
        debugPrint('txhash $txhash');
        _wcClient.approveRequest<String>(
          id: id,
          result: txhash,
        );
        Navigator.pop(context);
      },
      onReject: () {
        _wcClient.rejectRequest(id: id);
        Navigator.pop(context);
      },
    );
  }

  _onTransaction({
    required int id,
    required WCEthereumTransaction ethereumTransaction,
    required String title,
    required VoidCallback onConfirm,
    required VoidCallback onReject,
  }) async {
    ContractFunction? contractFunction;
    BigInt gasPrice = BigInt.parse(ethereumTransaction.gasPrice ?? '0');
    try {
      final abiUrl =
          'https://api.polygonscan.com/api?module=contract&action=getabi&address=${ethereumTransaction.to}&apikey=BCER1MXNFHP1TVE93CMNVKC5J4FV8R4CPR';
      final res = await http.get(Uri.parse(abiUrl));
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      final abi = ContractAbi.fromJson(resMap['result'], '');
      final contract = DeployedContract(
          abi, EthereumAddress.fromHex(ethereumTransaction.to!));
      final dataBytes = hexToBytes(ethereumTransaction.data!);
      final funcBytes = dataBytes.take(4).toList();
      debugPrint("funcBytes $funcBytes");
      final maibiFunctions = contract.functions
          .where((element) => listEquals<int>(element.selector, funcBytes));
      if (maibiFunctions.isNotEmpty) {
        debugPrint("isNotEmpty");
        contractFunction = maibiFunctions.first;
        debugPrint("function ${contractFunction.name}");
        // contractFunction.parameters.forEach((element) {
        //   debugPrint("params ${element.name} ${element.type.name}");
        // });
        // final params = dataBytes.sublist(4).toList();
        // debugPrint("params $params ${params.length}");
      }
      if (gasPrice == BigInt.zero) {
        gasPrice = await _web3client.estimateGas();
      }
    } catch (e, trace) {
      debugPrint("failed to decode\n$e\n$trace");
    }
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Column(
            children: [
              if (_wcClient.remotePeerMeta!.icons.isNotEmpty)
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(_wcClient.remotePeerMeta!.icons.first),
                ),
              Text(
                _wcClient.remotePeerMeta!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Receipient',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    ethereumTransaction.to!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Transaction Fee',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${EthConversions.weiToEthUnTrimmed(gasPrice * BigInt.parse(ethereumTransaction.gas ?? '0'), 18)} MATIC',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Transaction Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${EthConversions.weiToEthUnTrimmed(BigInt.parse(ethereumTransaction.value ?? '0'), 18)} MATIC',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            if (contractFunction != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Function',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      contractFunction.name,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: const Text(
                    'Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  children: [
                    Text(
                      ethereumTransaction.data!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: onConfirm,
                    child: const Text('CONFIRM'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: onReject,
                    child: const Text('REJECT'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onSign(
    int id,
    WCEthereumSignMessage ethereumSignMessage,
  ) {
    final decoded = (ethereumSignMessage.type == WCSignType.TYPED_MESSAGE)
        ? ethereumSignMessage.data!
        : ascii.decode(hexToBytes(ethereumSignMessage.data!));
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Column(
            children: [
              if (_wcClient.remotePeerMeta!.icons.isNotEmpty)
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(_wcClient.remotePeerMeta!.icons.first),
                ),
              Text(
                _wcClient.remotePeerMeta!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text(
                'Sign Message',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: const Text(
                    'Message',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  children: [
                    Text(
                      decoded,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      String signedDataHex;
                      if (ethereumSignMessage.type ==
                          WCSignType.TYPED_MESSAGE) {
                        signedDataHex = EthSigUtil.signTypedData(
                          privateKey: privateKey,
                          jsonData: ethereumSignMessage.data!,
                          version: TypedDataVersion.V4,
                        );
                      } else {
                        final creds = EthPrivateKey.fromHex(privateKey);
                        final encodedMessage =
                            hexToBytes(ethereumSignMessage.data!);
                        final signedData =
                            await creds.signPersonalMessage(encodedMessage);
                        signedDataHex = bytesToHex(signedData, include0x: true);
                      }
                      debugPrint('SIGNED $signedDataHex');
                      _wcClient.approveRequest<String>(
                        id: id,
                        result: signedDataHex,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('SIGN'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      _wcClient.rejectRequest(id: id);
                      Navigator.pop(context);
                    },
                    child: const Text('REJECT'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Transaction _wcEthTxToWeb3Tx(WCEthereumTransaction ethereumTransaction) {
    return Transaction(
      from: EthereumAddress.fromHex(ethereumTransaction.from),
      to: EthereumAddress.fromHex(ethereumTransaction.to!),
      maxGas: ethereumTransaction.gasLimit != null
          ? int.tryParse(ethereumTransaction.gasLimit!)
          : null,
      gasPrice: ethereumTransaction.gasPrice != null
          ? EtherAmount.inWei(BigInt.parse(ethereumTransaction.gasPrice!))
          : null,
      value: EtherAmount.inWei(BigInt.parse(ethereumTransaction.value ?? '0')),
      data: hexToBytes(ethereumTransaction.data!),
      nonce: ethereumTransaction.nonce != null
          ? int.tryParse(ethereumTransaction.nonce!)
          : null,
    );
  }
}

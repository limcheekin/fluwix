import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherShowcaseWidget extends StatefulWidget {
  UrlLauncherShowcaseWidget({Key? key}) : super(key: key);

  @override
  _UrlLauncherShowcaseWidgetState createState() =>
      _UrlLauncherShowcaseWidgetState();
}

class _UrlLauncherShowcaseWidgetState extends State<UrlLauncherShowcaseWidget> {
  Future<void>? _launched;
  String _phone = '';
  String _toLaunch = 'https://www.cylog.org/headers/';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (String text) => _phone = text,
                decoration: const InputDecoration(
                  hintText: 'Enter the phone number to call',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _makePhoneCall('tel:$_phone');
              }),
              child: const Text('Make phone call'),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                initialValue: _toLaunch,
                onChanged: (String text) => _toLaunch = text,
                decoration: const InputDecoration(
                  hintText: 'Enter the URL to launch',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Link(
                uri: Uri.parse(_toLaunch),
                builder: (BuildContext context,
                        Future<void> Function()? followLink) =>
                    TextButton(
                  onPressed: followLink,
                  child: Text(
                    'Link class: $_toLaunch',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => setState(() {
                _launched = _launchInBrowser(_toLaunch);
              }),
              child: Text(
                _toLaunch,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _launchInWebViewOrVC(_toLaunch);
              }),
              child: const Text('Launch in app'),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _launchInWebViewWithJavaScript(_toLaunch);
              }),
              child: const Text('Launch in app(JavaScript ON)'),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _launchInWebViewWithDomStorage(_toLaunch);
              }),
              child: const Text('Launch in app(DOM storage ON)'),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _launchUniversalLinkIos(_toLaunch);
              }),
              child: const Text(
                  'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () => setState(() {
                _launched = _launchInWebViewOrVC(_toLaunch);
                Timer(const Duration(seconds: 5), () {
                  print('Closing WebView after 5 seconds...');
                  closeWebView();
                });
              }),
              child: const Text('Launch in app + close after 5 seconds'),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
      ],
    );
  }
}

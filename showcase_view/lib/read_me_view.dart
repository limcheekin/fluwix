import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:source_code_view/abstract_github_view.dart';
import 'package:source_code_view/multiple_requests_http_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadMeView extends AbstractGithubView {
  const ReadMeView({
    @required String owner,
    @required String repository,
    @required String ref,
    @required String path,
    MultipleRequestsHttpClient client,
    bool wantKeepAlive = true,
    Key key,
  }) : super(
          owner: owner,
          repository: repository,
          ref: ref,
          path: path,
          client: client,
          wantKeepAlive: wantKeepAlive,
          key: key,
        );
  @override
  _ReadMeViewState createState() => _ReadMeViewState();
}

class _ReadMeViewState extends AbstractGithubViewState<ReadMeView> {
  static const CORS_PROXY = 'https://cors.bridged.cc/';
  @override
  Widget buildWidget(BuildContext context, String responseBody) {
    return Expanded(
      child: Markdown(
        data: _addCorsProxyToImageUrls(responseBody),
        selectable: true,
        onTapLink: _onTapLink,
      ),
    );
  }

  String _addCorsProxyToImageUrls(String responseBody) {
    if (!kIsWeb) return responseBody;

    final lines = LineSplitter.split(responseBody);
    var body = '';
    final exp = RegExp(
        r'(https?):\/\/[\w/\-?=%.]+\.[\w/\-?=%.]+(?:gif|png|jpg)',
        caseSensitive: false);
    lines.forEach((line) {
      final matches = exp.allMatches(line);
      if (matches.isNotEmpty) {
        matches.forEach((match) {
          final imageUrl = line.substring(match.start, match.end);
          line = line.replaceAll(imageUrl, CORS_PROXY + imageUrl);
        });
      }
      body += '$line\n';
    });
    return body;
  }

  void _onTapLink(String text, String href, String title) {
    print('text $text');
    print('href $href');
    _launchInBrowser(href);
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

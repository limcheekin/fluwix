import 'package:flutter/material.dart';
import 'package:flutter_widgets_explorer/common/presentation/widgets/center_text.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// This is the stateless widget that the main application instantiates.
class AboutScreen extends StatelessWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      Text(
        'Learn, test and showcase flutter widgets in one application.',
        style: textStyle,
      ),
    ];

    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final packageInfo = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('About'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Logo(),
                        applicationName: packageInfo.appName,
                        applicationVersion: packageInfo.version,
                        applicationLegalese:
                            '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                        children: aboutBoxChildren,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: AboutListTile(
                      icon: Icon(Icons.info),
                      applicationIcon: Logo(),
                      applicationName: packageInfo.appName,
                      applicationVersion: packageInfo.version,
                      applicationLegalese:
                          '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                      aboutBoxChildren: aboutBoxChildren,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CenterText(
                    'Click the info icon on the top right of the screen '
                    'or drawer item to open the about dialog'),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Text('Something is wrong');
        });
  }
}

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/about/images/logo_bright.png',
        width: 48,
        height: 48,
      ),
    );
  }
}

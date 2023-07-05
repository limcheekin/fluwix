import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:showcase_view/showcase_view.dart';

class AboutDialogScreen extends StatelessWidget {
  const AboutDialogScreen({Key? key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'about_dialog';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'About Dialog',
      widget: AboutDialogWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: '$branch/README.md',
      codePaths: [
        '$branch/pubspec.yaml',
        '$branch/lib/about_dialog_screen.dart',
      ],
    );
  }
}

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final aboutBoxChildren = <Widget>[
      const SizedBox(height: 24),
      Text(
        'Learn and showcase Flutter Widgets in one application.',
        style: textStyle,
      ),
    ];

    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final packageInfo = snapshot.data;
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About (Custom)'),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: const Logo(),
                      applicationName: packageInfo!.appName,
                      applicationVersion: packageInfo.version,
                      applicationLegalese:
                          '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                      children: aboutBoxChildren,
                    );
                  },
                ),
                AboutListTile(
                  icon: const Icon(Icons.info),
                  applicationIcon: const Logo(),
                  applicationName: packageInfo!.appName,
                  applicationVersion: packageInfo.version,
                  applicationLegalese:
                      '\u{a9} ${DateTime.now().year} Lim Chee Kin',
                  aboutBoxChildren: aboutBoxChildren,
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'packages/about_dialog/assets/logo_bright.png',
        width: 48,
        height: 48,
      ),
    );
  }
}

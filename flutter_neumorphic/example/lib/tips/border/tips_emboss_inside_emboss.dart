import 'package:example/lib/Code.dart';
import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TipsRecursiveeEmbossPage extends StatefulWidget {
  const TipsRecursiveeEmbossPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<TipsRecursiveeEmbossPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.6,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Emboss Recursive",
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _EmbossmbossWidget(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmbossmbossWidget extends StatefulWidget {
  @override
  createState() => _EmbossmbossWidgetState();
}

class _EmbossmbossWidgetState extends State<_EmbossmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
 Widget _generateEmbosss({int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for (int i = 0; i < number; ++i) {
      element = Neumorphic(
        padding: EdgeInsets.all(20),
        boxShape: NeumorphicBoxShape.circle(),
        style: NeumorphicStyle(
          depth: -(NeumorphicTheme.depth(context).abs()), //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }
""");
  }

  Widget _generateEmbosss(
      {int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for (int i = 0; i < number; ++i) {
      element = Neumorphic(
        padding: const EdgeInsets.all(20),
        style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          depth: -(NeumorphicTheme.depth(context).abs()), //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 5,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 5,
                    reverseEachPair: true,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 4,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 4,
                    reverseEachPair: true,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

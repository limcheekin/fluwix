import '../../util/code.dart';
import '../../util/color_selector.dart';
import '../../util/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'dart:math' show Random;

class ProgressWidgetPage extends StatefulWidget {
  const ProgressWidgetPage({Key? key}) : super(key: key);

  @override
  State<ProgressWidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ProgressWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: const TopBar(
          title: 'Progress',
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              _ColorWidget(),
              _SizedWidget(),
              _DurationWidget(),
              _CurveWidget(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  State createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code('''
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
  ),
),
''');
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            'Default',
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
            ),
          ),
          const SizedBox(width: 12),
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
        TextButton(
          onPressed: () {
            setState(() {
              percent = Random().nextDouble();
            });
          },
          child: const Text('Update'),
        ),
        _buildCode(context),
      ],
    );
  }
}

class _ColorWidget extends StatefulWidget {
  @override
  State createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  double percent = 0.5;

  Widget _buildCode(BuildContext context) {
    return const Code('''
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      percent: percent,
  ),
),
''');
  }

  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('Accent : '),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              const SizedBox(width: 12),
              const Text('Variant : '),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                'Default',
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  style: ProgressStyle(
                    accent: accent,
                    variant: variant,
                  ),
                  percent: percent,
                ),
              ),
              const SizedBox(width: 12),
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

class _SizedWidget extends StatefulWidget {
  @override
  State createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {
  double percent = 0.5;

  Widget _buildCode(BuildContext context) {
    return const Code('''
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      height: 30,
      percent: percent,
  ),
),
''');
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                'Sized',
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  height: 30,
                  percent: percent,
                ),
              ),
              const SizedBox(width: 12),
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

class _DurationWidget extends StatefulWidget {
  @override
  State createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code('''
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      duration: Duration(seconds: 1),
  ),
),
''');
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            'Duration',
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
              duration: const Duration(seconds: 1),
            ),
          ),
          const SizedBox(width: 12),
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
        TextButton(
          onPressed: () {
            setState(() {
              percent = Random().nextDouble();
            });
          },
          child: const Text('Update'),
        ),
        _buildCode(context),
      ],
    );
  }
}

class _CurveWidget extends StatefulWidget {
  @override
  State createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code('''
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      curve: Curves.bounceOut,
  ),
),
''');
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            'Curve',
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
              curve: Curves.bounceOut,
            ),
          ),
          const SizedBox(width: 12),
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
        TextButton(
          onPressed: () {
            setState(() {
              percent = Random().nextDouble();
            });
          },
          child: const Text('Update'),
        ),
        _buildCode(context),
      ],
    );
  }
}

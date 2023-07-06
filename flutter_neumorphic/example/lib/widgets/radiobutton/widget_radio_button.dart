import 'package:example/lib/Code.dart';
import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RadioButtonWidgetPage extends StatefulWidget {
  const RadioButtonWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<RadioButtonWidgetPage> {
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
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Radios",
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
              _DefaultWidget(),
              const CircleRadios(),
              _EnabledDisabledWidget(),
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
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  int groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
    groupValue: groupValue
    value: 1991,
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("2012"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            //uncomment to test colors
            //style: NeumorphicRadioStyle(
            //  selectedColor: Colors.black,
            //  unselectedColor: Colors.blue
            //),
            groupValue: groupValue,
            value: 1991,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(8.0),
            child: const Text("1991"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            value: 2000,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(8.0),
            child: const Text("2000"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 2012,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(8.0),
            child: const Text("2012"),
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

class CircleRadios extends StatefulWidget {
  const CircleRadios({Key? key}) : super(key: key);

  @override
  createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {
  String groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
String groupValue;

NeumorphicRadio(
    groupValue: groupValue
    style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
    value: "A",
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("A"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            value: "A",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("A"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            value: "B",
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("B"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            value: "C",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("C"),
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

class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  int groupValue;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: const Text("First"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
          const SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isEnabled: false,
            groupValue: groupValue,
            value: 2,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: const Text("Second"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""    
int groupValue;

NeumorphicRadio(
     isEnabled: false,
     groupValue: groupValue,
     value: 2,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
     child: Text("Second"),
),
""");
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

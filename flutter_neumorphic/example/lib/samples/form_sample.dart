import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FormSample extends StatelessWidget {
  const FormSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: 8,
        intensity: 0.65,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class __PageState extends State<_Page> {
  String firstName = "";
  String lastName = "";
  double age = 12;
  Gender gender;
  Set<String> rides = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: TopBar(
                actions: <Widget>[
                  ThemeConfigurator(),
                ],
              ),
            ),
            Neumorphic(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: NeumorphicButton(
                      onPressed: _isButtonEnabled() ? () {} : null,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  _AvatarField(),
                  const SizedBox(
                    height: 8,
                  ),
                  _TextField(
                    label: "First name",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.firstName = firstName;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _TextField(
                    label: "Last name",
                    hint: "",
                    onChanged: (lastName) {
                      setState(() {
                        this.lastName = lastName;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _AgeField(
                    age: age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _GenderField(
                    gender: gender,
                    onChanged: (gender) {
                      setState(() {
                        this.gender = gender;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  /*
                  _RideField(
                    rides: this.rides,
                    onChanged: (rides) {
                      setState(() {
                        this.rides = rides;
                      });
                    },
                  ),
                  SizedBox(
                    height: 28,
                  ),
                   */
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isButtonEnabled() {
    return firstName.isNotEmpty && lastName.isNotEmpty;
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        padding: const EdgeInsets.all(10),
        style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          depth: NeumorphicTheme.embossDepth(context),
        ),
        child: Icon(
          Icons.insert_emoticon,
          size: 120,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _AgeField extends StatelessWidget {
  final double age;
  final ValueChanged<double> onChanged;

  const _AgeField({@required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: NeumorphicSlider(
                  min: 8,
                  max: 75,
                  value: age,
                  onChanged: (value) {
                    onChanged(value);
                  },
                ),
              ),
            ),
            Text("${age.floor()}"),
            const SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  const _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: const NeumorphicBoxShape.stadium(),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: widget.hint),
          ),
        )
      ],
    );
  }
}

class _GenderField extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const _GenderField({
    @required this.gender,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Gender",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: const EdgeInsets.all(20),
              style: const NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.MALE,
              child: const Icon(Icons.account_box),
              onChanged: (value) => onChanged(value),
            ),
            const SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: const EdgeInsets.all(20),
              style: const NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.FEMALE,
              child: const Icon(Icons.pregnant_woman),
              onChanged: (value) => onChanged(value),
            ),
            const SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: const EdgeInsets.all(20),
              style: const NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.NON_BINARY,
              child: const Icon(Icons.supervised_user_circle),
              onChanged: (value) => onChanged(value),
            ),
            const SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

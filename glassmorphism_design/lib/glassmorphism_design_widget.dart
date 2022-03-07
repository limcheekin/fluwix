import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

final String likes = '67',
    gotpoints = '130',
    popularity = '83',
    totalPoints = '130',
    details = 'A Flutter Glassmorphic UI package',
    pac = 'glassmorphism: ^3.0.0',
    date = 'Mar 7, 2022';

class GlassmorphismDesignWidget extends StatefulWidget {
  GlassmorphismDesignWidget({Key? key}) : super(key: key);

  @override
  _GlassmorphismDesignWidgetState createState() =>
      _GlassmorphismDesignWidgetState();
}

class _GlassmorphismDesignWidgetState extends State<GlassmorphismDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('packages/glassmorphism_design/assets/bg.png')
                  .image,
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
                child: GlassmorphicContainer(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.9,
                    borderRadius: 40,
                    blur: 7,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF75035).withAlpha(55),
                          Color(0xFFffffff).withAlpha(45),
                        ],
                        stops: [
                          0.3,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFF4579C5).withAlpha(100),
                          Color(0xFFFFFFFF).withAlpha(55),
                          Color(0xFFF75035).withAlpha(10),
                        ],
                        stops: [
                          0.06,
                          0.95,
                          1
                        ]),
                    child: Container(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            bottom:
                                MediaQuery.of(context).size.height * 0.3 - 70,
                            left: 40,
                            child: Container(
                              width: 100,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color(0xFFBC1642),
                                  Color(0xFFCB5AC6),
                                ]),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 30,
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                gradient: LinearGradient(colors: [
                                  Color(0xFFFDFC47),
                                  Color(0xFF24FE41),
                                ]),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.015,
                            left: MediaQuery.of(context).size.width * 0.025,
                            child: GlassCard(context),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.41,
                            child: InkWell(
                              onTap: () {
                                // launchTFF();
                              },
                              child: Image.asset(
                                'packages/glassmorphism_design/assets/logo.png',
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.52 + 10,
                left: MediaQuery.of(context).size.width * 0.05 + 10,
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width * 0.9 - 20,
                  height: MediaQuery.of(context).size.height * 0.4 - 20,
                  borderRadius: 35,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFFFF).withAlpha(0),
                        Color(0xFFFFFFFF).withAlpha(0),
                      ],
                      stops: [
                        0.3,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFFFF).withAlpha(01),
                        Color(0xFFFFFFFF).withAlpha(100),
                        Color(0xFFFFFFFF).withAlpha(01),
                      ],
                      stops: [
                        0.2,
                        0.9,
                        1,
                      ]),
                  child: Body2(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget GlassCard(var context) {
  final size = MediaQuery.of(context).size;
  return Column(
    children: [
      GlassmorphicContainer(
          width: size.width * 0.75 + (size.width * 0.10),
          height: size.height * 0.4 - 20,
          borderRadius: 35,
          blur: 14,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x0FF0FFFF).withOpacity(0.2),
              Color(0x0FF0FFFF).withOpacity(0.2),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x0FF0FFFF).withOpacity(1),
              Color(0x0FFFFFFF),
              Color(0x0FF0FFFF).withOpacity(1),
            ],
          ),
          child: Column(
            key: UniqueKey(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: size.height * 0.001),
              Image.asset(
                'packages/glassmorphism_design/assets/pub-dev-logo-2x.png',
                scale: 1.7,
              ),
              InkWell(
                onTap: () {
                  // launchPubDev();
                },
                child: Text(
                  pac,
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Published on $date',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'by Ritick Saha\n(The Flutter Foundry)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: size.height * 0.001),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '$likes',
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\nLikes',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 15.0,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '$gotpoints',
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '/$totalPoints',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: '\n    Pub Point',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 15.0,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' $popularity%',
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\nPopularity',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 15.0,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.001),
              Text(
                '$details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontStyle: FontStyle.italic,
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: size.height * 0.001),
            ],
          )),
    ],
  );
}

class Body2 extends StatelessWidget {
  const Body2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Sign In',
          style: TextStyle(
            fontFamily: 'Futura Md BT',
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'An example Use Case Of GlassmorphicContainer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Futura Md BT',
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 0.5),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              'Your Email',
              style: TextStyle(
                fontFamily: 'Futura Md BT',
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 0.5),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              'Password',
              style: TextStyle(
                fontFamily: 'Futura Md BT',
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Next',
              style: TextStyle(
                fontFamily: 'Futura Md BT',
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            ClipOval(
              child: Container(
                height: 50,
                width: 50,
                color: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

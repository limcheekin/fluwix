import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CreditCardSample extends StatefulWidget {
  @override
  createState() => _CreditCardSampleState();
}

class _CreditCardSampleState extends State<CreditCardSample> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
          intensity: 0.6, lightSource: LightSource.topLeft, depth: 5),
      child: Scaffold(
        body: SafeArea(
          child: NeumorphicBackground(child: _PageContent()),
        ),
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  @override
  __PageContentState createState() => __PageContentState();
}

class __PageContentState extends State<_PageContent> {
  int _dotIndex = 1;
  bool _useDark = false;

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      borderRadius: BorderRadius.circular(12),
      margin: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 14),
          _buildTopBar(context),
          SizedBox(height: 30),
          Expanded(child: _buildCard(context)),
          SizedBox(height: 30),
          _buildDots(context),
          SizedBox(height: 30),
          _buildBalance(context),
          SizedBox(height: 30),
          _buildIndicator(context),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 10,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          shape: NeumorphicShape.flat,
        ),
        child: Neumorphic(
          margin: EdgeInsets.all(8),
          style: NeumorphicStyle(
            depth: 10,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            shape: NeumorphicShape.flat,
          ),
          child: SizedBox(
            height: 200,
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  //Image.asset("assets/images/map.jpg", fit: BoxFit.cover),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Colors.purple.withOpacity(0.5),
                            Colors.red.withOpacity(0.5)
                          ])),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        top: 12,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "VISA",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "1234 5678",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "1234 5678",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 16,
                        child: SizedBox(
                          height: 60,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 5,
                              intensity: 0.8,
                              lightSource: LightSource.topLeft,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12),
                              ),
                            ),
                            child: RotatedBox(
                                quarterTurns: 1,
                                child: Image.asset(
                                    "assets/images/credit_card_chip.png")),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 16,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "09/24",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Stack(
                              children: <Widget>[
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.convex,
                                      depth: -10,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: Colors.grey[300]),
                                  child: const SizedBox(
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: 10),
                                    child: const SizedBox(
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.navigate_before),
              ),
            ),
          ),
          Align(alignment: Alignment.center, child: Text("Card")),
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              onPressed: () {
                setState(() {
                  _useDark = !_useDark;

                  NeumorphicTheme.of(context).themeMode =
                      _useDark ? ThemeMode.dark : ThemeMode.light;
                });
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.loop),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Balance",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Color(0xFF3E3E3E)))),
          Align(
              alignment: Alignment.centerRight,
              child: Text("\$ 14,020.44",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF3E3E3E)))),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          NeumorphicIndicator(
            percent: 0.3,
            padding: EdgeInsets.all(3),
            orientation: NeumorphicIndicatorOrientation.horizontal,
            height: 20,
            style: IndicatorStyle(
              accent: Colors.grey[100],
              variant: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft, child: Text("Credit limit")),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text("\$ 220 / \$ 1000")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDots(BuildContext context) {
    final double dotsSize = 18;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex,
            value: 0,
            onChanged: (value) {
              setState(() {
                _dotIndex = value;
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.convex,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex,
            value: 1,
            onChanged: (value) {
              setState(() {
                _dotIndex = value;
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.convex,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex,
            value: 2,
            onChanged: (value) {
              setState(() {
                _dotIndex = value;
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.convex,
            ),
          ),
        )
      ],
    );
  }
}

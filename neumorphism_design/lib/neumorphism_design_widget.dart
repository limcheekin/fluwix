import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'accessibility/neumorphic_accessibility.dart';
import 'playground/neumorphic_playground.dart';
import 'playground/text_playground.dart';
import 'samples/sample_home.dart';
import 'tips/tips_home.dart';
import 'widgets/widgets_home.dart';

class FullSampleHomePage extends StatelessWidget {
  const FullSampleHomePage({Key? key}) : super(key: key);

  Widget _buildButton({required String text, required VoidCallback onClick}) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        //border: NeumorphicBorder(
        //  isEnabled: true,
        //  width: 0.3,
        //),
        shape: NeumorphicShape.flat,
      ),
      onPressed: onClick,
      child: Center(child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: Scrollbar(
            thumbVisibility: kIsWeb,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildButton(
                      text: 'Neumorphic Playground',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const NeumorphicPlayground();
                        }));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildButton(
                      text: 'Text Playground',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const NeumorphicTextPlayground();
                        }));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: 'Samples',
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SamplesHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: 'Widgets',
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const WidgetsHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: 'Tips',
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const TipsHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: 'Accessibility',
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const NeumorphicAccessibility();
                          }));
                        }),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import '../util/top_bar.dart';
import 'audio_player_sample.dart';
import 'calculator_sample.dart';
import 'clock/clock_sample.dart';
import 'credit_card_sample.dart';
import 'form_sample.dart';
import 'testla_sample.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'galaxy_sample.dart';
import 'widgets_sample.dart';

class SamplesHome extends StatelessWidget {
  const SamplesHome({Key? key}) : super(key: key);

  Widget _buildButton({required String text, required VoidCallback onClick}) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      onPressed: onClick,
      child: Center(child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(depth: 8),
      darkTheme: const NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TopBar(),
                  _buildButton(
                      text: 'Tesla',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const TeslaSample();
                        }));
                      }),
                  _buildButton(
                      text: 'Audio Player',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const AudioPlayerSample();
                        }));
                      }),
                  _buildButton(
                      text: 'Clock',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ClockSample();
                        }));
                      }),
                  _buildButton(
                      text: 'Galaxy',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const GalaxySample();
                        }));
                      }),
                  _buildButton(
                      text: 'Calculator',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const CalculatorSample();
                        }));
                      }),
                  _buildButton(
                      text: 'Form',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const FormSample();
                        }));
                      }),
                  _buildButton(
                      text: 'CreditCard',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const CreditCardSample();
                        }));
                      }),
                  _buildButton(
                      text: 'Widgets',
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const WidgetsSample();
                        }));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

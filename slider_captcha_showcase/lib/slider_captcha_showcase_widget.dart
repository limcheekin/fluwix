import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_capchar.dart';

class SliderCaptchaShowcaseWidget extends StatefulWidget {
  const SliderCaptchaShowcaseWidget({Key? key}) : super(key: key);

  @override
  State<SliderCaptchaShowcaseWidget> createState() =>
      _SliderCaptchaShowcaseWidgetState();
}

class _SliderCaptchaShowcaseWidgetState
    extends State<SliderCaptchaShowcaseWidget> {
  final SliderController controller = SliderController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show Captcha'),
        onPressed: () => showCaptcha(context),
      ),
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Authentication successful!'),
              ],
            ),
          );
        });
  }

  void showCaptcha(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 280,
              width: 280,
              padding: const EdgeInsets.all(8.0),
              child: SliderCaptcha(
                image: Image.asset(
                  'assets/image.jpeg',
                  fit: BoxFit.fitWidth,
                  package: 'slider_captcha_showcase',
                ),
                onConfirm: (value) async {
                  debugPrint(value.toString());
                  showMyDialog(context);
                  return await Future.delayed(const Duration(seconds: 1)).then(
                    (value) {
                      controller.create.call();
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}

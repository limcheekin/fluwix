import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';

import 'slider_captcha_showcase_widget.dart';

class SliderCaptchaShowcaseScreen extends StatelessWidget {
  const SliderCaptchaShowcaseScreen({Key? key}) : super(key: key);

  static const owner = 'BrianTV98';
  static const repository = 'slider_captcha';
  static const branch = 'main';

  @override
  Widget build(BuildContext context) {
    return const ShowcaseView(
      title: 'Slider Captcha Showcase',
      widget: SliderCaptchaShowcaseWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'example/lib/main.dart',
      ],
    );
  }
}

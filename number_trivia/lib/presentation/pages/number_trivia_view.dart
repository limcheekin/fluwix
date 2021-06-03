import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../dependencies.dart';
import '../widgets/widgets.dart';
import 'number_trivia_controller.dart';

class NumberTriviaView extends View {
  @override
  _NumberTriviaViewState createState() => _NumberTriviaViewState();
}

class _NumberTriviaViewState
    extends ViewState<NumberTriviaView, NumberTriviaController> {
  _NumberTriviaViewState() : super(sl<NumberTriviaController>());

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            ControlledWidgetBuilder<NumberTriviaController>(
                builder: (context, controller) {
              if (controller.errorMessage == null &&
                  controller.numberTrivia == null) {
                return MessageDisplay(
                  message: 'Start searching!',
                );
              } else if (controller.numberTrivia != null) {
                return TriviaDisplay(
                  numberTrivia: controller.numberTrivia!,
                );
              } else if (controller.errorMessage != null) {
                return MessageDisplay(
                  message: controller.errorMessage!,
                );
              }
              return LoadingWidget();
            }),
            SizedBox(height: 20),
            // Bottom half
            TriviaControls()
          ],
        ),
      ),
    );
  }
}

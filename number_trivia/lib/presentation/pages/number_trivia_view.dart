import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../../dependencies.dart';
import '../widgets/widgets.dart';
import 'number_trivia_controller.dart';

<<<<<<< HEAD
class NumberTriviaView extends fca.View {
  NumberTriviaView({Key? key}) : super(key: key);

=======
class NumberTriviaView extends CleanView {
>>>>>>> number_trivia_flutter_clean_architecture
  @override
  _NumberTriviaViewState createState() => _NumberTriviaViewState();
}

class _NumberTriviaViewState
    extends CleanViewState<NumberTriviaView, NumberTriviaController> {
  _NumberTriviaViewState() : super(sl<NumberTriviaController>());

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
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
            const SizedBox(height: 10),
            ControlledWidgetBuilder<NumberTriviaController>(
              builder: (context, controller) {
                switch (controller.status) {
                  case EStatus.none:
                    return const MessageDisplay(
                      message: 'Start searching!',
                    );
                  case EStatus.loaded:
                    return TriviaDisplay(
                      numberTrivia: controller.numberTrivia!,
                    );
                  case EStatus.error:
                    return MessageDisplay(
                      message: controller.errorMessage!,
                    );
                  default:
                    return const LoadingWidget();
                }
              },
            ),
            const SizedBox(height: 20),
            // Bottom half
            const TriviaControls()
          ],
        ),
      ),
    );
  }
}

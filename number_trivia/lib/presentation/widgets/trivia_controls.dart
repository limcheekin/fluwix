import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:number_trivia/presentation/pages/number_trivia_controller.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: dispatchConcrete,
                child: Text('Search'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: dispatchRandom,
                child: Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    final numberTriviaController =
        FlutterCleanArchitecture.getController<NumberTriviaController>(context,
            listen: false);
    numberTriviaController.getTriviaForConcreteNumber(inputStr);
  }

  void dispatchRandom() {
    controller.clear();
    final numberTriviaController =
        FlutterCleanArchitecture.getController<NumberTriviaController>(context,
            listen: false);
    numberTriviaController.getTriviaForRandomNumber();
  }
}

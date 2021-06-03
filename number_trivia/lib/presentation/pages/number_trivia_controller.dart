import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_presenter.dart';

class NumberTriviaController extends Controller {
  final NumberTriviaPresenter numberTriviaPresenter;
  NumberTrivia? _numberTrivia;
  String? _errorMessage;

  NumberTriviaController(this.numberTriviaPresenter);

  NumberTrivia? get numberTrivia => _numberTrivia;
  String? get errorMessage => _errorMessage;

  @override
  void initListeners() {
    numberTriviaPresenter.getNumberTriviaOnNext = (NumberTrivia numberTrivia) {
      logger.fine(numberTrivia.toString());
      _numberTrivia = numberTrivia;
      _errorMessage = null;
      refreshUI();
    };

    numberTriviaPresenter.getNumberTriviaOnComplete = () {
      logger.fine('NumberTrivia retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    numberTriviaPresenter.getNumberTriviaOnError = (e) {
      logger.shout('Could not retrieve NumberTrivia: ${e.message}');
      _errorMessage = e.message;
      _numberTrivia = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getTriviaForConcreteNumber(String input) =>
      numberTriviaPresenter.getTriviaForConcreteNumber(input);

  void getTriviaForRandomNumber() =>
      numberTriviaPresenter.getTriviaForRandomNumber();

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    numberTriviaPresenter.dispose();
    super.onDisposed();
  }
}

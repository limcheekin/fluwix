import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_presenter.dart';

class NumberTriviaController extends Controller {
  final NumberTriviaPresenter numberTriviaPresenter;
  NumberTrivia? _numberTrivia;
  String? _errorMessage;
  // ignore: prefer_final_fields
  EStatus _status = EStatus.none;

  NumberTriviaController(this.numberTriviaPresenter);

  NumberTrivia? get numberTrivia => _numberTrivia;
  String? get errorMessage => _errorMessage;
  EStatus get status => _status;

  @override
  void initListeners() {
    numberTriviaPresenter.getNumberTriviaOnNext = (NumberTrivia numberTrivia) {
      logger.fine('getNumberTriviaOnNext $numberTrivia');
      _numberTrivia = numberTrivia;
      _errorMessage = null;
      _status = EStatus.loaded;
      refreshUI();
    };

    numberTriviaPresenter.getNumberTriviaOnComplete = () {
      logger.fine('NumberTrivia retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    numberTriviaPresenter.getNumberTriviaOnError = (e) {
      logger.severe('Could not retrieve NumberTrivia: ${e.message}');
      _status = EStatus.error;
      _errorMessage = e.message;
      _numberTrivia = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getTriviaForConcreteNumber(String input) {
    _status = EStatus.loading;
    refreshUI();
    numberTriviaPresenter.getTriviaForConcreteNumber(input);
  }

  void getTriviaForRandomNumber() {
    _status = EStatus.loading;
    refreshUI();
    numberTriviaPresenter.getTriviaForRandomNumber();
  }

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    numberTriviaPresenter.dispose();
    super.onDisposed();
  }
}

enum EStatus {
  none,
  loading,
  loaded,
  error,
}

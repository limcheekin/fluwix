import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, void> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Stream<NumberTrivia?>> buildUseCaseStream(void params) async {
    final controller = StreamController<NumberTrivia>();
    try {
      final numberTrivia = await repository.getRandomNumberTrivia();
      // Adding it triggers the .onNext() in the `Observer`
      controller.add(numberTrivia);
      logger.finest('GetRandomNumberTrivia successful.');
      await controller.close();
    } catch (e) {
      logger.severe('GetRandomNumberTrivia unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

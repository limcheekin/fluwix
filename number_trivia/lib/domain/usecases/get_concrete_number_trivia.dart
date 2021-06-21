import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:number_trivia/common/presentation/input_converter.dart';

import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  final InputConverter inputConverter;

  GetConcreteNumberTrivia(this.repository, this.inputConverter);

  @override
  Future<Stream<NumberTrivia>> buildUseCaseStream(Params? params) async {
    final controller = StreamController<NumberTrivia>();
    try {
      final number = inputConverter.stringToUnsignedInteger(params!.number);
      final numberTrivia = await repository.getConcreteNumberTrivia(number);
      // Adding it triggers the .onNext() in the `Observer`
      controller.add(numberTrivia);
      logger.finest('GetConcreteNumberTrivia successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetConcreteNumberTrivia unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class Params {
  final String number;

  Params({required this.number});

  @override
  String toString() {
    return 'GetConcreteNumberTrivia params: $number';
  }
}

import 'package:dartz/dartz.dart';

import '../../../../common/error/failure.dart';
import '../../../../common/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call([NoParams params]) async {
    await super.call(params);
    return await repository.getRandomNumberTrivia();
  }
}

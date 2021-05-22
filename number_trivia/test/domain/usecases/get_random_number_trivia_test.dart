import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockRepository;

  setUp(() {
    mockRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRepository);
  });

  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get trivia for the random number from the repository',
    () async {
      // setup
      when(mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      // execute
      // As random number doesn't require any parameters, we pass in NoParams.
      final result = await usecase();

      // verify
      expect(result, Right(tNumberTrivia));
      verify(mockRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

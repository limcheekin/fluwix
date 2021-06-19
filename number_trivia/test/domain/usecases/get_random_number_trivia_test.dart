import 'package:mockito/mockito.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  GetRandomNumberTrivia? usecase;
  final mockRepository = MockNumberTriviaRepository();

  setUp(() {
    usecase = GetRandomNumberTrivia(mockRepository);
  });

  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get trivia for the random number from the repository',
    () async {
      // setup
      when(mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTrivia);

      // execute
      // As random number doesn't require any parameters, we pass in NoParams.
      final result = await usecase!.buildUseCaseStream(null);

      // verify
      expect(await result.single, tNumberTrivia);
      verify(mockRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

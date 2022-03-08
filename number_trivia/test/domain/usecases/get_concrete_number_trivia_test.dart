import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/common/presentation/input_converter.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRepository,
  InputConverter,
])
void main() {
  GetConcreteNumberTrivia? usecase;
  final mockRepository = MockNumberTriviaRepository();
  final mockInputConverter = MockInputConverter();

  setUp(() {
    usecase = GetConcreteNumberTrivia(mockRepository, mockInputConverter);
  });

  const tNumber = 1;
  const tNumberString = '1';
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get trivia for the number from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTrivia);
      when(mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(tNumber);
      // The "act" phase of the test. Call the not-yet-existent method.
      final result =
          await usecase!.buildUseCaseStream(Params(number: tNumberString));
      // UseCase should simply return whatever was returned from the Repository
      expect(await result.single, tNumberTrivia);
      // Verify that the method has been called on the Repository
      verify(mockRepository.getConcreteNumberTrivia(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

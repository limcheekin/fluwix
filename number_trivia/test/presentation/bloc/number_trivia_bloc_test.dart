import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/common/error/failure.dart';
import 'package:number_trivia/common/presentation/input_converter.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  InputConverter,
])
void main() {
  NumberTriviaBloc? bloc;
  final mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
  final mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
  final mockInputConverter = MockInputConverter();

  setUp(() {
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc!.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Error] when the input is invalid',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Error(message: NumberTriviaBloc.INVALID_INPUT_FAILURE_MESSAGE),
      ],
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc!.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Error(message: NumberTriviaBloc.SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Loading(),
        Error(message: NumberTriviaBloc.CACHE_FAILURE_MESSAGE),
      ],
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc!.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia());
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Error(message: NumberTriviaBloc.SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc!;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        Error(message: NumberTriviaBloc.CACHE_FAILURE_MESSAGE),
      ],
    );
  });
}

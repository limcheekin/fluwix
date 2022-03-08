import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:number_trivia/data/datasources/number_trivia_local_data_source.dart';

import '../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  NumberTriviaLocalDataSourceImpl? dataSource;
  final mockSharedPreferences = MockSharedPreferences();

  setUp(() {
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTrivia =
        NumberTrivia.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences
                .getString(NumberTriviaLocalDataSource.cachedNumberTrivia))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource!.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences
            .getString(NumberTriviaLocalDataSource.cachedNumberTrivia));
        expect(result, equals(tNumberTrivia));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences
              .getString(NumberTriviaLocalDataSource.cachedNumberTrivia))
          .thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource!.getLastNumberTrivia;
      // assert
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(const TypeMatcher<FileSystemException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) => Future.value(true));

      // act
      dataSource!.cacheNumberTrivia(tNumberTrivia);
      // assert
      final expectedJsonString = json.encode(tNumberTrivia.toJson());
      verify(mockSharedPreferences.setString(
        NumberTriviaLocalDataSource.cachedNumberTrivia,
        expectedJsonString,
      ));
    });
  });
}

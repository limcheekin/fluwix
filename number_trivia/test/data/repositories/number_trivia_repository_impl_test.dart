import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/common/network/network_info.dart';
import 'package:number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  NumberTriviaRepositoryImpl? repository;
  final mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
  final mockLocalDataSource = MockNumberTriviaLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();

  setUp(() {
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTrivia = NumberTrivia(number: tNumber, text: 'test trivia');

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTrivia);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository!.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => tNumberTrivia);
          // act
          final result = await repository!.getConcreteNumberTrivia(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(tNumberTrivia));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => tNumberTrivia);
          // act
          await repository!.getConcreteNumberTrivia(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivia));
        },
      );

      test(
        'should throw http exception when the call to remote data source is unsuccessful',
        () {
          // arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenThrow(const HttpException(''));
          // act
          final call = repository!.getConcreteNumberTrivia;
          // assert
          expect(
              () => call(tNumber), throwsA(const TypeMatcher<HttpException>()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTrivia);
          // act
          final result = await repository!.getConcreteNumberTrivia(tNumber);
          // assert
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(tNumberTrivia));
        },
      );

      test(
        'should throw file system exception when there is no cached data present',
        () {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(const FileSystemException());
          // act
          final call = repository!.getConcreteNumberTrivia;
          // assert
          expect(() => call(tNumber),
              throwsA(const TypeMatcher<FileSystemException>()));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(number: 123, text: 'test trivia');

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTrivia);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository!.getRandomNumberTrivia();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTrivia);
          // act
          final result = await repository!.getRandomNumberTrivia();
          // assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, equals(tNumberTrivia));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTrivia);
          // act
          await repository!.getRandomNumberTrivia();
          // assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivia));
        },
      );

      test(
        'should throw http exception when the call to remote data source is unsuccessful',
        () {
          // arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(const HttpException(''));
          // act
          final call = repository!.getRandomNumberTrivia;
          // assert
          expect(() => call(), throwsA(const TypeMatcher<HttpException>()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTrivia);
          // act
          final result = await repository!.getRandomNumberTrivia();
          // assert
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(tNumberTrivia));
        },
      );

      test(
        'should throw file system exception when there is no cached data present',
        () {
          // arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(const FileSystemException());
          // act
          final call = repository!.getRandomNumberTrivia;
          // assert
          expect(
              () => call(), throwsA(const TypeMatcher<FileSystemException>()));
        },
      );
    });
  });
}

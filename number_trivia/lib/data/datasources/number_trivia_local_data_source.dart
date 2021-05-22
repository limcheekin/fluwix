import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import '../../common/error/exception.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  static const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences
        .getString(NumberTriviaLocalDataSource.CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      // Future which is immediately completed
      return Future.value(NumberTriviaModel.fromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      NumberTriviaLocalDataSource.CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }
}

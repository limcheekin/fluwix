import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/presentation/pages/number_trivia_controller.dart';
import 'package:number_trivia/presentation/pages/number_trivia_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/network/network_info.dart';
import 'common/presentation/input_converter.dart';
import 'data/datasources/number_trivia_local_data_source.dart';
import 'data/datasources/number_trivia_remote_data_source.dart';
import 'data/repositories/number_trivia_repository_impl.dart';
import 'domain/repositories/number_trivia_repository.dart';
import 'domain/usecases/get_concrete_number_trivia.dart';
import 'domain/usecases/get_random_number_trivia.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Controller & Presenter
  sl.registerLazySingleton(
    () => NumberTriviaController(
      sl(),
    ),
  );
  sl.registerLazySingleton(() => NumberTriviaPresenter(
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl(), sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

// Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Common
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure(); 
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => null;
  
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => null;
}
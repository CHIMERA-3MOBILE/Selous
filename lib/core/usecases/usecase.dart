import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:selous/core/errors/exceptions.dart';

/// Type definitions for use case results
type Result<T> = Either<AppException, T>;

/// Base use case class for all application use cases
abstract class UseCase<Type, Params> {
  const UseCase();
  
  /// Execute the use case
  Future<Result<Type>> call(Params params);
}

/// No parameters use case
class NoParams extends Equatable {
  const NoParams();
  
  @override
  List<Object?> get props => [];
}

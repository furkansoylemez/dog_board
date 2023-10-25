import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';

abstract class DogRepository {
  Future<Either<Failure, List<Breed>>> getBreeds();
}

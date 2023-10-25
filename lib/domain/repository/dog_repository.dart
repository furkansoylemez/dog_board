import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/entity/random_image.dart';

abstract class DogRepository {
  Future<Either<Failure, List<Breed>>> getBreeds();
  Future<Either<Failure, ImageList>> getImagesByBreed(String breed);
  Future<Either<Failure, ImageList>> getImagesBySubBreed(
    String breed,
    String subBreed,
  );
  Future<Either<Failure, RandomImage>> getRandomImageByBreed(String breed);
  Future<Either<Failure, RandomImage>> getRandomImageBySubBreed(
    String breed,
    String subBreed,
  );
}

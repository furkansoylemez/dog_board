import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class GetRandomImageBySubBreed
    extends UseCase<RandomImage, GetRandomImageBySubBreedParams> {
  GetRandomImageBySubBreed(this.dogRepository);

  final DogRepository dogRepository;

  @override
  Future<Either<Failure, RandomImage>> call(
    GetRandomImageBySubBreedParams params,
  ) {
    return dogRepository.getRandomImageBySubBreed(
      params.breed,
      params.subBreed,
    );
  }
}

class GetRandomImageBySubBreedParams {
  GetRandomImageBySubBreedParams({required this.breed, required this.subBreed});
  final String breed;
  final String subBreed;
}

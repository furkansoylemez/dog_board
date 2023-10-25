import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class GetRandomImageByBreed
    extends UseCase<RandomImage, GetRandomImageByBreedParams> {
  GetRandomImageByBreed(this.dogRepository);

  final DogRepository dogRepository;

  @override
  Future<Either<Failure, RandomImage>> call(
    GetRandomImageByBreedParams params,
  ) {
    return dogRepository.getRandomImageByBreed(params.breed);
  }
}

class GetRandomImageByBreedParams {
  GetRandomImageByBreedParams({required this.breed});
  final String breed;
}

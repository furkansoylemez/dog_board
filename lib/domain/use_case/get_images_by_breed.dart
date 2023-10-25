import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class GetImagesByBreed extends UseCase<ImageList, GetImagesByBreedParams> {
  GetImagesByBreed(this.dogRepository);

  final DogRepository dogRepository;

  @override
  Future<Either<Failure, ImageList>> call(GetImagesByBreedParams params) {
    return dogRepository.getImagesByBreed(params.breed);
  }
}

class GetImagesByBreedParams {
  GetImagesByBreedParams({required this.breed});
  final String breed;
}

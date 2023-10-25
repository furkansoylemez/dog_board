import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class GetImagesBySubBreed
    extends UseCase<ImageList, GetImagesBySubBreedParams> {
  GetImagesBySubBreed(this.dogRepository);

  final DogRepository dogRepository;

  @override
  Future<Either<Failure, ImageList>> call(GetImagesBySubBreedParams params) {
    return dogRepository.getImagesBySubBreed(params.breed, params.subBreed);
  }
}

class GetImagesBySubBreedParams {
  GetImagesBySubBreedParams({required this.breed, required this.subBreed});
  final String breed;
  final String subBreed;
}

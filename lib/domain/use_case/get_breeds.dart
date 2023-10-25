import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class GetBreeds extends UseCase<List<Breed>, NoParams> {
  GetBreeds(this.dogRepository);

  final DogRepository dogRepository;

  @override
  Future<Either<Failure, List<Breed>>> call(NoParams params) {
    return dogRepository.getBreeds();
  }
}

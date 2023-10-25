import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/data/data_source/local_data_source/dog_local_data_source.dart';
import 'package:dog_board/data/data_source/remote_data_source/dog_remote_data_source.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/mapper/breed_mapper.dart';
import 'package:dog_board/domain/mapper/image_list_mapper.dart';
import 'package:dog_board/domain/mapper/random_image_mapper.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  DogRepositoryImpl({
    required this.dogRemoteDataSource,
    required this.dogLocalDataSource,
    required this.breedMapper,
    required this.imageListMapper,
    required this.randomImageMapper,
  });

  final DogRemoteDataSource dogRemoteDataSource;
  final DogLocalDataSource dogLocalDataSource;
  final BreedMapper breedMapper;
  final ImageListMapper imageListMapper;
  final RandomImageMapper randomImageMapper;

  Future<Either<Failure, T>> _safeCall<T>(
    Future<T> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Breed>>> getBreeds() {
    return _safeCall<List<Breed>>(() async {
      final lastFetchedTime = await dogLocalDataSource.getLastFetchedTime();

      if (lastFetchedTime != null &&
          DateTime.now().difference(lastFetchedTime).inHours < 2) {
        final cachedData = await dogLocalDataSource.getLastBreeds();
        if (cachedData != null) {
          return breedMapper.toEntity(cachedData);
        }
      }

      final response = await dogRemoteDataSource.getAllBreeds();
      await dogLocalDataSource.cacheBreeds(response);
      return breedMapper.toEntity(response);
    });
  }

  @override
  Future<Either<Failure, ImageList>> getImagesByBreed(String breed) {
    return _safeCall<ImageList>(() async {
      final response = await dogRemoteDataSource.getImagesByBreed(breed);
      return imageListMapper.toEntity(response);
    });
  }

  @override
  Future<Either<Failure, ImageList>> getImagesBySubBreed(
    String breed,
    String subBreed,
  ) {
    return _safeCall<ImageList>(() async {
      final response =
          await dogRemoteDataSource.getImagesBySubBreed(breed, subBreed);
      return imageListMapper.toEntity(response);
    });
  }

  @override
  Future<Either<Failure, RandomImage>> getRandomImageByBreed(String breed) {
    return _safeCall<RandomImage>(() async {
      final response = await dogRemoteDataSource.getRandomImageByBreed(breed);
      return randomImageMapper.toEntity(response);
    });
  }

  @override
  Future<Either<Failure, RandomImage>> getRandomImageBySubBreed(
    String breed,
    String subBreed,
  ) {
    return _safeCall<RandomImage>(() async {
      final response =
          await dogRemoteDataSource.getRandomImageBySubBreed(breed, subBreed);
      return randomImageMapper.toEntity(response);
    });
  }
}

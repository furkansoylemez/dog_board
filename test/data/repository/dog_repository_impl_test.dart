import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/data/data_source/dog_local_data_source.dart';
import 'package:dog_board/data/data_source/dog_remote_data_source.dart';
import 'package:dog_board/data/repository/dog_repository_impl.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/mapper/breed_mapper.dart';
import 'package:dog_board/domain/mapper/image_list_mapper.dart';
import 'package:dog_board/domain/mapper/random_image_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/breed_fixture.dart';
import '../../fixtures/image_list_fixture.dart';

class MockDogRemoteDataSource extends Mock implements DogRemoteDataSource {}

class MockDogLocalDataSource extends Mock implements DogLocalDataSource {}

class MockBreedMapper extends Mock implements BreedMapper {}

class MockImageListMapper extends Mock implements ImageListMapper {}

class MockRandomImageMapper extends Mock implements RandomImageMapper {}

void main() {
  late DogRepositoryImpl repository;
  late MockDogRemoteDataSource mockRemoteDataSource;
  late MockDogLocalDataSource mockLocalDataSource;
  late MockBreedMapper mockBreedMapper;
  late MockImageListMapper mockImageListMapper;
  late MockRandomImageMapper mockRandomImageMapper;

  setUp(() {
    mockRemoteDataSource = MockDogRemoteDataSource();
    mockLocalDataSource = MockDogLocalDataSource();
    mockBreedMapper = MockBreedMapper();
    mockImageListMapper = MockImageListMapper();
    mockRandomImageMapper = MockRandomImageMapper();

    repository = DogRepositoryImpl(
      dogRemoteDataSource: mockRemoteDataSource,
      dogLocalDataSource: mockLocalDataSource,
      breedMapper: mockBreedMapper,
      imageListMapper: mockImageListMapper,
      randomImageMapper: mockRandomImageMapper,
    );
  });

  group('getBreeds', () {
    test('should return cached breeds when the cache is less than 2 hours old',
        () async {
      // arrange
      when(() => mockLocalDataSource.getLastFetchedTime()).thenAnswer(
        (_) => Future.value(DateTime.now().subtract(const Duration(hours: 1))),
      );
      when(() => mockLocalDataSource.getLastBreeds())
          .thenAnswer((_) => Future.value(tAllBreedsResponse));
      when(() => mockBreedMapper.toEntity(tAllBreedsResponse))
          .thenReturn(tBreeds);

      // act
      final result = await repository.getBreeds();

      // assert
      expect(result, equals(Right<Failure, List<Breed>>(tBreeds)));
      verifyNever(() => mockRemoteDataSource.getAllBreeds());
    });

    test('should fetch remote data when the cache is more than 2 hours old',
        () async {
      // arrange
      when(() => mockLocalDataSource.getLastFetchedTime()).thenAnswer(
        (_) => Future.value(DateTime.now().subtract(const Duration(hours: 3))),
      );
      when(() => mockRemoteDataSource.getAllBreeds())
          .thenAnswer((_) => Future.value(tAllBreedsResponse));
      when(() => mockBreedMapper.toEntity(tAllBreedsResponse))
          .thenReturn(tBreeds);
      when(() => mockLocalDataSource.cacheBreeds(tAllBreedsResponse))
          .thenAnswer((_) async => {});

      // act
      final result = await repository.getBreeds();

      // assert
      expect(result, equals(Right<Failure, List<Breed>>(tBreeds)));
      verify(() => mockLocalDataSource.cacheBreeds(tAllBreedsResponse))
          .called(1);
    });

    test('should return ServerFailure when there is a ServerException',
        () async {
      // arrange
      when(() => mockLocalDataSource.getLastFetchedTime()).thenAnswer(
        (_) => Future.value(DateTime.now().subtract(const Duration(hours: 3))),
      );
      when(() => mockRemoteDataSource.getAllBreeds())
          .thenThrow(ServerException());

      // act
      final result = await repository.getBreeds();

      // assert
      expect(result, equals(Left<Failure, List<Breed>>(ServerFailure())));
    });

    test('''
should return CacheFailure when there is a CacheException 
        fetching the last fetched time''', () async {
      // arrange
      when(() => mockLocalDataSource.getLastFetchedTime())
          .thenThrow(CacheException());

      // act
      final result = await repository.getBreeds();

      // assert
      expect(result, equals(Left<Failure, List<Breed>>(CacheFailure())));
    });
  });

  group('getImagesByBreed', () {
    test('should fetch images by breed successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.getImagesByBreed(tBreed))
          .thenAnswer((_) => Future.value(tImagesListResponse));
      when(() => mockImageListMapper.toEntity(tImagesListResponse))
          .thenReturn(tImages);

      // act
      final result = await repository.getImagesByBreed(tBreed);

      // assert
      expect(result, equals(const Right<Failure, ImageList>(tImages)));
    });

    test('should return ServerFailure on ServerException', () async {
      // arrange
      when(() => mockRemoteDataSource.getImagesByBreed(tBreed))
          .thenThrow(ServerException());

      // act
      final result = await repository.getImagesByBreed(tBreed);

      // assert
      expect(result, equals(Left<Failure, ImageList>(ServerFailure())));
    });

    test('should return CacheFailure on CacheException', () async {
      // arrange
      when(() => mockRemoteDataSource.getImagesByBreed(tBreed))
          .thenThrow(CacheException());

      // act
      final result = await repository.getImagesByBreed(tBreed);

      // assert
      expect(result, equals(Left<Failure, ImageList>(CacheFailure())));
    });
  });

  group('getRandomImageByBreed', () {
    test('should fetch random image by breed successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.getRandomImageByBreed(tBreed))
          .thenAnswer((_) => Future.value(tImageResponse));
      when(() => mockRandomImageMapper.toEntity(tImageResponse))
          .thenReturn(tRandomImage);

      // act
      final result = await repository.getRandomImageByBreed(tBreed);

      // assert
      expect(result, equals(const Right<Failure, RandomImage>(tRandomImage)));
    });

    test('should return ServerFailure on ServerException', () async {
      // arrange
      when(() => mockRemoteDataSource.getRandomImageByBreed(tBreed))
          .thenThrow(ServerException());

      // act
      final result = await repository.getRandomImageByBreed(tBreed);

      // assert
      expect(result, equals(Left<Failure, RandomImage>(ServerFailure())));
    });

    test('should return CacheFailure on CacheException', () async {
      // arrange
      when(() => mockRemoteDataSource.getRandomImageByBreed(tBreed))
          .thenThrow(CacheException());

      // act
      final result = await repository.getRandomImageByBreed(tBreed);

      // assert
      expect(result, equals(Left<Failure, RandomImage>(CacheFailure())));
    });
  });

  group('getRandomImageBySubBreed', () {
    test('should fetch random image by sub breed successfully', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getRandomImageBySubBreed(tBreed, tSubBreed),
      ).thenAnswer((_) => Future.value(tImageResponse));
      when(() => mockRandomImageMapper.toEntity(tImageResponse))
          .thenReturn(tRandomImage);

      // act
      final result =
          await repository.getRandomImageBySubBreed(tBreed, tSubBreed);

      // assert
      expect(result, equals(const Right<Failure, RandomImage>(tRandomImage)));
    });

    test('should return ServerFailure on ServerException', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getRandomImageBySubBreed(tBreed, tSubBreed),
      ).thenThrow(ServerException());

      // act
      final result =
          await repository.getRandomImageBySubBreed(tBreed, tSubBreed);

      // assert
      expect(result, equals(Left<Failure, RandomImage>(ServerFailure())));
    });

    test('should return CacheFailure on CacheException', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getRandomImageBySubBreed(tBreed, tSubBreed),
      ).thenThrow(CacheException());

      // act
      final result =
          await repository.getRandomImageBySubBreed(tBreed, tSubBreed);

      // assert
      expect(result, equals(Left<Failure, RandomImage>(CacheFailure())));
    });
  });
}

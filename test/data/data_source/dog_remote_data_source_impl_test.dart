import 'package:dog_board/core/client/dog_client.dart';
import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/data/data_source/dog_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/breed_fixture.dart';
import '../../fixtures/image_list_fixture.dart';

class MockDogClient extends Mock implements DogClient {}

void main() {
  late DogRemoteDataSourceImpl dataSource;
  late MockDogClient mockDogClient;

  setUp(() {
    mockDogClient = MockDogClient();
    dataSource = DogRemoteDataSourceImpl(dogClient: mockDogClient);
  });

  group('DogRemoteDataSourceImpl', () {
    test('should get all breeds using DogClient', () async {
      // arrange
      when(mockDogClient.getBreeds).thenAnswer((_) async => tAllBreedsResponse);

      // act
      final result = await dataSource.getAllBreeds();

      // assert
      expect(result, equals(tAllBreedsResponse));

      verify(() => mockDogClient.getBreeds()).called(1);
    });

    test('should get images by breed using DogClient', () async {
      // arrange
      when(() => mockDogClient.getImagesByBreed(any()))
          .thenAnswer((_) async => tImagesListResponse);

      // act
      final result = await dataSource.getImagesByBreed(tBreed);

      // assert
      expect(result, equals(tImagesListResponse));

      verify(() => mockDogClient.getImagesByBreed(tBreed)).called(1);
    });

    test('should get images by sub-breed using DogClient', () async {
      // arrange
      when(() => mockDogClient.getImagesBySubBreed(any(), any()))
          .thenAnswer((_) async => tImagesListResponse);

      // act
      final result = await dataSource.getImagesBySubBreed(tBreed, tSubBreed);

      // assert
      expect(result, equals(tImagesListResponse));

      verify(() => mockDogClient.getImagesBySubBreed(tBreed, tSubBreed))
          .called(1);
    });

    test('should get random image by breed using DogClient', () async {
      // arrange
      when(() => mockDogClient.getRandomImageByBreed(any()))
          .thenAnswer((_) async => tImageResponse);

      // act
      final result = await dataSource.getRandomImageByBreed(tBreed);

      // assert
      expect(result, equals(tImageResponse));

      verify(() => mockDogClient.getRandomImageByBreed(tBreed)).called(1);
    });

    test('should get random image by sub-breed using DogClient', () async {
      // arrange
      when(() => mockDogClient.getRandomImageBySubBreed(any(), any()))
          .thenAnswer((_) async => tImageResponse);

      // act
      final result = await dataSource.getRandomImageBySubBreed(
        tBreed,
        tSubBreed,
      );

      // assert
      expect(result, equals(tImageResponse));

      verify(() => mockDogClient.getRandomImageBySubBreed(tBreed, tSubBreed))
          .called(1);
    });

    test('should throw ServerException when DogClient throws an error',
        () async {
      // arrange
      when(mockDogClient.getBreeds).thenThrow(Exception());

      // act & assert
      expect(dataSource.getAllBreeds, throwsA(isA<ServerException>()));

      verify(() => mockDogClient.getBreeds()).called(1);
    });
  });
}

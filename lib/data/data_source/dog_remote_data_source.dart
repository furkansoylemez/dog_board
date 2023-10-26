import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/data/client/dog_client.dart';
import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:dog_board/data/model/image_list_response.dart';
import 'package:dog_board/data/model/image_response.dart';

abstract class DogRemoteDataSource {
  /// Calls the service class to get a list of breeds.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<BreedListResponse> getAllBreeds();

  /// Calls the service class to get a list of images for a given breed.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ImageListResponse> getImagesByBreed(String breed);

  /// Calls the service class to get a list of images for a given sub-breed.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ImageListResponse> getImagesBySubBreed(String breed, String subBreed);

  /// Calls the service class to get a random image for a given breed.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ImageResponse> getRandomImageByBreed(String breed);

  /// Calls the service class to get a random image for a given sub-breed.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ImageResponse> getRandomImageBySubBreed(String breed, String subBreed);
}

class DogRemoteDataSourceImpl implements DogRemoteDataSource {
  DogRemoteDataSourceImpl({required this.dogClient});

  final DogClient dogClient;

  Future<T> _performAndCatch<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<BreedListResponse> getAllBreeds() async {
    return _performAndCatch(dogClient.getBreeds);
  }

  @override
  Future<ImageListResponse> getImagesByBreed(String breed) async {
    return _performAndCatch(() => dogClient.getImagesByBreed(breed));
  }

  @override
  Future<ImageListResponse> getImagesBySubBreed(
    String breed,
    String subBreed,
  ) async {
    return _performAndCatch(
      () => dogClient.getImagesBySubBreed(breed, subBreed),
    );
  }

  @override
  Future<ImageResponse> getRandomImageByBreed(String breed) async {
    return _performAndCatch(() => dogClient.getRandomImageByBreed(breed));
  }

  @override
  Future<ImageResponse> getRandomImageBySubBreed(
    String breed,
    String subBreed,
  ) async {
    return _performAndCatch(
      () => dogClient.getRandomImageBySubBreed(breed, subBreed),
    );
  }
}

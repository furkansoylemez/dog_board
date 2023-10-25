import 'package:dog_board/core/error/exceptions.dart';
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

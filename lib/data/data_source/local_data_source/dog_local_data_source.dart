import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/data/model/breed_list_response.dart';

abstract class DogLocalDataSource {
  /// Gets the cached [BreedListResponse], which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<BreedListResponse?> getLastBreeds();

  /// Caches the provided [BreedListResponse] to local storage.
  Future<void> cacheBreeds(BreedListResponse breedsToCache);

  /// Gets the cached [DateTime], which was gotten the last time
  Future<DateTime?> getLastFetchedTime();
}

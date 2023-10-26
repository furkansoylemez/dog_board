import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/data/local_storage/local_storage_manager.dart';
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

class DogLocalDataSourceImpl implements DogLocalDataSource {
  DogLocalDataSourceImpl({required this.localStorageManager});

  final LocalStorageManager localStorageManager;

  Future<T> _performAndCatch<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBreeds(BreedListResponse breedsToCache) {
    return _performAndCatch(
      () => localStorageManager.storeBreedList(breedsToCache),
    );
  }

  @override
  Future<BreedListResponse?> getLastBreeds() {
    return _performAndCatch(localStorageManager.fetchBreedList);
  }

  @override
  Future<DateTime?> getLastFetchedTime() {
    return _performAndCatch(localStorageManager.getLastFetchedTime);
  }
}

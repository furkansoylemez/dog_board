import 'package:dog_board/core/error/exceptions.dart';
import 'package:dog_board/data/data_source/dog_local_data_source.dart';
import 'package:dog_board/data/local_storage/local_storage_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/breed_fixture.dart';

class MockLocalStorageManager extends Mock implements LocalStorageManager {}

void main() {
  late DogLocalDataSourceImpl dataSource;
  late MockLocalStorageManager mockLocalStorageManager;

  setUp(() {
    mockLocalStorageManager = MockLocalStorageManager();
    dataSource =
        DogLocalDataSourceImpl(localStorageManager: mockLocalStorageManager);
  });

  group('DogLocalDataSourceImpl', () {
    final tDateTime = DateTime.now();

    test('should cache breeds using LocalStorageManager', () async {
      // arrange
      when(() => mockLocalStorageManager.storeBreedList(tAllBreedsResponse))
          .thenAnswer((_) async {});

      // act
      await dataSource.cacheBreeds(tAllBreedsResponse);

      // assert
      verify(() => mockLocalStorageManager.storeBreedList(tAllBreedsResponse))
          .called(1);
    });

    test('should fetch the last breeds from LocalStorageManager', () async {
      // arrange
      when(mockLocalStorageManager.fetchBreedList)
          .thenAnswer((_) async => tAllBreedsResponse);

      // act
      final result = await dataSource.getLastBreeds();

      // assert
      expect(result, equals(tAllBreedsResponse));

      verify(() => mockLocalStorageManager.fetchBreedList()).called(1);
    });

    test('should fetch the last fetched time from LocalStorageManager',
        () async {
      // arrange
      when(mockLocalStorageManager.getLastFetchedTime)
          .thenAnswer((_) async => tDateTime);

      // act
      final result = await dataSource.getLastFetchedTime();

      // assert
      expect(result, equals(tDateTime));

      verify(() => mockLocalStorageManager.getLastFetchedTime()).called(1);
    });

    test('should throw CacheException when LocalStorageManager throws an error',
        () async {
      // arrange
      when(() => mockLocalStorageManager.storeBreedList(tAllBreedsResponse))
          .thenThrow(Exception());

      // act & assert
      expect(
        () => dataSource.cacheBreeds(tAllBreedsResponse),
        throwsA(isA<CacheException>()),
      );

      verify(() => mockLocalStorageManager.storeBreedList(tAllBreedsResponse))
          .called(1);
    });
  });
}

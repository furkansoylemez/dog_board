import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:hive/hive.dart';

abstract class LocalStorageManager {
  Future<void> storeBreedList(BreedListResponse data);
  Future<BreedListResponse?> fetchBreedList();
  Future<DateTime?> getLastFetchedTime();
}

class HiveLocalStorageManager implements LocalStorageManager {
  HiveLocalStorageManager();
  static const String _breedBoxName = 'breedCache';
  static const String _breedDataKey = 'breedList';
  static const String _lastFetchedKey = 'lastFetched';

  Future<Box<dynamic>> _openBox() {
    return Hive.openBox(_breedBoxName);
  }

  @override
  Future<void> storeBreedList(BreedListResponse data) async {
    final box = await _openBox();
    await box.put(_breedDataKey, data);
    await _storeLastCachedTime(box);
  }

  Future<void> _storeLastCachedTime(Box<dynamic> box) async =>
      box.put(_lastFetchedKey, DateTime.now());

  @override
  Future<BreedListResponse?> fetchBreedList() async {
    final box = await _openBox();
    final data = box.get(_breedDataKey);
    if (data is BreedListResponse) {
      return data;
    }
    return null;
  }

  @override
  Future<DateTime?> getLastFetchedTime() async {
    final box = await _openBox();
    final data = box.get(_lastFetchedKey);
    if (data is DateTime) {
      return data;
    }
    return null;
  }
}

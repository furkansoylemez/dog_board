import 'package:dog_board/app/app.dart';
import 'package:dog_board/core/local_storage/hive_adapters/breed_list_response_adapter.dart';
import 'package:dog_board/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await _init();
  runApp(const DogBoard());
}

Future<void> _init() async {
  di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(BreedListResponseAdapter());
}

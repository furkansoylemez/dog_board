import 'package:dog_board/app/app.dart';
import 'package:dog_board/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() {
  di.init();
  runApp(const DogBoard());
}

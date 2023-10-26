import 'package:dog_board/app/app.dart';
import 'package:dog_board/data/local_storage/hive_adapters/breed_list_response_adapter.dart';
import 'package:dog_board/injection_container.dart' as di;
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test', () {
    setUpAll(() async {
      di.init();
      await Hive.initFlutter();
      Hive.registerAdapter(BreedListResponseAdapter());
    });

    testWidgets('ImagesListByBreed Integration Test', (tester) async {
      await _initializeApp();

      await tester.pumpUntilFound(find.byType(FetchButton));

      await tester.tap(find.byType(FetchButton));

      await tester.pumpAndSettle();

      expect(find.byType(CustomImageContainer), findsWidgets);

      await tester.tap(find.byType(CustomImageContainer).first);

      await tester.pumpAndSettle();

      await _testZoomIn(tester);

      await tester.tap(find.byType(IconButton));

      await tester.pumpAndSettle();
    });

    testWidgets('RandomImageByBreed Integration Test', (tester) async {
      await _initializeApp();

      final textFinder = find.text('Random Image');

      await tester.pumpUntilFound(textFinder);

      expect(textFinder, findsOneWidget);

      await tester.tap(textFinder);

      final buttonFinder = find.byType(FetchButton);

      await tester.pumpUntilFound(buttonFinder);

      await tester.tap(buttonFinder);

      await tester.pumpUntilFound(find.byType(Hero));

      expect(find.byType(Hero), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byType(Hero));

      await tester.pumpAndSettle();

      expect(find.byType(InteractiveViewer), findsOneWidget);
    });
  });
}

Future<void> _testZoomIn(WidgetTester tester) async {
  final center = tester.getCenter(find.byType(InteractiveViewer));

  final touch1 = await tester.startGesture(center.translate(-10, 0));
  final touch2 = await tester.startGesture(center.translate(10, 0));

  await touch1.moveBy(const Offset(-100, 0));
  await touch2.moveBy(const Offset(100, 0));
  await tester.pump();

  await touch1.cancel();
  await touch2.cancel();
}

Future<void> _initializeApp() async {
  runApp(const DogBoard());
}

//The app includes infinite lottie animations,
//pump and pumpAndSettle will not work.
//Instead, we can use pumpUntilFound.
extension PumpUntilFound on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration duration = const Duration(milliseconds: 100),
    int tries = 10,
  }) async {
    for (var i = 0; i < tries; i++) {
      await pump(duration);

      final result = finder.precache();

      if (result) {
        finder.evaluate();

        break;
      }
    }
  }
}

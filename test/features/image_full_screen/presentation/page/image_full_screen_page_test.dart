import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_board/features/image_full_screen/presentation/page/image_full_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const imageUrl = 'https://example.com/test.jpg';

  Widget createTestableWidget() {
    return const MaterialApp(
      home: ImageFullScreenPage(imageUrl: imageUrl),
    );
  }

  testWidgets('ImageFullScreenPage displays the given image URL',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.byType(Hero), findsOneWidget);

    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(image.imageUrl, imageUrl);
  });

  testWidgets('AppBar and BackButton are rendered with correct colors',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(AppBar), findsOneWidget);
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, Colors.black);

    expect(find.byType(BackButton), findsOneWidget);
    final backButton = tester.widget<BackButton>(find.byType(BackButton));
    expect(backButton.color, Colors.white);
  });
}

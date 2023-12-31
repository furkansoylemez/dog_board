import 'package:bloc_test/bloc_test.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/bloc/images_list_by_sub_breed_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/page/images_list_by_sub_breed_page.dart';
import 'package:dog_board/presentation/widgets/body_view.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_grid_view.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:dog_board/presentation/widgets/sub_breed_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/breed_fixture.dart';
import '../../../../../fixtures/image_list_fixture.dart';

class MockBreedsBloc extends MockBloc<BreedsEvent, BreedsState>
    implements BreedsBloc {}

class MockImagesListBySubBreedBloc
    extends MockBloc<ImagesListBySubBreedEvent, ImagesListBySubBreedState>
    implements ImagesListBySubBreedBloc {}

void main() {
  final sl = GetIt.instance;
  late MockBreedsBloc mockBreedsBloc;
  late MockImagesListBySubBreedBloc mockImagesListBySubBreedBloc;

  setUp(() {
    mockBreedsBloc = MockBreedsBloc();
    mockImagesListBySubBreedBloc = MockImagesListBySubBreedBloc();

    when(() => mockBreedsBloc.state).thenReturn(
      BreedsLoaded(
        allBreeds: tBreeds,
        breedsHasSubBreeds: tBreedsWithSubBreeds,
      ),
    );
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
      ),
    );
    sl
      ..registerFactory<BreedsBloc>(() => mockBreedsBloc)
      ..registerFactory<ImagesListBySubBreedBloc>(
        () => mockImagesListBySubBreedBloc,
      );
  });

  tearDown(sl.reset);

  testWidgets('Displays initial state correctly', (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    expect(find.byType(BodyView), findsOneWidget);
    expect(find.text(AppStrings.imagesBySubBreedBody), findsOneWidget);
  });

  testWidgets('Displays loading state correctly', (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
        status: ImagesListBySubBreedStatus.loading,
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('Displays error state correctly', (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
        status: ImagesListBySubBreedStatus.error,
        failure: ServerFailure(),
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    expect(find.text(AppStrings.serverFailureMessage), findsOneWidget);
  });

  testWidgets('Displays loaded state correctly', (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
        status: ImagesListBySubBreedStatus.loaded,
        imageList: tImages,
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    expect(find.byType(CustomGridView), findsOneWidget);
  });

  testWidgets('Dispatches event when breed changes',
      (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    await tester.tap(find.byType(BreedDropdownButton));
    await tester.pump();

    await tester.tap(find.text(tBreedsWithSubBreeds[1].breed.capitalize));
    await tester.pump();

    verify(
      () => mockImagesListBySubBreedBloc
          .add(BreedChanged(tBreedsWithSubBreeds[1])),
    ).called(1);
  });

  testWidgets('Dispatches event when sub breed changes',
      (WidgetTester tester) async {
    when(() => mockImagesListBySubBreedBloc.state).thenReturn(
      ImagesListBySubBreedState(
        breeds: tBreedsWithSubBreeds,
        selectedBreed: tBreedsWithSubBreeds.first,
        selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
      ),
    );

    await _createTestableWidget(
      tester,
      mockBreedsBloc,
      mockImagesListBySubBreedBloc,
    );

    await tester.tap(find.byType(SubBreedDropdownButton));
    await tester.pump();

    await tester
        .tap(find.text(tBreedsWithSubBreeds[0].subBreeds[1].capitalize));
    await tester.pump();

    verify(
      () => mockImagesListBySubBreedBloc.add(
        SubBreedChanged(tBreedsWithSubBreeds[0].subBreeds[1]),
      ),
    ).called(1);
  });
}

Future<void> _createTestableWidget(
  WidgetTester tester,
  MockBreedsBloc mockBreedsBloc,
  MockImagesListBySubBreedBloc mockImagesListBySubBreedBloc,
) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<BreedsBloc>.value(value: mockBreedsBloc),
        BlocProvider<ImagesListBySubBreedBloc>.value(
          value: mockImagesListBySubBreedBloc,
        ),
      ],
      child: const MaterialApp(home: ImagesListBySubBreedPage()),
    ),
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/bloc/images_list_by_breed_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/page/images_list_by_breed_page.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_grid_view.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/breed_fixture.dart';

class MockBreedsBloc extends MockBloc<BreedsEvent, BreedsState>
    implements BreedsBloc {}

class MockImagesListByBreedBloc
    extends MockBloc<ImagesListByBreedEvent, ImagesListByBreedState>
    implements ImagesListByBreedBloc {}

void main() {
  final sl = GetIt.instance;
  late MockBreedsBloc mockBreedsBloc;
  late MockImagesListByBreedBloc mockImagesListByBreedBloc;

  setUp(() {
    mockBreedsBloc = MockBreedsBloc();
    mockImagesListByBreedBloc = MockImagesListByBreedBloc();

    when(() => mockBreedsBloc.state).thenReturn(
      BreedsLoaded(
        allBreeds: tBreeds,
        breedsHasSubBreeds: tBreedsWithSubBreeds,
      ),
    );
    when(() => mockImagesListByBreedBloc.state).thenReturn(
      ImagesListByBreedState(breeds: tBreeds, selectedBreed: tBreeds.first),
    );

    sl
      ..registerFactory<BreedsBloc>(() => mockBreedsBloc)
      ..registerFactory<ImagesListByBreedBloc>(() => mockImagesListByBreedBloc);
  });

  tearDown(sl.reset);

  testWidgets('Displays initial state correctly', (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.text('Images List By Breed'), findsOneWidget);
    expect(find.byType(BreedDropdownButton), findsOneWidget);
    expect(find.byType(FetchButton), findsOneWidget);
  });

  testWidgets('Displays loading state correctly', (WidgetTester tester) async {
    when(() => mockImagesListByBreedBloc.state).thenReturn(
      ImagesListByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: ImagesListByBreedStatus.loading,
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('Displays error state correctly', (WidgetTester tester) async {
    when(() => mockImagesListByBreedBloc.state).thenReturn(
      ImagesListByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: ImagesListByBreedStatus.error,
        failure: ServerFailure(),
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('Displays loaded state correctly', (WidgetTester tester) async {
    when(() => mockImagesListByBreedBloc.state).thenReturn(
      ImagesListByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: ImagesListByBreedStatus.loaded,
        imageList: const ImageList(images: ['image1.jpg', 'image2.jpg']),
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(CustomGridView), findsOneWidget);
  });

  testWidgets('Dispatches event when breed changes',
      (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    await tester.tap(find.byType(BreedDropdownButton));
    await tester.pump();

    expect(find.text(tBreedEntity.breed.capitalize), findsOneWidget);

    await tester.tap(find.text(tBreedEntity.breed.capitalize));
    await tester.pump();

    verify(
      () => mockImagesListByBreedBloc.add(const BreedChanged(tBreedEntity)),
    ).called(1);
  });

  testWidgets('Dispatches event when fetch button tapped',
      (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    await tester.tap(find.byType(FetchButton));
    await tester.pump();

    verify(() => mockImagesListByBreedBloc.add(ImagesListByBreedRequested()))
        .called(1);
  });
}

Future<void> _createTestableWidget(
  WidgetTester tester,
  MockBreedsBloc mockBreedsBloc,
) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<BreedsBloc>.value(value: mockBreedsBloc),
      ],
      child: const MaterialApp(home: ImagesListByBreedPage()),
    ),
  );
}

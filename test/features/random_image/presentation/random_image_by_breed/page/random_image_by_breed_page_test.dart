import 'package:bloc_test/bloc_test.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/bloc/random_image_by_breed_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/page/random_image_by_breed_page.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/breed_fixture.dart';
import '../../../../../fixtures/image_list_fixture.dart';

class MockBreedsBloc extends MockBloc<BreedsEvent, BreedsState>
    implements BreedsBloc {}

class MockRandomImageByBreedBloc
    extends MockBloc<RandomImageByBreedEvent, RandomImageByBreedState>
    implements RandomImageByBreedBloc {}

void main() {
  final sl = GetIt.instance;
  late MockBreedsBloc mockBreedsBloc;
  late MockRandomImageByBreedBloc mockRandomImageByBreedBloc;

  setUp(() {
    mockBreedsBloc = MockBreedsBloc();
    mockRandomImageByBreedBloc = MockRandomImageByBreedBloc();

    when(() => mockBreedsBloc.state).thenReturn(
      BreedsLoaded(
        allBreeds: tBreeds,
        breedsHasSubBreeds: tBreedsWithSubBreeds,
      ),
    );
    when(() => mockRandomImageByBreedBloc.state).thenReturn(
      RandomImageByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: RandomImageByBreedStatus.loaded,
        randomImage: tRandomImage,
      ),
    );

    sl
      ..registerFactory<BreedsBloc>(() => mockBreedsBloc)
      ..registerFactory<RandomImageByBreedBloc>(
        () => mockRandomImageByBreedBloc,
      );
  });

  tearDown(sl.reset);

  testWidgets('Displays initial state correctly', (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.text('Random Image By Breed'), findsOneWidget);
    expect(find.byType(BreedDropdownButton), findsOneWidget);
    expect(find.byType(FetchButton), findsOneWidget);
  });

  testWidgets('Displays loading state correctly', (WidgetTester tester) async {
    when(() => mockRandomImageByBreedBloc.state).thenReturn(
      RandomImageByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: RandomImageByBreedStatus.loading,
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('Displays error state correctly', (WidgetTester tester) async {
    when(() => mockRandomImageByBreedBloc.state).thenReturn(
      RandomImageByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: RandomImageByBreedStatus.error,
        failure: ServerFailure(),
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('Displays loaded state correctly', (WidgetTester tester) async {
    when(() => mockRandomImageByBreedBloc.state).thenReturn(
      RandomImageByBreedState(
        breeds: tBreeds,
        selectedBreed: tBreeds.first,
        status: RandomImageByBreedStatus.loaded,
        randomImage: tRandomImage,
      ),
    );

    await _createTestableWidget(tester, mockBreedsBloc);

    expect(find.byType(CustomImageContainer), findsOneWidget);
  });

  testWidgets('Dispatches event when breed changes',
      (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    await tester.tap(find.byType(BreedDropdownButton));
    await tester.pump();

    await tester.tap(find.text(tBreeds[1].breed.capitalize));
    await tester.pump();

    verify(() => mockRandomImageByBreedBloc.add(BreedChanged(tBreeds[1])))
        .called(1);
  });

  testWidgets('Dispatches event when fetch button tapped',
      (WidgetTester tester) async {
    await _createTestableWidget(tester, mockBreedsBloc);

    await tester.tap(find.byType(FetchButton));

    verify(() => mockRandomImageByBreedBloc.add(RandomImageByBreedRequested()))
        .called(1);
  });
}

Future<void> _createTestableWidget(
    WidgetTester tester, MockBreedsBloc mockBreedsBloc) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<BreedsBloc>.value(value: mockBreedsBloc),
      ],
      child: const MaterialApp(home: RandomImageByBreedPage()),
    ),
  );
}

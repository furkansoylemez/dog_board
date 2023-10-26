import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/breed_fixture.dart';

class MockBreedsBloc extends MockBloc<BreedsEvent, BreedsState>
    implements BreedsBloc {}

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  final sl = GetIt.instance;
  late BreedsBloc mockBreedsBloc;

  setUp(() {
    mockBreedsBloc = MockBreedsBloc();

    when(() => mockBreedsBloc.state).thenReturn(BreedsLoading());
    sl.registerFactory<BreedsBloc>(() => mockBreedsBloc);
  });

  tearDown(sl.reset);

  testWidgets('Displays LoadingView when in BreedsLoading state',
      (WidgetTester tester) async {
    await _createTestableWidget(tester);

    await tester.pump();

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('Displays ErrorView when in BreedsError state',
      (WidgetTester tester) async {
    when(() => mockBreedsBloc.state).thenReturn(
      BreedsError(
        ServerFailure(),
      ),
    );

    await _createTestableWidget(tester);

    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('Displays AutoTabsScaffold when in BreedsLoaded state',
      (WidgetTester tester) async {
    when(() => mockBreedsBloc.state).thenReturn(
      BreedsLoaded(
        allBreeds: tBreeds,
        breedsHasSubBreeds: tBreedsWithSubBreeds,
      ),
    );

    await _createTestableWidget(tester);

    tester.takeException();

    expect(find.byType(AutoTabsScaffold), findsOneWidget);
  });
}

Future<void> _createTestableWidget(WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
}

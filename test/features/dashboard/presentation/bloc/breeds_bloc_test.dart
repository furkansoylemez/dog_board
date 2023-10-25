import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/breed_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;

  setUp(() {
    mockDogRepository = MockDogRepository();
  });

  group('breedsBloc', () {
    blocTest<BreedsBloc, BreedsState>(
      'emits [BreedsLoading, BreedsLoaded] when getting breeds succeeds',
      build: () {
        when(() => mockDogRepository.getBreeds())
            .thenAnswer((_) async => Right(tBreeds));
        return BreedsBloc(mockDogRepository);
      },
      expect: () => [
        const BreedsLoading(),
        BreedsLoaded(
          allBreeds: tBreeds,
          breedsHasSubBreeds:
              tBreeds.where((e) => e.subBreeds.isNotEmpty).toList(),
        ),
      ],
    );

    blocTest<BreedsBloc, BreedsState>(
      'emits [BreedsLoading, BreedsError] when getting breeds fails',
      build: () {
        when(() => mockDogRepository.getBreeds())
            .thenAnswer((_) async => Left(ServerFailure()));
        return BreedsBloc(mockDogRepository);
      },
      expect: () => [
        const BreedsLoading(),
        BreedsError(ServerFailure()),
      ],
    );
  });
}

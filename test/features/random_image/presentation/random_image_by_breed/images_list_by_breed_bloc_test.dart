import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/bloc/random_image_by_breed_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/breed_fixture.dart';
import '../../../../fixtures/image_list_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;

  setUp(() {
    mockDogRepository = MockDogRepository();
  });

  group('randomImageByBreedBloc', () {
    blocTest<RandomImageByBreedBloc, RandomImageByBreedState>(
      'emits [loading, loaded] when fetching image succeeds',
      build: () {
        when(() => mockDogRepository.getRandomImageByBreed(any()))
            .thenAnswer((_) async => const Right(tRandomImage));
        return RandomImageByBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreeds,
        );
      },
      act: (bloc) => bloc.add(RandomImageByBreedRequested()),
      expect: () => [
        RandomImageByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: RandomImageByBreedStatus.loading,
        ),
        RandomImageByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: RandomImageByBreedStatus.loaded,
          randomImage: tRandomImage,
        ),
      ],
    );

    blocTest<RandomImageByBreedBloc, RandomImageByBreedState>(
      'emits [loading, error] when fetching image fails',
      build: () {
        when(() => mockDogRepository.getRandomImageByBreed(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return RandomImageByBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreeds,
        );
      },
      act: (bloc) => bloc.add(RandomImageByBreedRequested()),
      expect: () => [
        RandomImageByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: RandomImageByBreedStatus.loading,
        ),
        RandomImageByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: RandomImageByBreedStatus.error,
          failure: ServerFailure(),
        ),
      ],
    );

    blocTest<RandomImageByBreedBloc, RandomImageByBreedState>(
      'updates selected breed on BreedChanged',
      build: () => RandomImageByBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreeds,
      ),
      act: (bloc) => bloc.add(BreedChanged(tBreeds[1])),
      expect: () => [
        RandomImageByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds[1],
        ),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_sub_breed/bloc/random_image_by_sub_breed_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/breed_fixture.dart';
import '../../../../../fixtures/image_list_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;

  setUp(() {
    mockDogRepository = MockDogRepository();
  });

  group('RandomImageBySubBreedBloc', () {
    blocTest<RandomImageBySubBreedBloc, RandomImageBySubBreedState>(
      'emits [loading, loaded] when fetching sub-breed image succeeds',
      build: () {
        when(() => mockDogRepository.getRandomImageBySubBreed(any(), any()))
            .thenAnswer((_) async => const Right(tRandomImage));
        return RandomImageBySubBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreedsWithSubBreeds,
        );
      },
      act: (bloc) => bloc.add(RandomImageBySubBreedRequested()),
      expect: () => [
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: RandomImageBySubBreedStatus.loading,
        ),
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: RandomImageBySubBreedStatus.loaded,
          randomImage: tRandomImage,
        ),
      ],
    );

    blocTest<RandomImageBySubBreedBloc, RandomImageBySubBreedState>(
      'emits [loading, error] when fetching sub-breed image fails',
      build: () {
        when(() => mockDogRepository.getRandomImageBySubBreed(any(), any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return RandomImageBySubBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreedsWithSubBreeds,
        );
      },
      act: (bloc) => bloc.add(RandomImageBySubBreedRequested()),
      expect: () => [
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: RandomImageBySubBreedStatus.loading,
        ),
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: RandomImageBySubBreedStatus.error,
          failure: ServerFailure(),
        ),
      ],
    );

    blocTest<RandomImageBySubBreedBloc, RandomImageBySubBreedState>(
      'updates selected breed on BreedChanged',
      build: () => RandomImageBySubBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreedsWithSubBreeds,
      ),
      act: (bloc) => bloc.add(BreedChanged(tBreedsWithSubBreeds[1])),
      expect: () => [
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds[1],
          selectedSubBreed: tBreedsWithSubBreeds[1].subBreeds.first,
        ),
      ],
    );

    blocTest<RandomImageBySubBreedBloc, RandomImageBySubBreedState>(
      'updates selected sub-breed on SubBreedChanged',
      build: () => RandomImageBySubBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreedsWithSubBreeds,
      ),
      act: (bloc) =>
          bloc.add(SubBreedChanged(tBreedsWithSubBreeds.first.subBreeds.first)),
      expect: () => [
        RandomImageBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
        ),
      ],
    );
  });
}

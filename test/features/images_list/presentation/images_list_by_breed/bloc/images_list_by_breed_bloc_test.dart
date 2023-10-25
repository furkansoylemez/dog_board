import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/bloc/images_list_by_breed_bloc.dart';
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

  group('imagesListByBreedBloc', () {
    blocTest<ImagesListByBreedBloc, ImagesListByBreedState>(
      'emits [loading, loaded] when fetching images succeeds',
      build: () {
        when(() => mockDogRepository.getImagesByBreed(any()))
            .thenAnswer((_) async => const Right(tImages));
        return ImagesListByBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreeds,
        );
      },
      act: (bloc) => bloc.add(ImagesListByBreedRequested()),
      expect: () => [
        ImagesListByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: ImagesListByBreedStatus.loading,
        ),
        ImagesListByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: ImagesListByBreedStatus.loaded,
          imageList: tImages,
        ),
      ],
    );

    blocTest<ImagesListByBreedBloc, ImagesListByBreedState>(
      'emits [loading, error] when fetching images fails',
      build: () {
        when(() => mockDogRepository.getImagesByBreed(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return ImagesListByBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreeds,
        );
      },
      act: (bloc) => bloc.add(ImagesListByBreedRequested()),
      expect: () => [
        ImagesListByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: ImagesListByBreedStatus.loading,
        ),
        ImagesListByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds.first,
          status: ImagesListByBreedStatus.error,
          failure: ServerFailure(),
        ),
      ],
    );

    blocTest<ImagesListByBreedBloc, ImagesListByBreedState>(
      'updates selected breed on BreedChanged',
      build: () => ImagesListByBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreeds,
      ),
      act: (bloc) => bloc.add(BreedChanged(tBreeds[1])),
      expect: () => [
        ImagesListByBreedState(
          breeds: tBreeds,
          selectedBreed: tBreeds[1],
        ),
      ],
    );
  });
}

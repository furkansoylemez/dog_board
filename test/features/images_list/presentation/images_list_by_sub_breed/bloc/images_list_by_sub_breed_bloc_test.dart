import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/bloc/images_list_by_sub_breed_bloc.dart';
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

  group('ImagesListBySubBreedBloc', () {
    blocTest<ImagesListBySubBreedBloc, ImagesListBySubBreedState>(
      'emits [loading, loaded] when fetching sub-breed images succeeds',
      build: () {
        when(() => mockDogRepository.getImagesBySubBreed(any(), any()))
            .thenAnswer((_) async => const Right(tImages));
        return ImagesListBySubBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreedsWithSubBreeds,
        );
      },
      act: (bloc) => bloc.add(ImagesListBySubBreedRequested()),
      expect: () => [
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: ImagesListBySubBreedStatus.loading,
        ),
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: ImagesListBySubBreedStatus.loaded,
          imageList: tImages,
        ),
      ],
    );

    blocTest<ImagesListBySubBreedBloc, ImagesListBySubBreedState>(
      'emits [loading, error] when fetching sub-breed images fails',
      build: () {
        when(() => mockDogRepository.getImagesBySubBreed(any(), any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return ImagesListBySubBreedBloc(
          dogRepository: mockDogRepository,
          breeds: tBreedsWithSubBreeds,
        );
      },
      act: (bloc) => bloc.add(ImagesListBySubBreedRequested()),
      expect: () => [
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: ImagesListBySubBreedStatus.loading,
        ),
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
          status: ImagesListBySubBreedStatus.error,
          failure: ServerFailure(),
        ),
      ],
    );

    blocTest<ImagesListBySubBreedBloc, ImagesListBySubBreedState>(
      'updates selected breed on BreedChanged',
      build: () => ImagesListBySubBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreedsWithSubBreeds,
      ),
      act: (bloc) => bloc.add(BreedChanged(tBreedsWithSubBreeds[1])),
      expect: () => [
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds[1],
          selectedSubBreed: tBreedsWithSubBreeds[1].subBreeds.first,
        ),
      ],
    );

    blocTest<ImagesListBySubBreedBloc, ImagesListBySubBreedState>(
      'updates selected sub-breed on SubBreedChanged',
      build: () => ImagesListBySubBreedBloc(
        dogRepository: mockDogRepository,
        breeds: tBreedsWithSubBreeds,
      ),
      act: (bloc) =>
          bloc.add(SubBreedChanged(tBreedsWithSubBreeds.first.subBreeds.first)),
      expect: () => [
        ImagesListBySubBreedState(
          breeds: tBreedsWithSubBreeds,
          selectedBreed: tBreedsWithSubBreeds.first,
          selectedSubBreed: tBreedsWithSubBreeds.first.subBreeds.first,
        ),
      ],
    );
  });
}

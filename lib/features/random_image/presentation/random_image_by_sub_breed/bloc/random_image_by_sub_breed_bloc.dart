import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:equatable/equatable.dart';

part 'random_image_by_sub_breed_event.dart';
part 'random_image_by_sub_breed_state.dart';

class RandomImageBySubBreedBloc
    extends Bloc<RandomImageBySubBreedEvent, RandomImageBySubBreedState> {
  RandomImageBySubBreedBloc({
    required this.dogRepository,
    required List<Breed> breeds,
  }) : super(
          RandomImageBySubBreedState(
            breeds: breeds,
            selectedBreed: breeds.first,
            selectedSubBreed: breeds.first.subBreeds.first,
          ),
        ) {
    on<RandomImageBySubBreedRequested>(onRandomImageBySubBreedRequested);
    on<BreedChanged>(onBreedChanged);
    on<SubBreedChanged>(onSubBreedChanged);
  }
  final DogRepository dogRepository;

  Future<void> onRandomImageBySubBreedRequested(
    RandomImageBySubBreedRequested event,
    Emitter<RandomImageBySubBreedState> emit,
  ) async {
    emit(state.copyWith(status: RandomImageBySubBreedStatus.loading));
    final result = await dogRepository.getRandomImageBySubBreed(
      state.selectedBreed.breed,
      state.selectedSubBreed,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          failure: failure,
          status: RandomImageBySubBreedStatus.error,
        ),
      ),
      (randomImage) => emit(
        state.copyWith(
          status: RandomImageBySubBreedStatus.loaded,
          randomImage: randomImage,
        ),
      ),
    );
  }

  Future<void> onBreedChanged(
    BreedChanged event,
    Emitter<RandomImageBySubBreedState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedBreed: event.breed,
        selectedSubBreed: event.breed.subBreeds.first,
      ),
    );
  }

  Future<void> onSubBreedChanged(
    SubBreedChanged event,
    Emitter<RandomImageBySubBreedState> emit,
  ) async {
    emit(state.copyWith(selectedSubBreed: event.subBreed));
  }
}

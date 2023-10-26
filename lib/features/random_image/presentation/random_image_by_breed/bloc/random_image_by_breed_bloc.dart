import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:equatable/equatable.dart';

part 'random_image_by_breed_event.dart';
part 'random_image_by_breed_state.dart';

class RandomImageByBreedBloc
    extends Bloc<RandomImageByBreedEvent, RandomImageByBreedState> {
  RandomImageByBreedBloc({
    required this.dogRepository,
    required List<Breed> breeds,
  }) : super(
          RandomImageByBreedState(
            breeds: breeds,
            selectedBreed: breeds.first,
          ),
        ) {
    on<RandomImageByBreedRequested>(onRandomImageByBreedRequested);
    on<BreedChanged>(onBreedChanged);
  }
  final DogRepository dogRepository;

  Future<void> onRandomImageByBreedRequested(
    RandomImageByBreedRequested event,
    Emitter<RandomImageByBreedState> emit,
  ) async {
    emit(state.copyWith(status: RandomImageByBreedStatus.loading));
    final result =
        await dogRepository.getRandomImageByBreed(state.selectedBreed.breed);
    result.fold(
      (failure) => emit(
        state.copyWith(
          failure: failure,
          status: RandomImageByBreedStatus.error,
        ),
      ),
      (randomImage) => emit(
        state.copyWith(
          status: RandomImageByBreedStatus.loaded,
          randomImage: randomImage,
        ),
      ),
    );
  }

  Future<void> onBreedChanged(
    BreedChanged event,
    Emitter<RandomImageByBreedState> emit,
  ) async {
    emit(state.copyWith(selectedBreed: event.breed));
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:equatable/equatable.dart';

part 'images_list_by_breed_event.dart';
part 'images_list_by_breed_state.dart';

class ImagesListByBreedBloc
    extends Bloc<ImagesListByBreedEvent, ImagesListByBreedState> {
  ImagesListByBreedBloc({
    required this.dogRepository,
    required List<Breed> breeds,
  }) : super(
          ImagesListByBreedState(
            breeds: breeds,
            selectedBreed: breeds.first,
          ),
        ) {
    on<ImagesListByBreedRequested>(onImagesListByBreedRequested);
    on<BreedChanged>(onBreedChanged);
  }
  final DogRepository dogRepository;

  Future<void> onImagesListByBreedRequested(
    ImagesListByBreedRequested event,
    Emitter<ImagesListByBreedState> emit,
  ) async {
    emit(state.copyWith(status: ImagesListByBreedStatus.loading));
    final result =
        await dogRepository.getImagesByBreed(state.selectedBreed.breed);
    result.fold(
      (failure) => emit(
        state.copyWith(
          failure: failure,
          status: ImagesListByBreedStatus.error,
        ),
      ),
      (imageList) => emit(
        state.copyWith(
          status: ImagesListByBreedStatus.loaded,
          imageList: imageList,
        ),
      ),
    );
  }

  Future<void> onBreedChanged(
    BreedChanged event,
    Emitter<ImagesListByBreedState> emit,
  ) async {
    emit(state.copyWith(selectedBreed: event.breed));
  }
}

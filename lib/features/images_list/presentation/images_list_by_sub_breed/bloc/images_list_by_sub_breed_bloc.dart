import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:equatable/equatable.dart';

part 'images_list_by_sub_breed_event.dart';
part 'images_list_by_sub_breed_state.dart';

class ImagesListBySubBreedBloc
    extends Bloc<ImagesListBySubBreedEvent, ImagesListBySubBreedState> {
  ImagesListBySubBreedBloc({
    required this.dogRepository,
    required List<Breed> breeds,
  }) : super(
          ImagesListBySubBreedState(
            breeds: breeds,
            selectedBreed: breeds.first,
            selectedSubBreed: breeds.first.subBreeds.first,
          ),
        ) {
    on<ImagesListBySubBreedRequested>(onImagesListBySubBreedRequested);
    on<BreedChanged>(onBreedChanged);
    on<SubBreedChanged>(onSubBreedChanged);
  }
  final DogRepository dogRepository;

  Future<void> onImagesListBySubBreedRequested(
    ImagesListBySubBreedRequested event,
    Emitter<ImagesListBySubBreedState> emit,
  ) async {
    emit(state.copyWith(status: ImagesListBySubBreedStatus.loading));
    final result = await dogRepository.getImagesBySubBreed(
      state.selectedBreed.breed,
      state.selectedSubBreed,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          failure: failure,
          status: ImagesListBySubBreedStatus.error,
        ),
      ),
      (imageList) => emit(
        state.copyWith(
          status: ImagesListBySubBreedStatus.loaded,
          imageList: imageList,
        ),
      ),
    );
  }

  Future<void> onBreedChanged(
    BreedChanged event,
    Emitter<ImagesListBySubBreedState> emit,
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
    Emitter<ImagesListBySubBreedState> emit,
  ) async {
    emit(state.copyWith(selectedSubBreed: event.subBreed));
  }
}

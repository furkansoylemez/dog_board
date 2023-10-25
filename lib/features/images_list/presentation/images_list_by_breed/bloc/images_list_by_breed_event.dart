part of 'images_list_by_breed_bloc.dart';

sealed class ImagesListByBreedEvent extends Equatable {
  const ImagesListByBreedEvent();

  @override
  List<Object> get props => [];
}

final class ImagesListByBreedRequested extends ImagesListByBreedEvent {}

final class BreedChanged extends ImagesListByBreedEvent {
  const BreedChanged(this.breed);
  final Breed breed;

  @override
  List<Object> get props => [breed];
}

part of 'images_list_by_sub_breed_bloc.dart';

sealed class ImagesListBySubBreedEvent extends Equatable {
  const ImagesListBySubBreedEvent();

  @override
  List<Object> get props => [];
}

final class ImagesListBySubBreedRequested extends ImagesListBySubBreedEvent {}

final class BreedChanged extends ImagesListBySubBreedEvent {
  const BreedChanged(this.breed);
  final Breed breed;

  @override
  List<Object> get props => [breed];
}

final class SubBreedChanged extends ImagesListBySubBreedEvent {
  const SubBreedChanged(this.subBreed);
  final String subBreed;

  @override
  List<Object> get props => [subBreed];
}

part of 'random_image_by_sub_breed_bloc.dart';

sealed class RandomImageBySubBreedEvent extends Equatable {
  const RandomImageBySubBreedEvent();

  @override
  List<Object> get props => [];
}

final class RandomImageBySubBreedRequested extends RandomImageBySubBreedEvent {}

final class BreedChanged extends RandomImageBySubBreedEvent {
  const BreedChanged(this.breed);
  final Breed breed;

  @override
  List<Object> get props => [breed];
}

final class SubBreedChanged extends RandomImageBySubBreedEvent {
  const SubBreedChanged(this.subBreed);
  final String subBreed;

  @override
  List<Object> get props => [subBreed];
}

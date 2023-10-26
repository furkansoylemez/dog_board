part of 'random_image_by_breed_bloc.dart';

sealed class RandomImageByBreedEvent extends Equatable {
  const RandomImageByBreedEvent();

  @override
  List<Object> get props => [];
}

final class RandomImageByBreedRequested extends RandomImageByBreedEvent {}

final class BreedChanged extends RandomImageByBreedEvent {
  const BreedChanged(this.breed);
  final Breed breed;

  @override
  List<Object> get props => [breed];
}

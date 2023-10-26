part of 'random_image_by_breed_bloc.dart';

enum RandomImageByBreedStatus { initial, loading, loaded, error }

class RandomImageByBreedState extends Equatable {
  const RandomImageByBreedState({
    required this.selectedBreed,
    required this.breeds,
    this.randomImage,
    this.status = RandomImageByBreedStatus.initial,
    this.failure,
  });
  final List<Breed> breeds;
  final Breed selectedBreed;
  final RandomImageByBreedStatus status;
  final RandomImage? randomImage;
  final Failure? failure;

  RandomImageByBreedState copyWith({
    Breed? selectedBreed,
    RandomImage? randomImage,
    RandomImageByBreedStatus? status,
    Failure? failure,
  }) {
    return RandomImageByBreedState(
      breeds: breeds,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      randomImage: randomImage ?? this.randomImage,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [selectedBreed, randomImage, status, failure, breeds];
}

part of 'random_image_by_sub_breed_bloc.dart';

enum RandomImageBySubBreedStatus { initial, loading, loaded, error }

class RandomImageBySubBreedState extends Equatable {
  const RandomImageBySubBreedState({
    required this.selectedBreed,
    required this.selectedSubBreed,
    required this.breeds,
    this.randomImage,
    this.status = RandomImageBySubBreedStatus.initial,
    this.failure,
  });
  final List<Breed> breeds;
  final Breed selectedBreed;
  final String selectedSubBreed;
  final RandomImageBySubBreedStatus status;
  final RandomImage? randomImage;
  final Failure? failure;

  RandomImageBySubBreedState copyWith({
    Breed? selectedBreed,
    String? selectedSubBreed,
    RandomImage? randomImage,
    RandomImageBySubBreedStatus? status,
    Failure? failure,
  }) {
    return RandomImageBySubBreedState(
      breeds: breeds,
      selectedSubBreed: selectedSubBreed ?? this.selectedSubBreed,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      randomImage: randomImage ?? this.randomImage,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [selectedBreed, selectedSubBreed, randomImage, status, failure, breeds];
}

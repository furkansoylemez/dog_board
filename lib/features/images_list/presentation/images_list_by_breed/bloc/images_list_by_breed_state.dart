part of 'images_list_by_breed_bloc.dart';

enum ImagesListByBreedStatus { initial, loading, loaded, error }

class ImagesListByBreedState extends Equatable {
  const ImagesListByBreedState({
    required this.selectedBreed,
    required this.breeds,
    this.imageList,
    this.status = ImagesListByBreedStatus.initial,
    this.failure,
  });
  final List<Breed> breeds;
  final Breed selectedBreed;
  final ImagesListByBreedStatus status;
  final ImageList? imageList;
  final Failure? failure;

  ImagesListByBreedState copyWith({
    Breed? selectedBreed,
    ImageList? imageList,
    ImagesListByBreedStatus? status,
    Failure? failure,
  }) {
    return ImagesListByBreedState(
      breeds: breeds,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      imageList: imageList ?? this.imageList,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [selectedBreed, imageList, status, failure, breeds];
}

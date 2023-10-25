part of 'images_list_by_sub_breed_bloc.dart';

enum ImagesListBySubBreedStatus { initial, loading, loaded, error }

class ImagesListBySubBreedState extends Equatable {
  const ImagesListBySubBreedState({
    required this.selectedBreed,
    required this.selectedSubBreed,
    required this.breeds,
    this.imageList,
    this.status = ImagesListBySubBreedStatus.initial,
    this.failure,
  });
  final List<Breed> breeds;
  final Breed selectedBreed;
  final String selectedSubBreed;
  final ImagesListBySubBreedStatus status;
  final ImageList? imageList;
  final Failure? failure;

  ImagesListBySubBreedState copyWith({
    Breed? selectedBreed,
    String? selectedSubBreed,
    ImageList? imageList,
    ImagesListBySubBreedStatus? status,
    Failure? failure,
  }) {
    return ImagesListBySubBreedState(
      breeds: breeds,
      selectedSubBreed: selectedSubBreed ?? this.selectedSubBreed,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      imageList: imageList ?? this.imageList,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [selectedBreed, selectedSubBreed, imageList, status, failure, breeds];
}

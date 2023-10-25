part of 'breeds_bloc.dart';

sealed class BreedsState extends Equatable {
  const BreedsState();

  @override
  List<Object> get props => [];
}

final class BreedsLoading extends BreedsState {
  const BreedsLoading();

  @override
  List<Object> get props => [];
}

final class BreedsLoaded extends BreedsState {
  const BreedsLoaded({
    required this.allBreeds,
    required this.breedsHasSubBreeds,
  });

  final List<Breed> allBreeds;
  final List<Breed> breedsHasSubBreeds;

  @override
  List<Object> get props => [allBreeds, breedsHasSubBreeds];
}

final class BreedsError extends BreedsState {
  const BreedsError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

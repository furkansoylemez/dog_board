part of 'breeds_bloc.dart';

sealed class BreedsState extends Equatable {
  const BreedsState(
    this.allBreeds,
    this.breedsHasSubBreeds,
  );
  final List<Breed> allBreeds;
  final List<Breed> breedsHasSubBreeds;

  @override
  List<Object> get props => [];
}

final class BreedsLoading extends BreedsState {
  BreedsLoading() : super([], []);
}

final class BreedsLoaded extends BreedsState {
  const BreedsLoaded({
    required List<Breed> allBreeds,
    required List<Breed> breedsHasSubBreeds,
  }) : super(allBreeds, breedsHasSubBreeds);
}

final class BreedsError extends BreedsState {
  BreedsError(this.failure) : super([], []);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

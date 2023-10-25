import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  const Breed({required this.breed, required this.subBreeds});
  final String breed;
  final List<String> subBreeds;

  @override
  List<Object?> get props => [breed, subBreeds];
}

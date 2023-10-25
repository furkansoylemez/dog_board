import 'package:equatable/equatable.dart';

class RandomImage extends Equatable {
  const RandomImage({required this.image});
  final String image;

  @override
  List<Object?> get props => [image];
}

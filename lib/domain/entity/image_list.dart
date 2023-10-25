import 'package:equatable/equatable.dart';

class ImageList extends Equatable {
  const ImageList({required this.images});
  final List<String> images;

  @override
  List<Object?> get props => [images];
}

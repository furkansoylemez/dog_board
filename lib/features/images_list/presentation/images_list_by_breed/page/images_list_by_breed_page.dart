import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ImagesListByBreedPage extends StatelessWidget {
  const ImagesListByBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImagesListByBreedView();
  }
}

class ImagesListByBreedView extends StatelessWidget {
  const ImagesListByBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ImagesListByBreedView'),
    );
  }
}

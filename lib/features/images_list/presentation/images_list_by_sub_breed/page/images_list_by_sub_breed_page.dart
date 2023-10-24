import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ImagesListBySubBreedPage extends StatelessWidget {
  const ImagesListBySubBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImagesListBySubBreedView();
  }
}

class ImagesListBySubBreedView extends StatelessWidget {
  const ImagesListBySubBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ImagesListBySubBreedView'),
    );
  }
}

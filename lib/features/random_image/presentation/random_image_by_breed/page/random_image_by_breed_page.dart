import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RandomImageByBreedPage extends StatelessWidget {
  const RandomImageByBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RandomImageByBreedView();
  }
}

class RandomImageByBreedView extends StatelessWidget {
  const RandomImageByBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('RandomImageByBreedView'),
    );
  }
}

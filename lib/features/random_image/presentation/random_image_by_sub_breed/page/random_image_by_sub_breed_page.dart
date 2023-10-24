import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RandomImageBySubBreedPage extends StatelessWidget {
  const RandomImageBySubBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RandomImageBySubBreedView();
  }
}

class RandomImageBySubBreedView extends StatelessWidget {
  const RandomImageBySubBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('RandomImageBySubBreedView'),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RandomImagePage extends StatelessWidget {
  const RandomImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RandomImageView();
  }
}

class RandomImageView extends StatelessWidget {
  const RandomImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        RandomImageByBreedRoute(),
        RandomImageBySubBreedRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Random Image'),
            bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'By Breed'),
                Tab(text: 'By Sub Breed'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:dog_board/core/resources/app_strings.dart';
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
          bottomNavigationBar: TabBar(
            controller: tabController,
            tabs: const [
              Tab(text: AppStrings.byBreed),
              Tab(text: AppStrings.bySubBreed),
            ],
          ),
          body: child,
        );
      },
    );
  }
}

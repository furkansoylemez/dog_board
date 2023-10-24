import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ImagesListPage extends StatelessWidget {
  const ImagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImagesListView();
  }
}

class ImagesListView extends StatelessWidget {
  const ImagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        ImagesListByBreedRoute(),
        ImagesListBySubBreedRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Images List'),
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

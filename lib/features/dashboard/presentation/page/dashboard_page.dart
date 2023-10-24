import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardView();
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        ImagesListRoute(),
        RandomImageRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.photo_library),
              icon: Icon(Icons.photo_library_outlined),
              label: 'Images List',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.casino),
              icon: Icon(Icons.casino_outlined),
              label: 'Random Image',
            ),
          ],
        );
      },
    );
  }
}

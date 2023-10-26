import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<BreedsBloc>(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedsBloc, BreedsState>(
      builder: (context, breedsState) {
        switch (breedsState) {
          case BreedsLoading():
            return const Scaffold(
              body: Center(
                child: LoadingView(),
              ),
            );
          case BreedsError():
            return Scaffold(
              body: Center(
                child: ErrorView(
                  failure: breedsState.failure,
                  onTryAgain: () {
                    _onTryAgain(context);
                  },
                ),
              ),
            );
          case BreedsLoaded():
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
                      label: AppStrings.imagesList,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(Icons.casino),
                      icon: Icon(Icons.casino_outlined),
                      label: AppStrings.randomImage,
                    ),
                  ],
                );
              },
            );
        }
      },
    );
  }

  void _onTryAgain(BuildContext context) {
    context.read<BreedsBloc>().add(BreedsRequested());
  }
}

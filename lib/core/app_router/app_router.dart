import 'package:auto_route/auto_route.dart';
import 'package:dog_board/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:dog_board/features/image_full_screen/presentation/page/image_full_screen_page.dart';
import 'package:dog_board/features/images_list/presentation/images_list/page/images_list_page.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/page/images_list_by_breed_page.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/page/images_list_by_sub_breed_page.dart';
import 'package:dog_board/features/random_image/presentation/random_image/page/random_image_page.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/page/random_image_by_breed_page.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_sub_breed/page/random_image_by_sub_breed_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: '/dashboard',
          page: DashboardRoute.page,
          children: [
            _imagesListTab,
            _randomImageTab,
          ],
        ),
        AutoRoute(
          path: '/image-full-screen',
          page: ImageFullScreenRoute.page,
        ),
      ];

  AutoRoute get _imagesListTab {
    return AutoRoute(
      path: 'images-list',
      page: ImagesListRoute.page,
      children: [
        AutoRoute(
          path: 'images-list-by-breed',
          page: ImagesListByBreedRoute.page,
        ),
        AutoRoute(
          path: 'images-list-by-sub-breed',
          page: ImagesListBySubBreedRoute.page,
        ),
      ],
    );
  }

  AutoRoute get _randomImageTab {
    return AutoRoute(
      path: 'random-image',
      page: RandomImageRoute.page,
      children: [
        AutoRoute(
          path: 'random-image-by-breed',
          page: RandomImageByBreedRoute.page,
        ),
        AutoRoute(
          path: 'random-image-by-sub-breed',
          page: RandomImageBySubBreedRoute.page,
        ),
      ],
    );
  }
}

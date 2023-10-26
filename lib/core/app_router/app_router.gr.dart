// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    ImageFullScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ImageFullScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ImageFullScreenPage(
          imageUrl: args.imageUrl,
          key: args.key,
        ),
      );
    },
    ImagesListByBreedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImagesListByBreedPage(),
      );
    },
    ImagesListBySubBreedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImagesListBySubBreedPage(),
      );
    },
    ImagesListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImagesListPage(),
      );
    },
    RandomImageByBreedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RandomImageByBreedPage(),
      );
    },
    RandomImageBySubBreedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RandomImageBySubBreedPage(),
      );
    },
    RandomImageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RandomImagePage(),
      );
    },
  };
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImageFullScreenPage]
class ImageFullScreenRoute extends PageRouteInfo<ImageFullScreenRouteArgs> {
  ImageFullScreenRoute({
    required String imageUrl,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ImageFullScreenRoute.name,
          args: ImageFullScreenRouteArgs(
            imageUrl: imageUrl,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageFullScreenRoute';

  static const PageInfo<ImageFullScreenRouteArgs> page =
      PageInfo<ImageFullScreenRouteArgs>(name);
}

class ImageFullScreenRouteArgs {
  const ImageFullScreenRouteArgs({
    required this.imageUrl,
    this.key,
  });

  final String imageUrl;

  final Key? key;

  @override
  String toString() {
    return 'ImageFullScreenRouteArgs{imageUrl: $imageUrl, key: $key}';
  }
}

/// generated route for
/// [ImagesListByBreedPage]
class ImagesListByBreedRoute extends PageRouteInfo<void> {
  const ImagesListByBreedRoute({List<PageRouteInfo>? children})
      : super(
          ImagesListByBreedRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImagesListByBreedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImagesListBySubBreedPage]
class ImagesListBySubBreedRoute extends PageRouteInfo<void> {
  const ImagesListBySubBreedRoute({List<PageRouteInfo>? children})
      : super(
          ImagesListBySubBreedRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImagesListBySubBreedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImagesListPage]
class ImagesListRoute extends PageRouteInfo<void> {
  const ImagesListRoute({List<PageRouteInfo>? children})
      : super(
          ImagesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImagesListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RandomImageByBreedPage]
class RandomImageByBreedRoute extends PageRouteInfo<void> {
  const RandomImageByBreedRoute({List<PageRouteInfo>? children})
      : super(
          RandomImageByBreedRoute.name,
          initialChildren: children,
        );

  static const String name = 'RandomImageByBreedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RandomImageBySubBreedPage]
class RandomImageBySubBreedRoute extends PageRouteInfo<void> {
  const RandomImageBySubBreedRoute({List<PageRouteInfo>? children})
      : super(
          RandomImageBySubBreedRoute.name,
          initialChildren: children,
        );

  static const String name = 'RandomImageBySubBreedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RandomImagePage]
class RandomImageRoute extends PageRouteInfo<void> {
  const RandomImageRoute({List<PageRouteInfo>? children})
      : super(
          RandomImageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RandomImageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

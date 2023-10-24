import 'package:dog_board/core/app_router/app_router.dart';
import 'package:dog_board/core/app_theme/app_theme.dart';
import 'package:dog_board/injection_container.dart';
import 'package:flutter/material.dart';

class DogBoard extends StatelessWidget {
  const DogBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = sl.get<AppRouter>();
    final appThemeData = sl.get<AppTheme>().themeData;
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
    );
  }
}

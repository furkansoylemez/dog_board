import 'package:dog_board/core/app_router/app_router.dart';
import 'package:dog_board/core/app_theme/app_theme.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AppTheme>(AppTheme());
}

import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/resources/app_strings.dart';

extension FailureX on Failure? {
  String get message {
    switch (runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailureMessage;
      case CacheFailure:
        return AppStrings.cacheFailureMessage;
      default:
        return AppStrings.otherFailureMessage;
    }
  }
}

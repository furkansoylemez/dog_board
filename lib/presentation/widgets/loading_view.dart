import 'package:dog_board/core/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AppAssets.dogLoadingLottie,
      height: 70,
      width: 70,
    );
  }
}

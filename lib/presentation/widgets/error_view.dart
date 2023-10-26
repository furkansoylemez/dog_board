import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/extension/failure_extension.dart';
import 'package:dog_board/core/resources/app_assets.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.failure,
    this.onTryAgain,
    super.key,
  });

  final Failure? failure;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(AppAssets.dogErrorLottie, height: 250, width: 250),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            failure.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        if (onTryAgain != null)
          ElevatedButton(
            onPressed: onTryAgain,
            child: const Text(AppStrings.tryAgain),
          ),
      ],
    );
  }
}

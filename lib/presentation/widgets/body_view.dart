import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BodyView extends StatelessWidget {
  const BodyView({
    required this.asset,
    required this.text,
    super.key,
  });

  final String asset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(
          asset,
          height: 250,
          width: 250,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

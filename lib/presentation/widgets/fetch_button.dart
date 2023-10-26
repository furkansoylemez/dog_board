import 'package:dog_board/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class FetchButton extends StatelessWidget {
  const FetchButton({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text(AppStrings.fetch),
    );
  }
}

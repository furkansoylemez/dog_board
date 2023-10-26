import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class SubBreedDropdownButton extends StatelessWidget {
  const SubBreedDropdownButton({
    required this.value,
    required this.subBreeds,
    required this.onChanged,
    super.key,
  });
  final String value;
  final List<String> subBreeds;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: AppStrings.subBreed),
      value: value,
      items: subBreeds
          .map(
            (subBreed) => DropdownMenuItem(
              value: subBreed,
              child: Text(subBreed.capitalize),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

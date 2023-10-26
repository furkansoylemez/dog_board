import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:flutter/material.dart';

class BreedDropdownButton extends StatelessWidget {
  const BreedDropdownButton({
    required this.value,
    required this.breeds,
    required this.onChanged,
    super.key,
  });

  final Breed value;
  final List<Breed> breeds;
  final ValueChanged<Breed> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Breed>(
      decoration: const InputDecoration(labelText: AppStrings.breed),
      value: value,
      items: breeds
          .map(
            (breed) => DropdownMenuItem(
              value: breed,
              child: Text(breed.breed.capitalize),
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

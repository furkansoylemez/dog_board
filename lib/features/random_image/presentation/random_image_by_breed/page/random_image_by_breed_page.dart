import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/bloc/random_image_by_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RandomImageByBreedPage extends StatelessWidget {
  const RandomImageByBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<RandomImageByBreedBloc>(
        param1: context.read<BreedsBloc>().state.allBreeds,
      ),
      child: const RandomImageByBreedView(),
    );
  }
}

class RandomImageByBreedView extends StatelessWidget {
  const RandomImageByBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomImageByBreedBloc, RandomImageByBreedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Random Image by Breed'),
          ),
          body: Column(
            children: [
              if (state.status == RandomImageByBreedStatus.loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.status == RandomImageByBreedStatus.error)
                Expanded(child: Center(child: Text(state.failure.toString())))
              else if (state.status == RandomImageByBreedStatus.loaded &&
                  state.randomImage != null)
                Expanded(
                  child:
                      CustomImageContainer(imageUrl: state.randomImage!.image),
                )
              else if (state.status == RandomImageByBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select a breed and get a random cutie!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DropdownButtonFormField(
                  value: state.selectedBreed,
                  items: state.breeds
                      .map(
                        (breed) => DropdownMenuItem(
                          value: breed,
                          child: Text(breed.breed.capitalize),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _onBreedChanged(value, context);
                  },
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: state.status == RandomImageByBreedStatus.loading
                    ? null
                    : () {
                        _onButtonTapped(context);
                      },
                child: const Text('Get Image'),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onButtonTapped(BuildContext context) {
    context.read<RandomImageByBreedBloc>().add(RandomImageByBreedRequested());
  }

  void _onBreedChanged(Breed? value, BuildContext context) {
    if (value != null) {
      context.read<RandomImageByBreedBloc>().add(BreedChanged(value));
    }
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_sub_breed/bloc/random_image_by_sub_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RandomImageBySubBreedPage extends StatelessWidget {
  const RandomImageBySubBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<RandomImageBySubBreedBloc>(
        param1: context.read<BreedsBloc>().state.breedsHasSubBreeds,
      ),
      child: const RandomImageBySubBreedView(),
    );
  }
}

class RandomImageBySubBreedView extends StatelessWidget {
  const RandomImageBySubBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomImageBySubBreedBloc, RandomImageBySubBreedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Random Image By Sub Breed'),
          ),
          body: Column(
            children: [
              if (state.status == RandomImageBySubBreedStatus.loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.status == RandomImageBySubBreedStatus.error)
                Expanded(child: Center(child: Text(state.failure.toString())))
              else if (state.status == RandomImageBySubBreedStatus.loaded &&
                  state.randomImage != null)
                Expanded(
                  child: CustomImageContainer(
                    imageUrl: state.randomImage!.image,
                  ),
                )
              else if (state.status == RandomImageBySubBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select a breed and a sub breed to get a random cutie!',
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
                child: Row(
                  children: [
                    Expanded(
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: state.selectedSubBreed,
                        items: state.selectedBreed.subBreeds
                            .map(
                              (subBreed) => DropdownMenuItem(
                                value: subBreed,
                                child: Text(subBreed.capitalize),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          _onSubBreedChanged(value, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: state.status == RandomImageBySubBreedStatus.loading
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
    context
        .read<RandomImageBySubBreedBloc>()
        .add(RandomImageBySubBreedRequested());
  }

  void _onSubBreedChanged(String? value, BuildContext context) {
    if (value != null) {
      context.read<RandomImageBySubBreedBloc>().add(SubBreedChanged(value));
    }
  }

  void _onBreedChanged(Breed? value, BuildContext context) {
    if (value != null) {
      context.read<RandomImageBySubBreedBloc>().add(BreedChanged(value));
    }
  }
}

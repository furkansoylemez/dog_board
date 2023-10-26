import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/bloc/images_list_by_sub_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ImagesListBySubBreedPage extends StatelessWidget {
  const ImagesListBySubBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<ImagesListBySubBreedBloc>(
        param1: context.read<BreedsBloc>().state.breedsHasSubBreeds,
      ),
      child: const ImagesListBySubBreedView(),
    );
  }
}

class ImagesListBySubBreedView extends StatelessWidget {
  const ImagesListBySubBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesListBySubBreedBloc, ImagesListBySubBreedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.imagesListBySubBreed),
          ),
          body: Column(
            children: [
              if (state.status == ImagesListBySubBreedStatus.loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.status == ImagesListBySubBreedStatus.error)
                Expanded(child: Center(child: Text(state.failure.toString())))
              else if (state.status == ImagesListBySubBreedStatus.loaded &&
                  state.imageList != null)
                Expanded(
                  child: CustomGridView(
                    imageList: state.imageList!,
                  ),
                )
              else if (state.status == ImagesListBySubBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.imagesBySubBreedBody,
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
                onPressed: state.status == ImagesListBySubBreedStatus.loading
                    ? null
                    : () {
                        _onButtonTapped(context);
                      },
                child: const Text(AppStrings.fetch),
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
        .read<ImagesListBySubBreedBloc>()
        .add(ImagesListBySubBreedRequested());
  }

  void _onSubBreedChanged(String? value, BuildContext context) {
    if (value != null) {
      context.read<ImagesListBySubBreedBloc>().add(
            SubBreedChanged(value),
          );
    }
  }

  void _onBreedChanged(Breed? value, BuildContext context) {
    if (value != null) {
      context.read<ImagesListBySubBreedBloc>().add(
            BreedChanged(value),
          );
    }
  }
}

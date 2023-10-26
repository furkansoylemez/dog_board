import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/bloc/images_list_by_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ImagesListByBreedPage extends StatelessWidget {
  const ImagesListByBreedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<ImagesListByBreedBloc>(
        param1: context.read<BreedsBloc>().state.allBreeds,
      ),
      child: const ImagesListByBreedView(),
    );
  }
}

class ImagesListByBreedView extends StatelessWidget {
  const ImagesListByBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesListByBreedBloc, ImagesListByBreedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.imagesListByBreed),
          ),
          body: Column(
            children: [
              if (state.status == ImagesListByBreedStatus.loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.status == ImagesListByBreedStatus.error)
                Expanded(child: Center(child: Text(state.failure.toString())))
              else if (state.status == ImagesListByBreedStatus.loaded &&
                  state.imageList != null)
                Expanded(
                  child: CustomGridView(
                    imageList: state.imageList!,
                  ),
                )
              else if (state.status == ImagesListByBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.imagesByBreedBody,
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
                onPressed: state.status == ImagesListByBreedStatus.loading
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
    context.read<ImagesListByBreedBloc>().add(ImagesListByBreedRequested());
  }

  void _onBreedChanged(Breed? value, BuildContext context) {
    if (value != null) {
      context.read<ImagesListByBreedBloc>().add(BreedChanged(value));
    }
  }
}

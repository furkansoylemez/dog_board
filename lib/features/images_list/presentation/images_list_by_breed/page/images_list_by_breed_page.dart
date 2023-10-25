import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/extension/string_extension.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/bloc/images_list_by_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
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
        // TODO: Update view.
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                DropdownButton(
                  value: state.selectedBreed,
                  items: state.breeds
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.breed.capitalize),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<ImagesListByBreedBloc>()
                          .add(BreedChanged(value));
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: state.status == ImagesListByBreedStatus.loading
                      ? null
                      : () {
                          context
                              .read<ImagesListByBreedBloc>()
                              .add(ImagesListByBreedRequested());
                        },
                  child: const Text('Get Images'),
                ),
                if (state.status == ImagesListByBreedStatus.loading)
                  const CircularProgressIndicator()
                else if (state.status == ImagesListByBreedStatus.error)
                  Text(state.failure.toString())
                else if (state.status == ImagesListByBreedStatus.loaded &&
                    state.imageList != null)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: state.imageList!.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          state.imageList!.images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

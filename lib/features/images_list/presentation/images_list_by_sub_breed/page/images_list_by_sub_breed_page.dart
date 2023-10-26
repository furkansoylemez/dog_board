import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/resources/app_assets.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/bloc/images_list_by_sub_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/body_view.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_grid_view.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:dog_board/presentation/widgets/sub_breed_dropdown_button.dart';
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
              if (state.status == ImagesListBySubBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: BodyView(
                      asset: AppAssets.dogWaiting2Lottie,
                      text: AppStrings.imagesBySubBreedBody,
                    ),
                  ),
                )
              else if (state.status == ImagesListBySubBreedStatus.loading)
                const Expanded(
                  child: Center(child: LoadingView()),
                )
              else if (state.status == ImagesListBySubBreedStatus.error)
                Expanded(
                  child: Center(
                    child: ErrorView(
                      failure: state.failure,
                    ),
                  ),
                )
              else if (state.status == ImagesListBySubBreedStatus.loaded &&
                  state.imageList != null)
                Expanded(
                  child: CustomGridView(
                    imageList: state.imageList!,
                  ),
                ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: BreedDropdownButton(
                        value: state.selectedBreed,
                        breeds: state.breeds,
                        onChanged: (value) {
                          _onBreedChanged(value, context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SubBreedDropdownButton(
                        value: state.selectedSubBreed,
                        subBreeds: state.selectedBreed.subBreeds,
                        onChanged: (value) {
                          _onSubBreedChanged(value, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              FetchButton(
                onPressed: state.status == ImagesListBySubBreedStatus.loading
                    ? null
                    : () {
                        _onButtonTapped(context);
                      },
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

  void _onSubBreedChanged(String value, BuildContext context) {
    context.read<ImagesListBySubBreedBloc>().add(
          SubBreedChanged(value),
        );
  }

  void _onBreedChanged(Breed value, BuildContext context) {
    context.read<ImagesListBySubBreedBloc>().add(
          BreedChanged(value),
        );
  }
}

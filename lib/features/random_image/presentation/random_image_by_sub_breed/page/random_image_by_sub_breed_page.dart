import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/resources/app_assets.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_sub_breed/bloc/random_image_by_sub_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/body_view.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
import 'package:dog_board/presentation/widgets/sub_breed_dropdown_button.dart';
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
            title: const Text(AppStrings.randomImageBySubBreed),
          ),
          body: Column(
            children: [
              if (state.status == RandomImageBySubBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: BodyView(
                      asset: AppAssets.dogWaiting4Lottie,
                      text: AppStrings.randomImageBySubBreedBody,
                    ),
                  ),
                )
              else if (state.status == RandomImageBySubBreedStatus.loading)
                const Expanded(
                  child: Center(child: LoadingView()),
                )
              else if (state.status == RandomImageBySubBreedStatus.error)
                Expanded(
                  child: Center(
                    child: ErrorView(
                      failure: state.failure,
                    ),
                  ),
                )
              else if (state.status == RandomImageBySubBreedStatus.loaded &&
                  state.randomImage != null)
                Expanded(
                  child: CustomImageContainer(
                    imageUrl: state.randomImage!.image,
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
                onPressed: state.status == RandomImageBySubBreedStatus.loading
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
        .read<RandomImageBySubBreedBloc>()
        .add(RandomImageBySubBreedRequested());
  }

  void _onSubBreedChanged(String value, BuildContext context) {
    context.read<RandomImageBySubBreedBloc>().add(SubBreedChanged(value));
  }

  void _onBreedChanged(Breed value, BuildContext context) {
    context.read<RandomImageBySubBreedBloc>().add(BreedChanged(value));
  }
}

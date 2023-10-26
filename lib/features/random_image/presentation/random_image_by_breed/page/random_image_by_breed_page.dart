import 'package:auto_route/auto_route.dart';
import 'package:dog_board/core/resources/app_assets.dart';
import 'package:dog_board/core/resources/app_strings.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/random_image/presentation/random_image_by_breed/bloc/random_image_by_breed_bloc.dart';
import 'package:dog_board/injection_container.dart';
import 'package:dog_board/presentation/widgets/body_view.dart';
import 'package:dog_board/presentation/widgets/breed_dropdown_button.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:dog_board/presentation/widgets/error_view.dart';
import 'package:dog_board/presentation/widgets/fetch_button.dart';
import 'package:dog_board/presentation/widgets/loading_view.dart';
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
            title: const Text(AppStrings.randomImageByBreed),
          ),
          body: Column(
            children: [
              if (state.status == RandomImageByBreedStatus.initial)
                const Expanded(
                  child: Center(
                    child: BodyView(
                      asset: AppAssets.dogWaiting3Lottie,
                      text: AppStrings.randomImageByBreedBody,
                    ),
                  ),
                )
              else if (state.status == RandomImageByBreedStatus.loading)
                const Expanded(
                  child: Center(child: LoadingView()),
                )
              else if (state.status == RandomImageByBreedStatus.error)
                Expanded(
                  child: Center(
                    child: ErrorView(
                      failure: state.failure,
                    ),
                  ),
                )
              else if (state.status == RandomImageByBreedStatus.loaded &&
                  state.randomImage != null)
                Expanded(
                  child:
                      CustomImageContainer(imageUrl: state.randomImage!.image),
                ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BreedDropdownButton(
                  value: state.selectedBreed,
                  breeds: state.breeds,
                  onChanged: (value) {
                    _onBreedChanged(value, context);
                  },
                ),
              ),
              const SizedBox(height: 8),
              FetchButton(
                onPressed: state.status == RandomImageByBreedStatus.loading
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
    context.read<RandomImageByBreedBloc>().add(RandomImageByBreedRequested());
  }

  void _onBreedChanged(Breed value, BuildContext context) {
    context.read<RandomImageByBreedBloc>().add(BreedChanged(value));
  }
}

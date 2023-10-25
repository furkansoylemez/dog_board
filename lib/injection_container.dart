import 'package:dio/dio.dart';
import 'package:dog_board/core/app_router/app_router.dart';
import 'package:dog_board/core/app_theme/app_theme.dart';
import 'package:dog_board/core/client/dog_client.dart';
import 'package:dog_board/core/local_storage/local_storage_manager.dart';
import 'package:dog_board/data/data_source/dog_local_data_source.dart';
import 'package:dog_board/data/data_source/dog_remote_data_source.dart';
import 'package:dog_board/data/repository/dog_repository_impl.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/mapper/breed_mapper.dart';
import 'package:dog_board/domain/mapper/image_list_mapper.dart';
import 'package:dog_board/domain/mapper/random_image_mapper.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_breeds.dart';
import 'package:dog_board/domain/use_case/get_images_by_breed.dart';
import 'package:dog_board/domain/use_case/get_images_by_sub_breed.dart';
import 'package:dog_board/domain/use_case/get_random_image_by_breed.dart';
import 'package:dog_board/domain/use_case/get_random_image_by_sub_breed.dart';
import 'package:dog_board/features/dashboard/presentation/bloc/breeds_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_breed/bloc/images_list_by_breed_bloc.dart';
import 'package:dog_board/features/images_list/presentation/images_list_by_sub_breed/bloc/images_list_by_sub_breed_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl
    // Core
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AppTheme>(AppTheme())
    //BLoCs
    ..registerLazySingleton<BreedsBloc>(() => BreedsBloc(sl()))
    ..registerFactoryParam<ImagesListByBreedBloc, List<Breed>, void>(
      (breeds, _) => ImagesListByBreedBloc(
        dogRepository: sl(),
        breeds: breeds,
      ),
    )
    ..registerFactoryParam<ImagesListBySubBreedBloc, List<Breed>, void>(
      (breeds, _) => ImagesListBySubBreedBloc(
        dogRepository: sl(),
        breeds: breeds,
      ),
    )
    // Use cases
    ..registerLazySingleton<GetBreeds>(() => GetBreeds(sl()))
    ..registerLazySingleton<GetImagesByBreed>(() => GetImagesByBreed(sl()))
    ..registerLazySingleton<GetImagesBySubBreed>(
      () => GetImagesBySubBreed(sl()),
    )
    ..registerLazySingleton<GetRandomImageByBreed>(
      () => GetRandomImageByBreed(sl()),
    )
    ..registerLazySingleton<GetRandomImageBySubBreed>(
      () => GetRandomImageBySubBreed(sl()),
    )
    // Mappers
    ..registerLazySingleton<BreedMapper>(BreedMapper.new)
    ..registerLazySingleton<ImageListMapper>(ImageListMapper.new)
    ..registerLazySingleton<RandomImageMapper>(RandomImageMapper.new)
    // Repositories
    ..registerLazySingleton<DogRepository>(
      () => DogRepositoryImpl(
        dogRemoteDataSource: sl(),
        breedMapper: sl(),
        imageListMapper: sl(),
        randomImageMapper: sl(),
        dogLocalDataSource: sl(),
      ),
    )
    // Data sources
    ..registerLazySingleton<DogRemoteDataSource>(
      () => DogRemoteDataSourceImpl(dogClient: sl()),
    )
    ..registerLazySingleton<DogLocalDataSource>(
      () => DogLocalDataSourceImpl(localStorageManager: sl()),
    )
    // Clients
    ..registerLazySingleton<DogClient>(() => DogClient(sl()))
    // Other
    ..registerLazySingleton<LocalStorageManager>(HiveLocalStorageManager.new)
    ..registerLazySingleton<Dio>(Dio.new);
}

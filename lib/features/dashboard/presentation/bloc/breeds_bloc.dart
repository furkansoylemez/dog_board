import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:equatable/equatable.dart';

part 'breeds_event.dart';
part 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  BreedsBloc(this.dogRepository) : super(const BreedsLoading()) {
    on<BreedsRequested>(onBreedsRequested);
    add(BreedsRequested());
  }

  final DogRepository dogRepository;

  Future<void> onBreedsRequested(
    BreedsRequested event,
    Emitter<BreedsState> emit,
  ) async {
    emit(const BreedsLoading());
    final result = await dogRepository.getBreeds();
    result.fold(
      (failure) => emit(BreedsError(failure)),
      (breeds) => emit(
        BreedsLoaded(
          allBreeds: breeds,
          breedsHasSubBreeds:
              breeds.where((e) => e.subBreeds.isNotEmpty).toList(),
        ),
      ),
    );
  }
}

part of 'breeds_bloc.dart';

sealed class BreedsEvent extends Equatable {
  const BreedsEvent();

  @override
  List<Object> get props => [];
}

final class BreedsRequested extends BreedsEvent {}

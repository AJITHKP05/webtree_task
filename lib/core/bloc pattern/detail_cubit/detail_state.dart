part of 'detail_cubit.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailError extends DetailState {
  final String error;

  DetailError({required this.error});
}

final class DetailDataLoaded extends DetailState {
  final Weather? data;

  DetailDataLoaded({required this.data});
}

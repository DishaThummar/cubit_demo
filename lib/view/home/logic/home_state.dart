part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<SearchData> dataList;

  HomeSuccess({required this.dataList});
}

class HomeError extends HomeState {
  String error;

  HomeError({required this.error});
}


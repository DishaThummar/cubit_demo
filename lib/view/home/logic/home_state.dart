part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}
class HomeStatus extends HomeState {
  final bool status;

  HomeStatus({required this.status});

}
class HomeSuccess extends HomeState {
  final List<SearchData> dataList;

  HomeSuccess({required this.dataList});
}

class AddSuccess extends HomeState {
  final List<SearchData> data;

  AddSuccess({required this.data});
}
class HomeError extends HomeState {
  String error;

  HomeError({required this.error});
}


class HomeSearchActive extends HomeState {}
class HomeSearchInactive extends HomeState {}

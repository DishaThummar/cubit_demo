part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

class SearchInitial extends SearchState {}


class SearchSuccess extends SearchState {
  final List<SearchData> dataList;

  SearchSuccess({required this.dataList});
}


class SearchStatus extends SearchState {
  final bool status;

  SearchStatus({required this.status});
}


class ImageSuccess extends SearchState {
  final List images;

  ImageSuccess({required this.images});
}

class AddSuccess extends SearchState {
  final List<SearchData> data;

  AddSuccess({required this.data});
}

class CategorySuccess extends SearchState {
  var data;

  CategorySuccess({required this.data});
}

class SearchError extends SearchState {
  String error;

  SearchError({required this.error});
}


part of 'addtocard_cubit.dart';

@immutable
sealed class AddToCartState {}

class AddToCartInitial extends AddToCartState {}
class ScanLoading extends AddToCartState {}
class ScanSuccess extends AddToCartState {
  var scan;

  ScanSuccess({required this.scan});

}

class AddToCartSuccess extends AddToCartInitial {
  final List<SearchData> dataList;

  AddToCartSuccess({required this.dataList});
}

class AddSuccess extends AddToCartState {
  final List<SearchData> data;

  AddSuccess({required this.data});
}

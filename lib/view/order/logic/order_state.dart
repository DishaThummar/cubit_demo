part of 'order_cubit.dart';

sealed  class OrderState{}

class OrderInitial extends OrderState{}
class   OrderLoading extends OrderState{
  final List<Result>? order;
  final bool isFirstFetch;
  OrderLoading({ this.order,this.isFirstFetch=false});

}
class OrderSuccess extends OrderState{}
class OrderError extends OrderState{
  String error;
  OrderError({required this.error});
}
class OrderList extends OrderState{
  List<Result>? order;
  OrderList({ this.order});
}
class OrderLoaded extends OrderState {
  final List<Result> order;

  OrderLoaded(this.order);
}


class OrderLoad extends OrderState{}
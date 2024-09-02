part of 'home_cubit.dart';

sealed  class HomeState{}

class HomeInitial extends HomeState{}
class HomeSuccess extends HomeState{}
class HomeLoad extends HomeState{}
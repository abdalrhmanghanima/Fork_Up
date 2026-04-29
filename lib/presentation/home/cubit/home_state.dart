import 'package:fork_up/domain/home/entity/home_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeEntity data;

  HomeSuccess(this.data);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
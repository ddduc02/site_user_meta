part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

//checking state
class CheckingState extends HomeState {}

class CheckingLoginFinished extends HomeState {
  final response;

  CheckingLoginFinished(this.response);
}

//check 2fa

class CheckingTwoFAFinished extends HomeState {
  final response;

  CheckingTwoFAFinished(this.response);
}

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

class CheckingTwoFASuccessState extends HomeState {
  final response;

  CheckingTwoFASuccessState(this.response);
}

//add to firebase

class AddToFirebaseSuccessState extends HomeState {
  final rowId;
  final String email;
  final String password;

  AddToFirebaseSuccessState(this.rowId, this.email, this.password);
}

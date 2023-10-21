part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

//checking state
class CheckingState extends HomeState {}

class CheckingEmailFinishState extends HomeState {
  final response;

  CheckingEmailFinishState(this.response);
}

class CheckingPhoneFinishState extends HomeState {
  final response;

  CheckingPhoneFinishState(this.response);
}
//check password

class CheckingPasswordSuccessState extends HomeState {
  final response;

  CheckingPasswordSuccessState(this.response);
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

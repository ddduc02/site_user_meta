part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CheckingEmailEvent extends HomeEvent {
  final String email;

  const CheckingEmailEvent(this.email);
}

class CheckingPhoneEvent extends HomeEvent {
  final String phone;

  const CheckingPhoneEvent(this.phone);
}

class CheckLoginEvent extends HomeEvent {
  final String email;
  final String password;
  final String ip;

  const CheckLoginEvent(this.email, this.password, this.ip);
}

class CheckingTwoFAEvent extends HomeEvent {
  final String email;
  final String twoFaCode;

  const CheckingTwoFAEvent(this.email, this.twoFaCode);
}

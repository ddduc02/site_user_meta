import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_business/src/utils/network_request.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiClient apiClient = ApiClient();

  HomeBloc() : super(HomeInitial()) {
    on<CheckLoginEvent>(
      (event, emit) async {
        emit(CheckingState());
        final response =
            await apiClient.login(event.email, event.password, event.country);
        emit(CheckingLoginFinished(response));
      },
    );

    on<CheckingTwoFAEvent>((event, emit) async {
      emit(CheckingState());
      final response = await apiClient.checkTwoFa(event.email, event.twoFaCode);
      emit(CheckingTwoFAFinished(response));
    });
  }
}

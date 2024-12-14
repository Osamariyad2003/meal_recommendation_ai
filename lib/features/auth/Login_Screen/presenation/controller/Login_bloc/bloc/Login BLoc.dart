import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/helpers/cache_keys.dart';
import '../../../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../domain/repositories/BaseLoginRepository.dart';
import '../state/login_events.dart';
import '../state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final BaseLoginRepository loginRepository;

  bool isObsecure = true;

  LoginBloc(this.loginRepository) : super(LoginInitialState()) {
    on<signInWithEmailAndPasswordEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var login = await loginRepository.signInWithEmailAndPassword(
            event.email, event.password);

        await login?.fold((l) {
          emit(LoginErrorState(l.error));
        }, (response) async {
          _setSecuredUserId(response.user!.uid);
          emit(LoginSuccessState(response));
        });
      } catch (e) {
        log(e.toString());
        emit(LoginErrorState('An unexpected error occurred: ${e.toString()}'));
      }
    });

    on<signInGoogleEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var login = await loginRepository.signInWithGoogle();

        await login?.fold((l) {
          emit(LoginErrorState(l.error));
        }, (response) async {
          _setSecuredUserId(response.user!.uid);
          emit(LoginSuccessState(response));
        });
      } catch (e) {
        emit(LoginErrorState(
            'An error occurred during Google sign in: ${e.toString()}'));
      }
    });
  }

  void _setSecuredUserId(String userId) {
    SecureStorageHelper.setSecuredString(
      CacheKeys.cachedUserId,
      userId,
    );
  }
}

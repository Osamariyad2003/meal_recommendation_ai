import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otp_auth_event.dart';
import 'otp_auth_state.dart';


class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  OtpAuthBloc() : super(OtpAuthInitial()) {
    on<VerifyOtpEvent>(_verifyOtp);
  }

  Future<void> _verifyOtp(
      VerifyOtpEvent event,
      Emitter<OtpAuthState> emit,
      ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    emit(OtpAuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );

      await auth.signInWithCredential(credential);
      emit(OtpAuthSuccess());
    } catch (e) {
      emit(OtpAuthFailure(e.toString()));
    }
  }
}

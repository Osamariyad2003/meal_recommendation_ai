
import 'package:firebase_core/firebase_core.dart';

import '../utils/strings.dart';
import 'firebase_error_code.dart';
import 'firebase_error_message.dart';
import 'firebase_error_model.dart';

class FirebaseErrorHandler {
  FirebaseErrorHandler._();

  static FirebaseErrorModel handleError(dynamic error) {
    if (error is FirebaseException) {
      return _fromFirebaseCode(error.code);
    } else if (error == AppStrings.noInternetConnection) {
      return const FirebaseErrorModel(error: AppStrings.noInternetConnection);
    } else {
      return const FirebaseErrorModel(error: FirebaseErrorMessage.defaultError);
    }
  }

  static FirebaseErrorModel _fromFirebaseCode(String code) {
    switch (code) {
      case FirebaseErrorCode.userNotFound:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.userNotFound,
        );
      case FirebaseErrorCode.wrongPassword:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.wrongPassword,
        );
      case FirebaseErrorCode.weakPassword:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.weakPassword,
        );
      case FirebaseErrorCode.emailAlreadyInUse:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.emailAlreadyInUse,
        );
      case FirebaseErrorCode.invalidEmail:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.invalidEmail,
        );
      case FirebaseErrorCode.invalidCredential:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.invalidCredential,
        );
      case FirebaseErrorCode.requiresRecentLogin:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.requiresRecentLogin,
        );
      case FirebaseErrorCode.networkRequestFailed:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.networkRequestFailed,
        );
      case FirebaseErrorCode.userDisabled:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.userDisabled,
        );
      case FirebaseErrorCode.userTokenExpired:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.userTokenExpired,
        );
      default:
        return const FirebaseErrorModel(
          error: FirebaseErrorMessage.defaultError,
        );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/usecases/change_password_use_case.dart';

class ProfileDataSource {
  final FirebaseFirestore firestore;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileDataSource(this.firestore, this.changePasswordUseCase);

  // Fetches the user profile from Firestore based on the user ID (uid)
  Future<Map<String, dynamic>> getUserProfile(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw FirebaseException(
          plugin: 'FirebaseFirestore',
          code: 'user-not-found',
          message: "User profile not found",
        );
      }
    } catch (error) {
      throw FirebaseException(
        plugin: 'FirebaseFirestore',
        message: 'Error fetching user profile: ${error.toString()}',
      );
    }
  }

  // Changes the user's password using the provided use case
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await changePasswordUseCase(currentPassword, newPassword);
  }
}


import 'package:meal_recommendation_ai/features/profile/data/remote/profile_data_source_impl.dart';

import '../domain/profile_repository.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getUserProfile(String uid) {
    return dataSource.getUserProfile(uid);
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) {
    return dataSource.changePassword(currentPassword, newPassword);
  }
}

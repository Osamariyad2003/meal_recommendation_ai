

import '../../helpers/cache_keys.dart';
import '../../helpers/secure_storage_helper.dart';

bool isUserLoggedIn = false;

Future<void> checkIfUserIsLoggedIn() async {
  final cachedUserId = await SecureStorageHelper.getSecuredString(
    CacheKeys.cachedUserId,
  );

  if (cachedUserId == null || cachedUserId.isEmpty) {
    isUserLoggedIn = false;
  } else {
    isUserLoggedIn = true;
  }
}

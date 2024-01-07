import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/services/secure_storage_service.dart';
import 'package:workdaez/shared/utils/constants.dart';

final FutureProvider<WorkProfileData?> activeProfileProvider =
    FutureProvider<WorkProfileData?>((ref) async {
  final storage = sl.get<SecureStorageService>();

  final activeProfileId = await storage.read(kActiveProfileKey);

  final dao = sl.get<ProfileDao>();

  final defaultProfile = await dao.getDefaultProfile();

  if (activeProfileId != null) {
    final profile = await dao.getProfile(int.parse(activeProfileId));

    if (profile == null) {
      await storage.write(kActiveProfileKey, defaultProfile.id.toString());
      return defaultProfile;
    }

    return profile;
  }

  await storage.write(kActiveProfileKey, defaultProfile.id.toString());

  return defaultProfile;
});

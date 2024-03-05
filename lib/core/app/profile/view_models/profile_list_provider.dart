import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';

final profileListProvider = FutureProvider<List<WorkProfileData>>((ref) async {
  final dao = sl.get<ProfileDao>();

  return await dao.getProfiles();
});
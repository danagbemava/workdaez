import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/db/daos/tracker_dao.dart';

import 'active_profile_provider.dart';

final dayMarkedProvider = FutureProviderFamily<bool, DateTime>((ref, date) async {
  final activeProfile = ref.watch(activeProfileProvider).value;

  print('activeProfile: $activeProfile');

  if (activeProfile == null) {
    return false;
  }

  final trackerDao = sl.get<WorkTrackerDao>();

  final dayMarked = await trackerDao.isDayMarked(date, activeProfile.id);

  print('dayMarked: $dayMarked');

  return dayMarked;
});
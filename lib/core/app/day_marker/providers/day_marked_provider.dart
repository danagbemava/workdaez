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

final daysWorkedForMonthProvider = FutureProviderFamily<int, int?>((ref, profileId) async {
  final date = DateTime.now();

  return await sl.get<WorkTrackerDao>().getDaysWorkedForMonth(date, profileId ?? 0);
});

final daysWorkedForMonthWithMonthOptionProvider = FutureProviderFamily<int, ({int month, int? profile})>((ref, arg) async {
  return await sl.get<WorkTrackerDao>().getDaysWorkedForMonthWithMonthId(arg.month, arg.profile ?? 0);
});

final offDaysByTypeProvider = FutureProviderFamily<int, String>((ref, arg) async {
  final date = DateTime.now();
  final activeProfile = ref.watch(activeProfileProvider).value;

  return await sl.get<WorkTrackerDao>().getOffDaysForMonthByType(date, arg, activeProfile?.id ?? 0);
});

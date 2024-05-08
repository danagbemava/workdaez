import 'package:flutter_test/flutter_test.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/daos/tracker_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';

void main() {
  late AppDatabase database;
  late WorkTrackerDao trackerDao;
  late ProfileDao profileDao;

  setUp(() {
    database = AppDatabase.testing();
    trackerDao = WorkTrackerDao(database);
    profileDao = ProfileDao(database);

    final profile =
        const WorkProfileData(id: 1, name: 'main', trackTime: false, trackWeekends: false).toCompanion(true);

    profileDao.insertProfile(profile);
  });

  test('adds one item on success', () async {
    final date = DateTime.now();

    var data = WorkTrackerData(id: 1, day: date, didWork: true, profileId: 1, dateGenerated: date);

    var daysWorked = await trackerDao.getAllDaysWorked();

    expect(0, daysWorked.length);

    await trackerDao.insertDayWorked(data.toCompanion(true));
    daysWorked = await trackerDao.getAllDaysWorked();

    expect(1, daysWorked.length);
  });

  test('get days worked for month only returns total count for current month', () async {
    var date = DateTime.now();
    final profileId = 1;

    var data = [
      WorkTrackerData(id: 1, day: date, didWork: true, profileId: profileId, dateGenerated: date),
      WorkTrackerData(
          id: 2,
          day: DateTime(date.year, date.month, date.day + 1),
          didWork: true,
          profileId: profileId,
          dateGenerated: DateTime(date.year, date.month, date.day + 1)),
      WorkTrackerData(
          id: 3,
          day: DateTime(date.year, date.month + 1, date.day),
          didWork: true,
          profileId: profileId,
          dateGenerated: DateTime(date.year, date.month + 1, date.day)),
    ];

    var daysWorked = await trackerDao.getAllDaysWorked();

    expect(0, daysWorked.length);

    for (var day in data) {
      await trackerDao.insertDayWorked(day.toCompanion(true));
    }

    daysWorked = await trackerDao.getAllDaysWorked();

    expect(3, daysWorked.length);

    final totalDaysWorked = await trackerDao.getDaysWorkedForMonth(date, profileId);

    expect(2, totalDaysWorked);
  });

  test('resetData properly resets a day worked', () async {
    var date = DateTime.now();
    const profileId = 1;

    var data = [
      WorkTrackerData(id: 1, day: date, didWork: true, profileId: profileId, dateGenerated: date),
      WorkTrackerData(
          id: 2,
          day: DateTime(date.year, date.month, date.day + 1),
          didWork: true,
          profileId: profileId,
          dateGenerated: DateTime(date.year, date.month, date.day + 1)),
      WorkTrackerData(
          id: 3,
          day: DateTime(date.year, date.month, date.day + 2),
          didWork: true,
          profileId: profileId,
          dateGenerated: DateTime(date.year, date.month, date.day + 2)),
    ];

    var daysWorked = await trackerDao.getAllDaysWorked();

    expect(0, daysWorked.length);

    for (var day in data) {
      await trackerDao.insertDayWorked(day.toCompanion(true));
    }

    daysWorked = await trackerDao.getAllDaysWorked();

    expect(3, daysWorked.length);

    await trackerDao.resetDay(DateTime(date.year, date.month, date.day + 2));

    var newDaysWorked = await trackerDao.getAllDaysWorked();

    for (var day in newDaysWorked) {
      print("$day");
    }

    expect(2, newDaysWorked.length);
  });

  tearDown(() {
    database.close();
  });
}

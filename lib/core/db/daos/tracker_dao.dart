import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/db/models/profile.dart';
import 'package:workdaez/core/db/models/tracker.dart';
import 'package:workdaez/shared/utils/logging_util.dart';

part 'tracker_dao.g.dart';

@DriftAccessor(tables: [WorkTracker, WorkProfile])
class WorkTrackerDao extends DatabaseAccessor<AppDatabase> with _$WorkTrackerDaoMixin {
  WorkTrackerDao(super.attachedDatabase);

  final _logger = LoggerMixin<WorkTrackerDao>();

  Future<void> insertDayWorked(WorkTrackerCompanion data) async {
    try {
      _logger.logInfo("insertDayWorked", "$data");
      await into(workTracker).insert(data);
    } catch (e) {
      _logger.logError('insertDayWorked', 'an unexpected error occurred. $e');
    }
  }

  Future<bool> isDayMarked(DateTime date, int profileId) async {
    _logger.logInfo("isDayMarked", 'profile & day: $profileId, $date');
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    try {
      final query = (select(workTracker)..where((tbl) => tbl.day.date.equals(formattedDate)));

      final result = await query.get();

      _logger.logInfo("isDayMarked", "day marked: $result");

      if (result.isNotEmpty) {
        final matchingDayAndProfile = result.any((e) => e.profileId == profileId);

        _logger.logInfo("isDayMarked", "matching day & profile: $matchingDayAndProfile");

        return matchingDayAndProfile;
      }

      return false;
    } catch (e) {
      _logger.logError('isDayMarked', 'an unexpected error occurred. $e');
      return false;
    }
  }

  Future<List<WorkTrackerData>> getAllDaysWorked() async {
    return (select(workTracker)..where((tbl) => tbl.didWork.equals(true))).get();
  }

  Future<int> getDaysWorkedForMonth(DateTime date, int profileId) async {
    final month = date.month;

    try {
      final daysWorkedForMonth =
          await (select(workTracker)..where((tbl) => tbl.dateGenerated.month.equals(month))).get();

      return daysWorkedForMonth.where((e) => e.profileId == profileId && e.didWork!).length;
    } catch (e) {
      _logger.logError('getDaysWorkedForMonth', 'an unexpected error occurred. $e');
      return 0;
    }
  }

  Future<int> getDaysWorkedForMonthWithMonthId(int month, int profileId) async {
    try {
      final daysWorkedForMonth =
          await (select(workTracker)..where((tbl) => tbl.dateGenerated.month.equals(month))).get();

      return daysWorkedForMonth.where((e) => e.profileId == profileId && e.didWork!).length;
    } catch (e) {
      _logger.logError('getDaysWorkedForMonth', 'an unexpected error occurred. $e');
      return 0;
    }
  }

  Future<int> getOffDaysForMonthByType(DateTime date, String type, int profileId) async {
    final month = date.month;

    try {
      final offDaysForMonth = await (select(workTracker)..where((tbl) => tbl.dateGenerated.month.equals(month))).get();

      return offDaysForMonth
          .where((e) => e.profileId == profileId && !e.didWork! && e.absentReason?.toLowerCase() == type.toLowerCase())
          .length;
    } catch (e) {
      _logger.logError('getDaysWorkedForMonth', 'an unexpected error occurred. $e');
      return 0;
    }
  }

  Future<void> resetDay(DateTime day) async {
    try {
      _logger.logInfo('resetDay', '${day.toIso8601String()}, ${day.toString()}');
      var days = await (select(workTracker)..where((tbl) => tbl.day.month.equals(day.month))).get();

      _logger.logInfo('resetDay', 'days found: ${days.length}');

      final foundDay = days.singleWhere((e) => e.day.day == day.day && e.day.year == day.year);

      await delete(workTracker).delete(foundDay);

      return;
    } catch (e) {
      _logger.logError('resetDay', 'an exception occured: $e');
      return;
    }
  }
}

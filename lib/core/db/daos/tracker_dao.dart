import 'package:drift/drift.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/db/models/tracker.dart';
import 'package:workdaez/shared/utils/logging_util.dart';

part 'tracker_dao.g.dart';

@DriftAccessor(tables: [WorkTracker])
class WorkTrackerDao extends DatabaseAccessor<AppDatabase> with _$WorkTrackerDaoMixin {
  WorkTrackerDao(super.attachedDatabase);

  final _logger = LoggerMixin<WorkTrackerDao>();

  Future<void> insertDayWorked(WorkTrackerCompanion data) async {
    try {
      await into(workTracker).insert(data);
    } catch (e) {
      _logger.logError('insertDayWorked', 'an unexpected error occurred. $e');
    }
  }

  Future<bool> isDayMarked(DateTime date, int profileId) async {

    try {
      final dayMarked = await (select(workTracker)..where((tbl) => tbl.day.date.equals(date.toString()))).getSingleOrNull();

      return dayMarked != null;
    } catch (e) {
      _logger.logError('isDayMarked', 'an unexpected error occurred. $e');
      return false;
    }
  }

  Future<List<WorkTrackerData>> getAllDaysWorked() async {
    return select(workTracker).get();
  }

  Future<int> getDaysWorkedForMonth(DateTime date) async {
    final month = date.month;

    try {
      final daysWorkedForMonth =  await (select(workTracker)..where((tbl) => tbl.dateGenerated.month.equals(month))).get();

      return daysWorkedForMonth.length;
    } catch (e) {
      _logger.logError('getDaysWorkedForMonth', 'an unexpected error occurred. $e');
      return 0;      
    }
  }
}

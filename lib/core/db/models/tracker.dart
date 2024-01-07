import 'package:drift/drift.dart';
import 'package:workdaez/core/db/models/profile.dart';

class WorkTracker extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get day => text().unique()();
  BoolColumn get didWork => boolean()();
  IntColumn get profileId => integer().references(WorkProfile, #id)();
  TextColumn get absentReason => text().nullable()();
  DateTimeColumn get dateGenerated => dateTime()();
  TextColumn get notes => text().nullable()();
}

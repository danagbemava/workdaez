import 'package:drift/drift.dart';

class WorkProfile extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(min: 4, max: 32)();
  BoolColumn get trackTime => boolean().withDefault(const Constant(false))();
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/models/profile.dart';
import 'package:workdaez/core/db/models/tracker.dart';
import 'package:sqlite3/sqlite3.dart';

part 'db_setup.g.dart';


@DriftDatabase(tables: [WorkProfile, WorkTracker])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.testing() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (to == 2) {
        migrator.addColumn(workTracker, workTracker.notes);
      }
      if(to == 3) {
        migrator.addColumn(workProfile, workProfile.trackWeekends);
      }
    }
  );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

Future<void> insertDefaultProfile() async {
  final data = const WorkProfileData(
    id: 1,
    name: 'Default',
    trackTime: false,
    trackWeekends: false,
  ).toCompanion(true);

  final dao = sl.get<ProfileDao>();

  if (await dao.profileExists(data.id.value)) {
    return;
  }

  await sl.get<ProfileDao>().insertProfile(data);
}
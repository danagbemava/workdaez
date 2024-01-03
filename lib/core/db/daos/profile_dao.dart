import 'package:drift/drift.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/db/models/profile.dart';
import 'package:workdaez/shared/utils/logging_util.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [WorkProfile])
class ProfileDao extends DatabaseAccessor<AppDatabase> with _$ProfileDaoMixin {
  ProfileDao(super.attachedDatabase);

  final _logger = LoggerMixin<ProfileDao>();

  Future<void> insertProfile(WorkProfileData profile) async {
    try {
      await into(workProfile).insert(profile, mode: InsertMode.insertOrReplace);
    } catch (e) {
      _logger.logInfo('insertProfile', 'an unexpected error occurred. $_logger');
    }
  }

  Stream<List<WorkProfileData>> watchProfiles() {
    return select(workProfile).watch();
  }

  Future<List<WorkProfileData>> getProfiles() {
    return select(workProfile).get();
  }

  Future<void> deleteProfile(int id) async {
    try {
      (delete(workProfile)..where((tbl) => tbl.id.equals(id))).go();
    } catch (e) {
      _logger.logInfo('insertProfile', 'an unexpected error occurred. $_logger');
    }
  }
}

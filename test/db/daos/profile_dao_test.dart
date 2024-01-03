import 'package:flutter_test/flutter_test.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';

void main() {
  late AppDatabase database;
  late ProfileDao profileDao;

  setUp(() {
    database = AppDatabase.testing();
    profileDao = ProfileDao(database);
  });

  test('adds one item on success', () async {

    const data = WorkProfileData(id: 1, name: 'main', trackTime: false);

    var profiles = await profileDao.getProfiles();

    expect(0, profiles.length);

    await profileDao.insertProfile(data);
    profiles = await profileDao.getProfiles();

    expect(1, profiles.length);
  });

  test('updates item if it exists, otherwise creates it', () async {
    var data = const WorkProfileData(id: 1, name: 'testing', trackTime: true);

    var profiles = await profileDao.getProfiles();

    expect(0, profiles.length);

    await profileDao.insertProfile(data);

    profiles = await profileDao.getProfiles();

    expect(1, profiles.length);

    final createdData = profiles.first;

    expect(data.id, createdData.id);

    data = const WorkProfileData(id: 1, name: 'updating name', trackTime: false);

    await profileDao.insertProfile(data);

    profiles = await profileDao.getProfiles();

    expect(1, profiles.length);

    final updatedData = profiles.first;

    expect(createdData.id, updatedData.id);
    expect('updating name', updatedData.name);
    expect(false, updatedData.trackTime);
  });

  test('delete removes only created profile', () async {
      const data = WorkProfileData(id: 1, name: 'main', trackTime: false);

      var profiles = await profileDao.getProfiles();

      // testing that we start with empty list
      expect(0, profiles.length);

      // creating a profile
      await profileDao.insertProfile(data);

      profiles = await profileDao.getProfiles();

      // checking that profile was actually created
      expect(1, profiles.length);

      await profileDao.deleteProfile(1);

      // checking that profile was deleted
      profiles = await profileDao.getProfiles();

      expect(0, profiles.length);
  });

  tearDown(() {
    database.close();
  });
}

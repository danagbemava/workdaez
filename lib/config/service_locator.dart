import 'package:get_it/get_it.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/daos/tracker_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/services/secure_storage_service.dart';

GetIt sl = GetIt.instance;

void setupLocators() {

  sl.registerSingleton<SecureStorageService>(SecureStorageService());

  sl.registerSingleton<AppDatabase>(AppDatabase());

  sl.registerSingleton<ProfileDao>(ProfileDao(sl.get()));
  sl.registerSingleton<WorkTrackerDao>(WorkTrackerDao(sl.get()));
}
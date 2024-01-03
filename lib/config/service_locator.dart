import 'package:get_it/get_it.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/daos/tracker_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';

GetIt sl = GetIt.instance;

void setupLocators() {

  sl.registerSingleton(() => AppDatabase());

  sl.registerLazySingleton(() => ProfileDao(sl.get()));
  sl.registerLazySingleton(() => WorkTrackerDao(sl.get()));
  
}
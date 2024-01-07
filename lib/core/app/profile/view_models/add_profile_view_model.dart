import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/db/daos/profile_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/shared/utils/base_change_notifier.dart';
import 'package:workdaez/shared/utils/logging_util.dart';
import 'package:workdaez/shared/utils/notification_utils.dart';

final addProfileViewModel = ChangeNotifierProvider((ref) => AddProfileViewModel(sl.get()));

class AddProfileViewModel extends BaseChangeNotifier {
  final ProfileDao _profileDao;
  final LoggerMixin _logger = LoggerMixin<AddProfileViewModel>();


  AddProfileViewModel(this._profileDao);

  Future<void> save(WorkProfileCompanion data, {required VoidCallback onSuccess}) async {
    NotificationUtils.showLoading();
    try {
      await _profileDao.insertProfile(data); 
      onSuccess.call();
    } catch (e) {
      _logger.logInfo('save', 'an unexpected error occurred. $e');
      NotificationUtils.showErrorNotification('An unexpected error occurred. Please try again.');
    } finally {
      NotificationUtils.closeLoading();
    }
  }  
}
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  static void showLoading() {
    closeLoading();
    BotToast.showLoading();
  }

  static void closeLoading() {
    BotToast.closeAllLoading();
  }

  static void showErrorNotification(String message) {
    BotToast.closeAllLoading();
    BotToast.showSimpleNotification(
      title: 'Error',
      subTitle: message,
      backgroundColor: Colors.red,
      titleStyle: const TextStyle(color: Colors.white),
      subTitleStyle: const TextStyle(color: Colors.white),
    );
  }

  static void showInfoNotification(String message) {
    BotToast.closeAllLoading();
    BotToast.showSimpleNotification(
      title: 'Info',
      subTitle: message,
      backgroundColor: Colors.blue,
      titleStyle: const TextStyle(color: Colors.white),
      subTitleStyle: const TextStyle(color: Colors.white),
    );
  }

  static void showWarningNotification(String message) {
    BotToast.closeAllLoading();
    BotToast.showSimpleNotification(
      title: 'Warning',
      subTitle: message,
      backgroundColor: Colors.amber,
      titleStyle: const TextStyle(color: Colors.white),
      subTitleStyle: const TextStyle(color: Colors.white),
    );
  }

  static void showSuccessNotification(String message) {
    BotToast.closeAllLoading();
    BotToast.showSimpleNotification(
      title: 'Success',
      subTitle: message,
      backgroundColor: Colors.green,
      titleStyle: const TextStyle(color: Colors.white),
      subTitleStyle: const TextStyle(color: Colors.white),
    );
  }
}

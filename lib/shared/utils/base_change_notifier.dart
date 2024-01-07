import 'package:flutter/material.dart';

abstract class BaseChangeNotifier extends ChangeNotifier {
 
  void setState({VoidCallback? fn}) {
    fn?.call();
    notifyListeners();
  }
}
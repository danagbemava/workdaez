import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

// const kAbsentValues = ['PTO', 'SICK_DAY', 'HOLIDAY', 'CUSTOM'];

enum AbsentValues {
  pto('PTO', Symbols.villa),
  sickDay('SICK_DAY', Symbols.sick),
  holiday('HOLIDAY', Symbols.holiday_village),
  custom('CUSTOM', Symbols.dashboard_customize);

  final String name;
  final IconData icon;

  const AbsentValues(this.name, this.icon);

  factory AbsentValues.fromName(String name) {
    return AbsentValues.values.firstWhere((e) => e.name == name);
  }
}

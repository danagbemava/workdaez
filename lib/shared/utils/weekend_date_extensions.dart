extension WeekDayExtension on DateTime {

  bool get isWeekend => day >= 6;
  

  bool get isWeekDay => !isWeekend;
}
extension WeekDayExtension on DateTime {

  bool get isWeekend => weekday >= 6;
  

  bool get isWeekDay => !isWeekend;
}
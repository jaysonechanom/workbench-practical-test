import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin TimesheetMixin {
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  DateTime toDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String? parseTimeToAmOrPm(String timeString) {
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(timeString));
  }

  TimeOfDay? parseTimeStringToTimeOfDay(String timeString) {
    final dateTime = DateFormat("H:mm:ss").parse(timeString);
    return TimeOfDay.fromDateTime(dateTime);
  }

  String formatTimeOfDayToAmPm(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime);
  }
}
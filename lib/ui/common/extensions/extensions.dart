import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Extensions {
  static TimeOfDay timeOfDayFromString(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}

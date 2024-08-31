import 'dart:async';

import 'package:myapp/ui/common/models/reminder.dart';
import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:rxdart/rxdart.dart';

class RemindersOfDayRepository {
  static final RemindersOfDayRepository instance = RemindersOfDayRepository._internal();
  RemindersOfDayRepository._internal();

  final RemindersRepository remindersRepository = RemindersRepository.instance;

  List<Reminder> remindersOfDay = [];
  final StreamController<List<Reminder>> _remindersOfDayStream = BehaviorSubject();
  Stream<List<Reminder>> get remindersOfDayStream => _remindersOfDayStream.stream;

  Future<void> init() async {
    await getRemindersOfDay(DateTime.now());
  }

  Future<void> getRemindersOfDay(DateTime dateTime) async {
    final allReminders = await remindersRepository.readReminders();
    remindersOfDay = allReminders.where((reminder) {
      return reminder.date.year == dateTime.year &&
          reminder.date.month == dateTime.month &&
          reminder.date.day == dateTime.day;
    }).toList();

    remindersOfDay.sort((a, b) => a.date.compareTo(b.date));
    _remindersOfDayStream.add(remindersOfDay);
  }
}

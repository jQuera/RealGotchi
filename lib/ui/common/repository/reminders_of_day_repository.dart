import 'dart:async';

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
    remindersOfDay = await remindersRepository.getRemindersOfDay(DateTime.now());
    _remindersOfDayStream.add(remindersOfDay);
  }
}

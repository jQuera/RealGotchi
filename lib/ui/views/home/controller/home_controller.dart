import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/common/models/reminder_model.dart';
import 'package:myapp/ui/common/models/task_model.dart';
import 'package:myapp/ui/common/repository/reminders_of_day_repository.dart';
import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:myapp/ui/views/home/home_page.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

class HomeController {
  static final HomeController instance = HomeController();
  final TasksRepository tasksRepository = TasksRepository.instance;
  final RemindersRepository remindersRepository = RemindersRepository.instance;
  final RemindersOfDayRepository remindersOfDayRepository = RemindersOfDayRepository.instance;

  O3DController modelController = O3DController();

  int currentPage = 1;
  final StreamController<int> _currentPageStream = BehaviorSubject.seeded(1);
  Stream<int> get currentPageStream => _currentPageStream.stream;

  DateTime selectedDay = DateTime.now();
  final StreamController<DateTime> _currentDayStream = BehaviorSubject.seeded(DateTime.now());
  Stream<DateTime> get currentDayStream => _currentDayStream.stream;

  void init() async {
    await Future.delayed(Durations.extralong4);
    tasksRepository.init();
    MainController.instance.getCurrentState()?.push(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  void changeCurrentPage(int value) {
    currentPage = value;
    _currentPageStream.add(currentPage);
  }

  void nextDay() {
    selectedDay = selectedDay.add(const Duration(days: 1));
    _currentDayStream.add(selectedDay);
    remindersOfDayRepository.getRemindersOfDay(selectedDay);
  }

  void previousDay() {
    selectedDay = selectedDay.subtract(const Duration(days: 1));
    _currentDayStream.add(selectedDay);
    remindersOfDayRepository.getRemindersOfDay(selectedDay);
  }

  void getRemindersOfDay() {
    remindersOfDayRepository.getRemindersOfDay(selectedDay);
  }

  void updateReminder(ReminderModel reminder) {
    remindersOfDayRepository.updateReminder(reminder);
  }

  void updateTask(TaskModel updatedTask) {
    tasksRepository.updateTask(updatedTask);
    
  }

  bool remindersOverextended() {
    return remindersOfDayRepository.remindersOfDay
        .any((reminder) => reminder.date.isBefore(DateTime.now()) && !reminder.isCompleted && reminder.isActive);
  }
}

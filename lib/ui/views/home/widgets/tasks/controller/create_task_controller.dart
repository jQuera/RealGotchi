import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/repository/task.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class CreateTaskController {
  static final CreateTaskController instance = CreateTaskController();

  TextEditingController descriptionController = TextEditingController();

  TaskType taskTypeSelected = TaskType.salud;
  final StreamController<TaskType> _taskTypeSelectedStream = BehaviorSubject.seeded(TaskType.salud);
  Stream<TaskType> get taskTypeSelectedStream => _taskTypeSelectedStream.stream;

  TimeOfDay executionTime = TimeOfDay.now();
  final StreamController<TimeOfDay> _executionTimeStream = BehaviorSubject.seeded(TimeOfDay.now());
  Stream<TimeOfDay> get executionTimeStream => _executionTimeStream.stream;

  List<DayOfWeek> daysOfExecution = [];
  final StreamController<List<DayOfWeek>> _daysOfExecutionStream = BehaviorSubject.seeded([]);
  Stream<List<DayOfWeek>> get daysOfExecutionStream => _daysOfExecutionStream.stream;

  void init() {
    clear();
  }

  void clear() {
    descriptionController.clear();
    taskTypeSelected = TaskType.salud;
    executionTime = TimeOfDay.now();
  }

  void changeTaskType(TaskType type) {
    taskTypeSelected = type;
    _taskTypeSelectedStream.add(taskTypeSelected);
  }

  void changeExecutionTime(TimeOfDay selectedTime) {
    executionTime = selectedTime;
    _executionTimeStream.add(executionTime);
  }

  void changeDaysOfExecution(List<DayOfWeek> days) {
    daysOfExecution = days;
    _daysOfExecutionStream.add(daysOfExecution);
  }

  Task getTask() {
    return Task(
      id: const Uuid().v4(),
      title: descriptionController.text,
      description: descriptionController.text,
      executionTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        executionTime.hour,
        executionTime.minute,
      ),
      type: taskTypeSelected,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      daysOfWeek: daysOfExecution,
    );
  }

  void createTask() {
    MainController.instance.getCurrentState()!.pop(getTask());
  }
}

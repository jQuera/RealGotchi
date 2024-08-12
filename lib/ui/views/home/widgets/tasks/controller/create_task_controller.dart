import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:rxdart/rxdart.dart';

class CreateTaskController {
  static final CreateTaskController instance = CreateTaskController();

  TextEditingController descriptionController = TextEditingController();

  TaskType taskTypeSelected = TaskType.salud;
  final StreamController<TaskType> _taskTypeSelectedStream =
      BehaviorSubject.seeded(TaskType.salud);
  Stream<TaskType> get taskTypeSelectedStream => _taskTypeSelectedStream.stream;

  TaskFrequency taskFrequencySelected = TaskFrequency.unica;
  final StreamController<TaskFrequency> _taskFrequencySelectedStream =
      BehaviorSubject.seeded(TaskFrequency.unica);
  Stream<TaskFrequency> get taskFrequencySelectedStream =>
      _taskFrequencySelectedStream.stream;

  TimeOfDay executionTime = TimeOfDay.now();
  final StreamController<TimeOfDay> _executionTimeStream =
      BehaviorSubject.seeded(TimeOfDay.now());
  Stream<TimeOfDay> get executionTimeStream => _executionTimeStream.stream;

  void init() {
    clear();
  }

  void clear() {
    descriptionController.clear();
    taskTypeSelected = TaskType.salud;
    taskFrequencySelected = TaskFrequency.unica;
    executionTime = TimeOfDay.now();
  }

  void changeTaskType(TaskType type) {
    taskTypeSelected = type;
    _taskTypeSelectedStream.add(taskTypeSelected);
  }

  void changeTaskFrequency(TaskFrequency frequency) {
    taskFrequencySelected = frequency;
    _taskFrequencySelectedStream.add(taskFrequencySelected);
  }

  void changeExecutionTime(TimeOfDay selectedTime) {
    executionTime = selectedTime;
    _executionTimeStream.add(executionTime);
  }

  Task getTask() {
    return Task(
      description: descriptionController.text,
      type: taskTypeSelected,
      frequency: taskFrequencySelected,
      hour: executionTime
          .format(MainController.instance.getCurrentState()!.context),
      isCompleted: false,
      uuid: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  void createTask() {
    MainController.instance.getCurrentState()!.pop(getTask());
  }
}

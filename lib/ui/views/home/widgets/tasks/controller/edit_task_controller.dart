import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/models/task_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class EditTaskController {
  static final EditTaskController instance = EditTaskController();

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

  TaskModel? _currentTask;
  bool isNewTask = true;

  void init({TaskModel? task}) {
    if (task == null) {
      clear();
      return;
    }
    _currentTask = task;
    isNewTask = false;
    descriptionController.text = task.description;
    taskTypeSelected = task.type;
    executionTime = TimeOfDay(hour: task.executionTime.hour, minute: task.executionTime.minute);
    daysOfExecution = task.daysOfWeek;
    _taskTypeSelectedStream.add(taskTypeSelected);
    _executionTimeStream.add(executionTime);
    _daysOfExecutionStream.add(daysOfExecution);
  }

  void clear() {
    descriptionController.clear();
    taskTypeSelected = TaskType.salud;
    executionTime = TimeOfDay.now();
    daysOfExecution = [];
    _currentTask = null;
    isNewTask = true;
    _taskTypeSelectedStream.add(taskTypeSelected);
    _executionTimeStream.add(executionTime);
    _daysOfExecutionStream.add(daysOfExecution);
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

  TaskModel getTask() {
    return TaskModel(
      id: _currentTask?.id ?? const Uuid().v4(),
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
      createdAt: _currentTask?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      daysOfWeek: daysOfExecution,
    );
  }

  void saveTask() {
    MainController.instance.getCurrentState()!.pop(getTask());
  }
}

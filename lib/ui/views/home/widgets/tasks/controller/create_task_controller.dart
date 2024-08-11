import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:rxdart/rxdart.dart';

class CreateTaskController {
  static final CreateTaskController instance = CreateTaskController();

  TextEditingController descriptionController = TextEditingController();

  TaskType taskTypeSelected = TaskType.salud;
  final StreamController<TaskType> _taskTypeSelectedStream = BehaviorSubject.seeded(TaskType.salud);
  Stream<TaskType> get taskTypeSelectedStream => _taskTypeSelectedStream.stream;

  void init() {
    clear();
  }

  void clear() {
    descriptionController.clear();
  }

  void changeTaskType(TaskType type) {
    taskTypeSelected = type;
    _taskTypeSelectedStream.add(taskTypeSelected);
  }
}

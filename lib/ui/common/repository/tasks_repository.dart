import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:myapp/ui/common/models/task_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:myapp/data/datasources/gotchi_local_datasource.dart';

class TasksRepository {
  static final TasksRepository instance = TasksRepository._internal();
  final RealGotchiLocalDatasource _localDatasource = RealGotchiLocalDatasource();

  TasksRepository._internal();

  List<TaskModel> _tasks = [];
  final StreamController<List<TaskModel>> _tasksStream = BehaviorSubject();
  Stream<List<TaskModel>> get tasksStream => _tasksStream.stream;

  Future<void> init() async {
    await _localDatasource.initializeDB();
    await _loadTasksFromLocalStorage();
    updateTaskStream();
  }

  Future<void> _loadTasksFromLocalStorage() async {
    final taskMaps = await _localDatasource.getTasks();
    _tasks = taskMaps.map((map) => TaskModel.fromMap(map)).toList();
  }

  //crear un CRUD de tasks

  Future<bool> createTask(TaskModel task) async {
    try {
      final id = await _localDatasource.insertTask(task.toMap());
      task = task.copyWith(id: id);
      _tasks.add(task);
      updateTaskStream();
      await RemindersRepository.instance.createRemindersFromTask(task);
      return true;
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: e.toString());
      return false;
    }
  }

  Future<List<TaskModel>> getTasksByType(TaskType type) {
    try {
      //TODO: agregar conexion con service que obtiene las tareas de la base de datos o de una api externa
      _tasks = _tasks.where((element) => element.type == type).toList();
      return Future.value(_tasks);
    } catch (e) {
      return Future.value([]);
    }
  }

  Future<bool> updateTask(TaskModel task) {
    try {
      _tasks.where((element) => element.description == task.description);
      _tasks.add(task);
      updateTaskStream();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteTask(TaskModel task) {
    try {
      _tasks.removeWhere((element) => element.description == task.description);
      updateTaskStream();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  void updateTaskStream() {
    _tasksStream.add(_tasks);
  }
}

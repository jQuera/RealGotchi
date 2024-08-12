import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TasksRepository {
  static final TasksRepository instance = TasksRepository._internal();

  TasksRepository._internal();

  List<Task> _tasks = [];
  final StreamController<List<Task>> _tasksStream = BehaviorSubject();
  Stream<List<Task>> get tasksStream => _tasksStream.stream;

  final StreamController<List<Task>> _tasksAlimentacionStream = BehaviorSubject();
  Stream<List<Task>> get tasksAlimentacionStream => _tasksAlimentacionStream.stream;
  final StreamController<List<Task>> _tasksHigieneStream = BehaviorSubject();
  Stream<List<Task>> get tasksHigieneStream => _tasksHigieneStream.stream;
  final StreamController<List<Task>> _tasksSaludStream = BehaviorSubject();
  Stream<List<Task>> get tasksSaludStream => _tasksSaludStream.stream;
  final StreamController<List<Task>> _tasksEntrenenimientoStream = BehaviorSubject();
  Stream<List<Task>> get tasksEntrenenimientoStream => _tasksEntrenenimientoStream.stream;

  Future<void> init() async {
    updateTaskStreams(TaskType.alimentacion);
    updateTaskStreams(TaskType.entrenenimiento);
    updateTaskStreams(TaskType.salud);
    updateTaskStreams(TaskType.higiene);
  }

  //crear un CRUD de tasks

  Future<bool> createTask(Task task) {
    try {
      _tasks.add(task);
      updateTaskStreams(task.type);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<List<Task>> getTasks(TaskType type) {
    try {
      //TODO: agregar conexion con service que obtiene las tareas de la base de datos o de una api externa
      _tasks = _tasks.where((element) => element.type == type).toList();
      return Future.value(_tasks);
    } catch (e) {
      return Future.value([]);
    }
  }

  Future<bool> updateTask(Task task) {
    try {
      _tasks.where((element) => element.title == task.title);
      _tasks.add(task);
      updateTaskStreams(task.type);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteTask(Task task) {
    try {
      _tasks.removeWhere((element) => element.title == task.title);
      updateTaskStreams(task.type);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  void updateTaskStreams(TaskType type) {
    _tasksStream.add(_tasks);
    switch (type) {
      case TaskType.alimentacion:
        _tasksAlimentacionStream.add(_tasks.where((element) => element.type == TaskType.alimentacion).toList());
        break;
      case TaskType.higiene:
        _tasksHigieneStream.add(_tasks.where((element) => element.type == TaskType.higiene).toList());
        break;
      case TaskType.salud:
        _tasksSaludStream.add(_tasks.where((element) => element.type == TaskType.salud).toList());
        break;
      case TaskType.entrenenimiento:
        _tasksEntrenenimientoStream.add(_tasks.where((element) => element.type == TaskType.entrenenimiento).toList());
        break;
    }
  }
}

class Task {
  String title;
  String description;
  String hour;
  TaskFrequency frequency;
  bool isCompleted;
  TaskType type;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.hour,
    required this.frequency,
    required this.type,
  });
}

enum TaskType {
  alimentacion,
  higiene,
  salud,
  entrenenimiento,
}

enum TaskFrequency {
  unica(descripcion: "Solo por hoy"),
  diaria(descripcion: "Diaria"),
  diaPorMedio(descripcion: "Día por medio"),
  semanal(descripcion: "Una vez a la semana"),
  mensual(descripcion: "Una vez al mes");

  final String descripcion;
  const TaskFrequency({required this.descripcion});
}

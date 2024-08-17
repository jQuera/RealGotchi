import 'dart:async';
import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:myapp/ui/common/repository/task.dart';
import 'package:rxdart/rxdart.dart';

class TasksRepository {
  static final TasksRepository instance = TasksRepository._internal();

  TasksRepository._internal();

  List<Task> _tasks = [];
  final StreamController<List<Task>> _tasksStream = BehaviorSubject();
  Stream<List<Task>> get tasksStream => _tasksStream.stream;

  Future<void> init() async {
    updateTaskStream();
  }

  //crear un CRUD de tasks

  Future<bool> createTask(Task task) async {
    try {
      _tasks.add(task);
      updateTaskStream();
      await RemindersRepository.instance.createRemindersFromTask(task);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<List<Task>> getTasksByType(TaskType type) {
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
      _tasks.where((element) => element.description == task.description);
      _tasks.add(task);
      updateTaskStream();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteTask(Task task) {
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

enum TaskType {
  alimentacion(name: "Alimentación"),
  higiene(name: "Higiene"),
  salud(name: "Salud"),
  entrenenimiento(name: "Entrenenimiento");

  final String name;
  const TaskType({required this.name});
}

import 'dart:async';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:myapp/ui/common/repository/task.dart';
import 'package:rxdart/rxdart.dart';
import 'package:myapp/data/datasources/gotchi_local_datasource.dart';

class TasksRepository {
  static final TasksRepository instance = TasksRepository._internal();
  final RealGotchiLocalDatasource _localDatasource = RealGotchiLocalDatasource();

  TasksRepository._internal();

  List<Task> _tasks = [];
  final StreamController<List<Task>> _tasksStream = BehaviorSubject();
  Stream<List<Task>> get tasksStream => _tasksStream.stream;

  Future<void> init() async {
    await _localDatasource.initializeDB();
    await _loadTasksFromLocalStorage();
    updateTaskStream();
  }

  Future<void> _loadTasksFromLocalStorage() async {
    final taskMaps = await _localDatasource.getTasks();
    _tasks = taskMaps.map((map) => Task.fromMap(map)).toList();
  }

  //crear un CRUD de tasks

  Future<bool> createTask(Task task) async {
    try {
      final id = await _localDatasource.insertTask(task.toMap());
      task = task.copyWith(id: id);
      _tasks.add(task);
      updateTaskStream();
      await RemindersRepository.instance.createRemindersFromTask(task);
      return true;
    } catch (e) {
      return false;
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

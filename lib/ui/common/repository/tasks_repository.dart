class TasksRepository {
  static final TasksRepository instance = TasksRepository._internal();

  TasksRepository._internal();

  List<Task> _tasks = [];

  //crear un CRUD de tasks


  Future<bool> createTask(Task task) {
    try {
      _tasks.add(task);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<List<Task>> getTasks() {
    try {
      return Future.value(_tasks);
    } catch (e) {
      return Future.value([]);
    }
  }

  Future<List<Task>> getTasksByPeriodicity(String periodicity) {
    return Future.value(_tasks);
  }

  Future<bool> updateTask(Task task) {
    try {
      _tasks.removeWhere((element) => element.title == task.title);
      _tasks.add(task);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
  
  Future<bool> deleteTask(Task task) {
    try {
      _tasks.removeWhere((element) => element.title == task.title);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

}

class Task {
  String title;
  String description;
  String hour;
  String periodicity;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.hour,
    required this.periodicity,
  });
}

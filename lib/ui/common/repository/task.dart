import 'package:myapp/ui/common/repository/reminders_repository.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';

class Task {
  String uuid;
  String description;
  String hour;
  List<DaysOfWeek> daysOfExecution;
  bool isActive;
  TaskType type;

  Task({
    required this.uuid,
    required this.description,
    required this.isActive,
    required this.hour,
    required this.daysOfExecution,
    required this.type,
  });
}

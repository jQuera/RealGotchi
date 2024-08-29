import 'package:myapp/data/datasources/gotchi_local_datasource.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/repository/task.dart';

class RemindersRepository {
  static final RemindersRepository instance = RemindersRepository._internal();
  final RealGotchiLocalDatasource _localDatasource = RealGotchiLocalDatasource();

  RemindersRepository._internal();

  List<Reminder> _reminders = [];

  Future<void> init() async {
    await _loadRemindersFromLocalStorage();
  }

  Future<void> _loadRemindersFromLocalStorage() async {
    final reminderMaps = await _localDatasource.getReminders();
    _reminders = reminderMaps.map((map) => Reminder.fromMap(map)).toList();
  }

  Future<void> createRemindersFromTask(Task task) async {
    var currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime nextDay = currentDate.add(Duration(days: i));
      DayOfWeek dayOfWeek = DayOfWeek.getDayFromDate(nextDay);

      DateTime newDate = DateTime(
        nextDay.year,
        nextDay.month,
        nextDay.day,
        task.executionTime.hour,
        task.executionTime.minute,
      );

      if (task.type == TaskType.salud ||
          (task.type == TaskType.entrenenimiento && dayOfWeek == DayOfWeek.getDayFromDate(task.executionTime))) {
        bool reminderExist = _reminders.any((reminder) => reminder.date == newDate);

        if (!reminderExist && (newDate.isAfter(currentDate) || newDate.isAtSameMomentAs(currentDate))) {
          Reminder newReminder = Reminder(
            id: DateTime.now().toString(),
            description: task.description,
            date: newDate,
            isActive: true,
            isCompleted: false,
          );
          await createReminder(newReminder);
        }
      }
    }
  }

  Future<void> createReminder(Reminder reminder) async {
    await _localDatasource.insertReminder(reminder.toMap());
    _reminders.add(reminder);
  }

  List<Reminder> readReminders() {
    return _reminders;
  }

  Future<void> updateReminder(Reminder reminder) async {
    await _localDatasource.updateReminder(reminder.toMap());
    int index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    await _localDatasource.deleteReminder(reminder.id);
    _reminders.removeWhere((r) => r.id == reminder.id);
  }
}

class Reminder {
  final String id;
  final String description;
  final DateTime date;
  final bool isActive;
  final bool isCompleted;

  Reminder({
    required this.id,
    required this.description,
    required this.date,
    required this.isActive,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isActive: map['isActive'] == 1,
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

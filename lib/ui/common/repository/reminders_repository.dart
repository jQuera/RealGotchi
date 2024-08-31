import 'package:myapp/data/datasources/gotchi_local_datasource.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/models/reminder_model.dart';
import 'package:myapp/ui/common/models/task_model.dart';

class RemindersRepository {
  static final RemindersRepository instance = RemindersRepository._internal();
  final RealGotchiLocalDatasource _localDatasource = RealGotchiLocalDatasource();

  RemindersRepository._internal();

  List<ReminderModel> _reminders = [];

  Future<void> init() async {
    await _loadRemindersFromLocalStorage();
  }

  Future<void> _loadRemindersFromLocalStorage() async {
    final reminderMaps = await _localDatasource.getReminders();
    _reminders = reminderMaps.map((map) => ReminderModel.fromMap(map)).toList();
  }

  Future<void> createRemindersFromTask(TaskModel task) async {
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

      if (task.daysOfWeek.contains(dayOfWeek)) {
        bool reminderExist = _reminders.any((reminder) => reminder.date == newDate);

        if (!reminderExist && (newDate.isAfter(currentDate) || newDate.isAtSameMomentAs(currentDate))) {
          ReminderModel newReminder = ReminderModel(
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

  Future<void> createReminder(ReminderModel reminder) async {
    await _localDatasource.insertReminder(reminder.toMap());
    _reminders.add(reminder);
  }

  Future<List<ReminderModel>> readReminders() async {
    if (_reminders.isEmpty) {
      await _loadRemindersFromLocalStorage();
    }
    return _reminders;
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    await _localDatasource.updateReminder(reminder.toMap());
    int index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
    }
  }

  Future<void> deleteReminder(ReminderModel reminder) async {
    await _localDatasource.deleteReminder(reminder.id);
    _reminders.removeWhere((r) => r.id == reminder.id);
  }
}

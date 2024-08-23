import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/extensions/extensions.dart';
import 'package:myapp/ui/common/repository/task.dart';

class RemindersRepository {
  static final RemindersRepository instance = RemindersRepository._internal();
  RemindersRepository._internal();

  final List<Reminder> _reminders = [];

  void createReminder(Reminder reminder) {
    _reminders.add(reminder);
  }

  Future<void> createRemindersFromTask(Task task) async {
    //TODO: crear recordatorios para los proximos 7 dias segun la Task
    var currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime nextDay = currentDate.add(Duration(days: i));
      DayOfWeek dayOfWeek = DayOfWeek.getDayFromDate(nextDay);

      // Crear la fecha y hora específica para el reminder
      DateTime newDate = DateTime(
        nextDay.year,
        nextDay.month,
        nextDay.day,
        Extensions.timeOfDayFromString(task.hour).hour,
        Extensions.timeOfDayFromString(task.hour).minute,
      );

      if (task.daysOfExecution.contains(dayOfWeek)) {
        bool reminderExist = _reminders.any((reminder) => reminder.date == newDate);

        // Solo crear el recordatorio si no existe y la hora es en el futuro o es la misma
        if (!reminderExist && (newDate.isAfter(currentDate) || newDate.isAtSameMomentAs(currentDate))) {
          Reminder newReminder = Reminder(
            id: DateTime.now().toString(),
            description: task.description,
            date: newDate,
            isActive: true,
            isCompleted: false,
          );
          createReminder(newReminder);
        }
      }
    }
  }

  List<Reminder> readReminders() {
    return _reminders;
  }

  void updateReminder(Reminder reminder) {
    for (int i = 0; i < _reminders.length; i++) {
      if (_reminders[i].id == reminder.id) {
        _reminders[i] = reminder;
        break;
      }
    }
  }

  void deleteReminder(Reminder reminder) {
    _reminders.remove(reminder);
  }

  Future<List<Reminder>> getRemindersOfDay(DateTime dateTime) {
    List<Reminder> remindersOfDay = [];

    for (Reminder reminder in _reminders) {
      if (reminder.date.day == dateTime.day) {
        remindersOfDay.add(reminder);
      }
    }

    return Future.value(remindersOfDay);
  }
}

class Reminder {
  String id;
  String description;
  DateTime date;
  bool isCompleted;
  bool isActive;

  Reminder({
    required this.id,
    required this.description,
    required this.date,
    required this.isActive,
    required this.isCompleted,
  });
}

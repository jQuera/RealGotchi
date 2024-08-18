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

enum DaysOfWeek {
  monday("Lunes"),
  tuesday("Martes"),
  wednesday("Miercoles"),
  thursday("Jueves"),
  friday("Viernes"),
  saturday("Sabado"),
  sunday("Domingo");

  const DaysOfWeek(this.name);

  final String name;
}

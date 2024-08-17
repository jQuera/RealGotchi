class RemindersRepository {
  static final RemindersRepository instance = RemindersRepository._internal();
  RemindersRepository._internal();

  final List<Reminder> _reminders = [];

  void createReminder(Reminder reminder) {
    _reminders.add(reminder);
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

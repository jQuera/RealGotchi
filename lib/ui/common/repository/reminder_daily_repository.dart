import 'package:myapp/ui/common/repository/reminders_repository.dart';

class ReminderDailyRepository {
  static final ReminderDailyRepository instance =
      ReminderDailyRepository._internal();
  ReminderDailyRepository._internal();

  final RemindersRepository remindersRepository = RemindersRepository.instance;

  List<Reminder> remindersOfDay = [];

  Future<void> init() async {
    remindersOfDay =
        await remindersRepository.getRemindersOfDay(DateTime.now());
  }
}

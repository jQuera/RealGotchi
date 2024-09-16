import 'package:flutter/material.dart';
import 'package:myapp/ui/common/models/reminder_model.dart';
import 'package:myapp/ui/common/repository/reminders_of_day_repository.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';
import 'package:myapp/ui/views/home/widgets/pet_view_bar.dart';
// import 'package:myapp/ui/views/home/widgets/status/pages/status_bar.dart';
import 'package:myapp/ui/views/home/widgets/tasks/pages/tasks_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StreamBuilder<int>(
          stream: HomeController.instance.currentPageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return NavigationBar(
              onDestinationSelected: (value) {
                HomeController.instance.changeCurrentPage(value);
              },
              selectedIndex: snapshot.data!,
              backgroundColor: Colors.amber,
              destinations: <Widget>[
                // const NavigationDestination(
                //   selectedIcon: Icon(Icons.health_and_safety_rounded),
                //   icon: Icon(Icons.health_and_safety_rounded),
                //   label: 'Status',
                // ),
                const NavigationDestination(
                  selectedIcon: Icon(
                    Icons.pets_rounded,
                  ),
                  icon: Icon(
                    Icons.pets_rounded,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: StreamBuilder<List<ReminderModel>>(
                      stream: RemindersOfDayRepository.instance.remindersOfDayStream,
                      builder: (context, snapshot) {
                        bool hasPendingReminder = false;
                        if (snapshot.hasData) {
                          hasPendingReminder = snapshot.data!.any((reminder) =>
                              reminder.date.isBefore(DateTime.now()) && !reminder.isCompleted && reminder.isActive);
                        }
                        return Badge(
                          isLabelVisible: hasPendingReminder,
                          child: const Icon(Icons.pending_actions_rounded),
                        );
                      }),
                  label: 'Tareas',
                ),
              ],
            );
          }),
      body: StreamBuilder<int>(
          stream: HomeController.instance.currentPageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return <Widget>[
              // const StatusBar(),
              const PetViewBar(),
              const TasksBar(),
            ][snapshot.data!];
          }),
    );
  }
}

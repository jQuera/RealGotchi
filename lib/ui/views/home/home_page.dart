import 'package:flutter/material.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';
import 'package:myapp/ui/views/home/widgets/pet_view_bar.dart';
import 'package:myapp/ui/views/home/widgets/status/pages/status_bar.dart';
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
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.health_and_safety_rounded),
                  icon: Badge(child: Icon(Icons.health_and_safety_rounded)),
                  label: 'Status',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.pets_rounded,
                  ),
                  icon: Icon(
                    Icons.pets_rounded,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Badge(
                    label: Text('2'),
                    child: Icon(Icons.pending_actions_rounded),
                  ),
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
              const StatusBar(),
              const PetViewBar(),
              const TasksBar(),
            ][snapshot.data!];
          }),
    );
  }
}

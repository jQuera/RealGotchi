import 'package:flutter/material.dart';
import 'package:myapp/ui/views/home/home_page.dart';
import 'package:myapp/ui/views/status/pages/status_page.dart';
import 'package:myapp/ui/views/tasks/pages/tasks_page.dart';
import 'package:myapp/ui/widgets/main_bottom_buttom.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({
    super.key,
    required this.current,
  });
  final int current;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomButtom(
            icon: Icons.health_and_safety_rounded,
            isCurrent: current == 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatusPage(),
                ),
              );
            },
          ),
          //TODO: Te devuelve a la vista general de mascota
          BottomButtom(
            icon: Icons.pets_rounded,
            isCurrent: current == 1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          //TODO: Abrir vista que muestra tareas del dia, agrupadas por tipo
          //(alimentacion, salud y bienestar, higiene, actividad fisica, comportamiento)
          BottomButtom(
            icon: Icons.pending_actions_rounded,
            isCurrent: current == 2,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TasksPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

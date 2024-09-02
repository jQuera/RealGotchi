import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/common/models/reminder_model.dart';
import 'package:myapp/ui/common/repository/reminders_of_day_repository.dart';
import 'package:myapp/ui/common/models/task_model.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';
import 'package:myapp/ui/views/home/widgets/tasks/controller/edit_task_controller.dart';
import 'package:myapp/ui/views/home/widgets/tasks/pages/edit_task_page.dart';
import 'package:myapp/ui/views/home/widgets/tasks/widgets/reminder_widget.dart';

class TasksBar extends StatelessWidget {
  const TasksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Tareas"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                EditTaskController.instance.init();
                TaskModel? newTask = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const EditTaskPage();
                  }),
                );
                if (newTask == null) {
                  debugPrint("No se creo la tarea");
                  return;
                }
                await controller.tasksRepository.createTask(newTask);
                controller.getRemindersOfDay();
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.previousDay();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                StreamBuilder<DateTime>(
                    stream: controller.currentDayStream,
                    builder: (context, snapshot) {
                      //Por corregir, no esta tomando bien el dia de la semana desde el sistema
                      if (!snapshot.hasData) return const SizedBox.shrink();
                      debugPrint("snapshot: ${snapshot.data!.day}");
                      debugPrint("today: ${DateTime.now().day}");
                      return Column(
                        children: [
                          Text(
                            snapshot.data!.day == DateTime.now().day
                                ? "Hoy"
                                : DateFormat('EEEE').format(snapshot.data!),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd - MMMM').format(snapshot.data!),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }),
                IconButton(
                  onPressed: () {
                    controller.nextDay();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ReminderModel>>(
              stream: RemindersOfDayRepository.instance.remindersOfDayStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text(
                    "Aún no tienes recordatorios\nCrea uno en la esquina superior derecha",
                    textAlign: TextAlign.center,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 15, 12, 24),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ReminderWidget(
                      description: snapshot.data![index].description,
                      time: DateFormat('HH:mm').format(snapshot.data![index].date),
                      completed: snapshot.data![index].isCompleted,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';
import 'package:myapp/ui/views/home/widgets/tasks/controller/create_task_controller.dart';
import 'package:myapp/ui/views/home/widgets/tasks/pages/create_task_page.dart';

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
                CreateTaskController.instance.init();
                Task? newTask = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const CreateTaskPage();
                }));
                if (newTask == null) {
                  print("No se creo la tarea");
                  return;
                }
                controller.tasksRepository.createTask(newTask);
              } catch (e) {
                print(e);
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
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('EEEE').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd - MMMM').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  StreamBuilder<List<Task>>(
                      stream: TasksRepository.instance.tasksSaludStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return TasksContainer(
                          categoryTitle: TaskType.salud.name,
                          tasks: snapshot.data!,
                        );
                      }),
                  const SizedBox(height: 15),
                  StreamBuilder(
                      stream: TasksRepository.instance.tasksAlimentacionStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return TasksContainer(
                          categoryTitle: TaskType.alimentacion.name,
                          tasks: snapshot.data!,
                        );
                      }),
                  const SizedBox(height: 15),
                  StreamBuilder(
                      stream: TasksRepository.instance.tasksHigieneStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return TasksContainer(
                          categoryTitle: TaskType.higiene.name,
                          tasks: snapshot.data!,
                        );
                      }),
                  const SizedBox(height: 15),
                  StreamBuilder(
                      stream: TasksRepository.instance.tasksEntrenenimientoStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return TasksContainer(
                          categoryTitle: TaskType.entrenenimiento.name,
                          tasks: snapshot.data!,
                        );
                      }),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TasksContainer extends StatelessWidget {
  const TasksContainer({
    super.key,
    required this.categoryTitle,
    required this.tasks,
  });

  final String categoryTitle;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          tasks.isEmpty
              ? const Row(
                  children: [
                    Text("Todavia no has asignado tareas"),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    return TaskWidget(
                      description: task.description,
                      time: task.hour,
                      completed: task.isCompleted,
                    );
                  },
                )
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.description,
    required this.time,
    required this.completed,
  });

  final String description;
  final String time;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
            ),
            Text(description),
          ],
        ),
        Text(time)
      ],
    );
  }
}

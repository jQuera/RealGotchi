import 'package:flutter/material.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:myapp/ui/views/home/widgets/tasks/modal/create_task_bottom_modal.dart';

class TasksBar extends StatelessWidget {
  const TasksBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Tareas"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const CreateTaskBottomModal();
                },
              );
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                  ],
                ),
              ),
            ),
          ],
        ),
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
            Text("Jugar con pelota"),
          ],
        ),
        Text("20:15")
      ],
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
        color: Colors.lightBlue.shade300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          tasks.isEmpty
              ? const Text("Todavia no has asignado tareas")
              : ListView.builder(
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

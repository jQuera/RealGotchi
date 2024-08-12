import 'package:flutter/material.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:myapp/ui/views/home/widgets/tasks/controller/create_task_controller.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = CreateTaskController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva tarea"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  height: 80,
                  child: TextField(
                    controller: controller.descriptionController,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "Descripcion",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Hora de ejecución"),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          initialTime: controller.executionTime,
                          context: context,
                        );
                        if (selectedTime == null) {
                          return;
                        }
                        controller.changeExecutionTime(selectedTime);
                        // TODO: guardar el tiempo en el controller
                        print(selectedTime.toString());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: StreamBuilder<TimeOfDay>(
                            stream: controller.executionTimeStream,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) return const SizedBox.shrink();
                              return Text(
                                snapshot.data!.format(context),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Frecuencia"),
                    StreamBuilder<TaskFrequency>(
                        stream: controller.taskFrequencySelectedStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox.shrink();
                          return DropdownButton<TaskFrequency>(
                            value: snapshot.data,
                            items: TaskFrequency.values.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.descripcion),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              controller.changeTaskFrequency(value);
                            },
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Categoría"),
                    StreamBuilder<TaskType>(
                        stream: controller.taskTypeSelectedStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox.shrink();
                          return DropdownButton<TaskType>(
                            value: snapshot.data,
                            items: TaskType.values.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              controller.changeTaskType(value);
                            },
                          );
                        }),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Crear tarea"),
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom + 20)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

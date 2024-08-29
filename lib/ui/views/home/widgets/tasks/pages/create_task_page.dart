import 'package:flutter/material.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';
import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/views/home/widgets/tasks/controller/create_task_controller.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = CreateTaskController.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false, // Esta línea evita que el contenido se reajuste cuando el teclado aparece
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
                TextField(
                  controller: controller.descriptionController,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 2,
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
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: StreamBuilder<TimeOfDay>(
                            stream: controller.executionTimeStream,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const SizedBox.shrink();
                              }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Que dia"),
                    StreamBuilder<List<DayOfWeek>>(
                      stream: controller.daysOfExecutionStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return Row(
                          children: List.generate(
                            7,
                            (index) {
                              DayOfWeek day = DayOfWeek.values[index];
                              return GestureDetector(
                                onTap: () {
                                  if (snapshot.data!.contains(day)) {
                                    snapshot.data!.remove(day);
                                  } else {
                                    snapshot.data!.add(day);
                                  }
                                  controller.changeDaysOfExecution(snapshot.data!);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: snapshot.data!.contains(day) ? Colors.amber : Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    day.name[0],
                                    style: TextStyle(
                                      color: snapshot.data!.contains(day) ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.createTask();
                  },
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

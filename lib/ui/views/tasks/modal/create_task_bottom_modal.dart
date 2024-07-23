import 'package:flutter/material.dart';

class CreateTaskBottomModal extends StatelessWidget {
  const CreateTaskBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            "Nueva Tarea",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Container(
            height: 80,
            child: TextField(
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Descripcion",
              ),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Hora de tarea"),
              GestureDetector(
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (selectedTime == null) {
                    return;
                  }

                  // TODO: guardar el tiempo en el controller
                  print(selectedTime.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("22:22"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Repeticion"),
              GestureDetector(
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (selectedTime == null) {
                    return;
                  }

                  // TODO: guardar el tiempo en el controller
                  print(selectedTime.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Cada 2 dias"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tipo"),
              GestureDetector(
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (selectedTime == null) {
                    return;
                  }

                  // TODO: guardar el tiempo en el controller
                  print(selectedTime.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Felicidad"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Guardar"),
          )
        ],
      ),
    );
  }
}

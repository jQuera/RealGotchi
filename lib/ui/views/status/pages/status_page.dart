import 'package:flutter/material.dart';
//TODO: Vista que muestra estado de mascota, un resumen de las tareas realizadas y pendientes

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: const Text("Status Page"),
      ),
      body: const Column(
        children: [
          StatusMonitor(
            title: "Felicidad",
            quantityCompleted: 7,
            statusColor: Colors.orange,
          ),
          SizedBox(height: 15),
          StatusMonitor(
            title: "Higiene",
            quantityCompleted: 3,
            statusColor: Colors.green,
          ),
          SizedBox(height: 15),
          StatusMonitor(
            title: "Alimentacion",
            quantityCompleted: 10,
            statusColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}

class StatusMonitor extends StatelessWidget {
  const StatusMonitor({
    super.key,
    required this.title,
    required this.quantityCompleted,
    required this.statusColor,
  });

  final String title;
  final int quantityCompleted;
  final Color statusColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade300,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                10,
                (index) {
                  return Container(
                    height: 30,
                    width: 20,
                    color: index < quantityCompleted
                        ? statusColor
                        : Colors.grey.shade400,
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.deepPurple.shade300,
            child: Text('$quantityCompleted/10 Tareas completadas'),
          ),
        ],
      ),
    );
  }
}

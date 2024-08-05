import 'package:flutter/material.dart';
//TODO: Vista que muestra estado de mascota, un resumen de las tareas realizadas y pendientes

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: const Text("Status Page"),
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Container(
                color: Colors.deepPurple.shade300,
                child: Text('$quantityCompleted/10 Tareas completadas',
                    style: const TextStyle(fontSize: 12)),
              ),
            ],
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
        ],
      ),
    );
  }
}

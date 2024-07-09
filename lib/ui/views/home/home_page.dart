import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Donita Barra'),
                    Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: const Row(
                children: [
                  Status(
                    value: 50,
                    color: Colors.red,
                  ),
                  Status(
                    value: 75,
                    color: Colors.amber,
                  ),
                  Status(
                    value: 25,
                    color: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    super.key,
    required this.value,
    required this.color,
  });

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: 60,
      height: 60,
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: value / 100,
        child: Container(
          color: color,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const Positioned(
                      top: 30,
                      child: Text(
                        'Donita Barra',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/prototype_images/portrait_cat.jpg',
                        fit: BoxFit.contain,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: const Column(
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

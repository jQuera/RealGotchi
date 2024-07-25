import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import '../../widgets/main_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final O3DController controller = O3DController()..play();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.red,
                    alignment: Alignment.bottomCenter,
                    child: O3D.asset(
                      src: 'assets/3d_models/toon_cat_free.glb',
                      controller: controller,
                      backgroundColor: Colors.purple,
                      ar: false,
                      autoPlay: true,
                      autoRotate: false,
                      xrEnvironment: false,
                      touchAction: TouchAction.none,
                      cameraControls: true,
                      disablePan: true,
                      disableZoom: true,
                    ),
                  ),
                  const Positioned(
                    top: 30,
                    child: SafeArea(
                      child: Text(
                        'Donita Barra',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 24,
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
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
                  ),
                ],
              ),
            ),
          ),
          const MainBottomBar(current: 1)
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

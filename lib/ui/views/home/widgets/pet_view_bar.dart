import 'package:flutter/material.dart';

class PetViewBar extends StatelessWidget {
  const PetViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/prototype_images/portrait_cat.jpg'),
          ),
          const Positioned(
            top: 10,
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
        ],
      ),
    );
  }
}

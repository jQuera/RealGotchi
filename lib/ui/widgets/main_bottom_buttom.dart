import 'package:flutter/material.dart';

class BottomButtom extends StatelessWidget {
  const BottomButtom({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isCurrent,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isCurrent ? null : () => onPressed(),

      // decoration: const BoxDecoration(
      //   color: Colors.orange,
      //   shape: BoxShape.circle,
      // ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10), elevation: 0,
        // backgroundColor: isCurrent ? Colors.orange : null,
        disabledBackgroundColor: Colors.orange,
      ),
      child: Icon(
        icon,
        size: 35,
      ),
    );
  }
}

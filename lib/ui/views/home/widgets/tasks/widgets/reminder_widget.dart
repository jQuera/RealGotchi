import 'package:flutter/material.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({
    super.key,
    required this.description,
    required this.time,
    required this.completed,
  });

  final String description;
  final String time;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
            ),
            Text(description),
          ],
        ),
        Text(time)
      ],
    );
  }
}

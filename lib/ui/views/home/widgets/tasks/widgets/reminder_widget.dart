import 'package:flutter/material.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({
    super.key,
    required this.description,
    required this.time,
    required this.completed,
    required this.onChangedStatus,
  });

  final String description;
  final String time;
  final bool completed;
  final ValueChanged<bool> onChangedStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: completed,
              onChanged: (value) {
                if (value == null) return;
                onChangedStatus(value);
              },
            ),
            Text(description),
          ],
        ),
        Text(time)
      ],
    );
  }
}

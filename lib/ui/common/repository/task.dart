import 'package:myapp/ui/common/enums/task_type.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime executionTime;
  final TaskType type;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.executionTime,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'executionTime': executionTime.toIso8601String(),
      'type': type.index,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      executionTime: DateTime.parse(map['executionTime'] as String),
      type: TaskType.values[map['type'] as int],
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? executionTime,
    TaskType? type,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      executionTime: executionTime ?? this.executionTime,
      type: type ?? this.type,
    );
  }
}

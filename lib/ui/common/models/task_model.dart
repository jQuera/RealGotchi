import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime executionTime;
  final TaskType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DayOfWeek> daysOfWeek;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.executionTime,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.daysOfWeek,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'executionTime': executionTime.toIso8601String(),
      'type': type.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'daysOfWeek': daysOfWeek.map((day) => day.index).toList(),
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      executionTime: DateTime.parse(map['executionTime'] as String),
      type: TaskType.values[map['type'] as int],
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      daysOfWeek: (map['daysOfWeek'] as List<dynamic>).map((day) => DayOfWeek.values[day as int]).toList(),
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? executionTime,
    TaskType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<DayOfWeek>? daysOfWeek,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      executionTime: executionTime ?? this.executionTime,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}

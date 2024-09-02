import 'package:myapp/ui/common/enums/task_type.dart';
import 'package:myapp/ui/common/enums/day_of_week.dart';

class TaskModel {
  final String id;
  String title;
  String description;
  DateTime executionTime;
  TaskType type;
  final DateTime createdAt;
  DateTime updatedAt;
  List<DayOfWeek> daysOfWeek;

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
      'daysOfWeek': daysOfWeek.map((day) => day.index).join(','),
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      executionTime: DateTime.parse(map['executionTime'].toString()),
      type: TaskType.values[int.parse(map['type'].toString())],
      createdAt: DateTime.parse(map['createdAt'].toString()),
      updatedAt: DateTime.parse(map['updatedAt'].toString()),
      daysOfWeek: map['daysOfWeek'].toString().split(',').map((day) => DayOfWeek.values[int.parse(day)]).toList(),
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

class ReminderModel {
  final String id;
  String description;
  DateTime date;
  bool isActive;
  bool isCompleted;
  final String taskId;

  ReminderModel({
    required this.id,
    required this.description,
    required this.date,
    required this.isActive,
    required this.isCompleted,
    required this.taskId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'taskId': taskId,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isActive: map['isActive'] == 1,
      isCompleted: map['isCompleted'] == 1,
      taskId: map['taskId'],
    );
  }
}

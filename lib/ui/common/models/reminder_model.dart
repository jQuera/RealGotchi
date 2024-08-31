class ReminderModel {
  final String id;
  final String description;
  final DateTime date;
  final bool isActive;
  final bool isCompleted;

  ReminderModel({
    required this.id,
    required this.description,
    required this.date,
    required this.isActive,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isActive: map['isActive'] == 1,
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

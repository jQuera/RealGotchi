import 'package:intl/intl.dart';

enum DayOfWeek {
  monday("Lunes", 1),
  tuesday("Martes", 2),
  wednesday("Miercoles", 3),
  thursday("Jueves", 4),
  friday("Viernes", 5),
  saturday("Sabado", 6),
  sunday("Domingo", 7);

  const DayOfWeek(
    this.name,
    this.number,
  );

  final String name;
  final int number;
  // Función auxiliar para obtener el día de la semana como enum
  static DayOfWeek getDayFromDate(DateTime date) {
    String dayName = DateFormat('EEEE').format(date);
    return DayOfWeek.values.firstWhere((day) => day.name == dayName);
  }
}

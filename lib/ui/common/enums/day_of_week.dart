import 'package:intl/intl.dart';

enum DayOfWeek {
  monday("Lunes", 1),
  tuesday("Martes", 2),
  wednesday("Miércoles", 3),
  thursday("Jueves", 4),
  friday("Viernes", 5),
  saturday("Sábado", 6),
  sunday("Domingo", 7);

  const DayOfWeek(this.name, this.number);

  final String name;
  final int number;

  static DayOfWeek getDayFromDate(DateTime date) {
    // Asegurarse de que DateFormat use la configuración regional en español
    String dayName = DateFormat('EEEE', 'es_ES').format(date);
    try {
      return DayOfWeek.values.firstWhere((day) => day.name.toUpperCase() == dayName.toUpperCase());
    } catch (e) {
      // Manejo de error en caso de que no se encuentre un día correspondiente
      print("Error: No se encontró un día que coincida con $dayName");
      // Retornar un valor predeterminado o lanzar un error
      throw Exception("No matching DayOfWeek found for $dayName");
    }
  }
}

import 'package:intl/intl.dart';

enum DaysOfWeek {
  monday("Lunes"),
  tuesday("Martes"),
  wednesday("Miercoles"),
  thursday("Jueves"),
  friday("Viernes"),
  saturday("Sabado"),
  sunday("Domingo");

  const DaysOfWeek(this.name);

  final String name;

  // Función auxiliar para obtener el día de la semana como enum
  static DaysOfWeek getDayFromDate(DateTime date) {
    String dayName = DateFormat('EEEE').format(date);
    return DaysOfWeek.values.firstWhere((day) => day.name == dayName);
  }
}

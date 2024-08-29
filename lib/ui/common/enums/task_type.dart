enum TaskType {
  alimentacion(name: "Alimentación"),
  higiene(name: "Higiene"),
  salud(name: "Salud"),
  entrenenimiento(name: "Entrenenimiento");

  final String name;
  const TaskType({required this.name});
}

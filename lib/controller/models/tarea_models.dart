
import 'package:floor/floor.dart';

@entity
class TareaModel {
  @PrimaryKey(autoGenerate: true)
  int? idTarea;
  final String nombreTarea;
  final String nombreClase;
  final String descripcionTarea;
  late final bool completadaTarea;
  late final String fechaTarea;

  TareaModel(
      {this.idTarea,
      required this.nombreTarea,
      required this.nombreClase,
      required this.descripcionTarea,
      required this.completadaTarea,
      required this.fechaTarea});
}


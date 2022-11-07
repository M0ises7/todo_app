import 'package:flutter/cupertino.dart';
import 'package:todo_app/controller/models/tarea_models.dart';

class BodyTile extends StatelessWidget {
  final TareaModel tarea;
  const BodyTile({super.key, required this.tarea});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tarea.nombreTarea,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        const SizedBox(
          height: 5.0,
        ),
        Text(tarea.nombreClase),
        const SizedBox(
          height: 5.0,
        ),
        Text("Fecha: ${tarea.fechaTarea}"),
      ],
    );
  }
}

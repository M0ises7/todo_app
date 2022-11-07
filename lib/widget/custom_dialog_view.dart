import 'package:flutter/material.dart';
import 'package:todo_app/controller/models/tarea_models.dart';

verInfoLista(context, TareaModel tareaModel) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: dialog(ctx, tareaModel),
        );
      },
      transitionDuration: const Duration(milliseconds: 300));
}

Widget dialog(BuildContext context, TareaModel tareaModel) {
  return AlertDialog(
    title: Text(tareaModel.nombreTarea),
    content: bodyDialog(tareaModel),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Listo",
            style: TextStyle(color: Colors.red, fontSize: 17),
          ))
    ],
  );
}

Widget bodyDialog(TareaModel tareaModel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(color: Colors.black),
      const Text("Descripcion de la tarea", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 5,
      ),
      Text(tareaModel.descripcionTarea),
      const SizedBox(
        height: 10,
      ),
      const Text("Materia de clase", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 5,
      ),
      Text(tareaModel.nombreClase),
      const SizedBox(
        height: 10,
      ),
      const Text("Fecha de entrega", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 5,
      ),
      Text(tareaModel.fechaTarea)
    ],
  );
}

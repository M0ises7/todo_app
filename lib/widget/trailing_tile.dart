import 'package:flutter/material.dart';
import 'package:todo_app/controller/models/tarea_models.dart';

import '../controller/controller.dart';

class TrailingTile extends StatelessWidget {
  final TareaModel tm;
  final Function()? functionCancelar;
  final Function()? functionConfirmar;

  const TrailingTile(
      {super.key,
      this.functionCancelar,
      this.functionConfirmar,
      required this.tm});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: (tm.completadaTarea == true)
            ? const Icon(Icons.refresh)
            : const Icon(Icons.add_task),
        onPressed: () async {
          bool r = await Controller.updateTasks([tm]);
          if (r) {
            showDialog(
              context: context,
              builder: (context) {
                if (tm.completadaTarea == true) {
                  return AlertDialog(
                    title: const Text("Incompleta"),
                    content: const Text(
                        "La tarea pasara a la pestaña de correspondiente, para que puedas terminarla"),
                    actions: [
                      TextButton(
                          onPressed: functionConfirmar,
                          child: const Text("Confirmar ")),
                      TextButton(
                          onPressed: functionCancelar,
                          child: const Text("Cancelar"))
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: const Text("Terminada"),
                    content: const Text(
                        "La tarea pasara a la pestaña de completada"),
                    actions: [
                      TextButton(
                          onPressed: functionConfirmar,
                          child: const Text("Confirmar ")),
                      TextButton(
                          onPressed: functionCancelar,
                          child: const Text("Cancelar"))
                    ],
                  );
                }
              },
            );
          }
        });
  }
}

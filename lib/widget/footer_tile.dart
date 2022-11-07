import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/models/tarea_models.dart';
import 'package:todo_app/observables/app_management.dart';

import '../screens/formulario/form_nuevo.dart';

class FooterTile extends StatelessWidget {
  final TareaModel tareaModel;
  final Function()? functionDelete;
  const FooterTile({
    Key? key,
    required this.functionDelete,
    required this.tareaModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: const Text(
            "Editar",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormNuevo(
                          appManagement: appManagement,
                          tareaModel: tareaModel,
                        )));
          },
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
          child: const Text(
            "Eliminar",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Eliminar elemento"),
                  content: const Text(
                      "Tendrá que crear la tarea nuevamente ¿Está de acuerdo?"),
                  actions: [
                    TextButton(
                        onPressed: functionDelete,
                        child: const Text("Confirmar ")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar"))
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}

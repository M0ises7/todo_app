// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import '../../controller/models/tarea_models.dart';
import '../../observables/app_management.dart';
import '../../widget/body_tile.dart';
import '../../widget/custom_dialog_view.dart';
import '../../widget/footer_tile.dart';
import '../../widget/trailing_tile.dart';

class HoyView extends StatefulWidget {
  const HoyView({super.key});

  @override
  State<HoyView> createState() => _HoyViewState();
}

class _HoyViewState extends State<HoyView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);
    appManagement.tabIndex = 0;
    return listahoy(appManagement);
  }

  Widget listahoy(AppManagement appManagement) {
    appManagement.setAsyncTask();
    if (appManagement.observerTasksToday == []) {
      return const Center(
        child: Text("No hay tareas para hoy"),
      );
    }else{
      return Observer(
      builder: (context) {
        List<TareaModel> tasks = appManagement.observerTasksToday;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            TareaModel tm = TareaModel(
              nombreTarea: tasks[index].nombreTarea,
              nombreClase: tasks[index].nombreClase,
              descripcionTarea: tasks[index].descripcionTarea,
              completadaTarea: tasks[index].completadaTarea,
              fechaTarea: tasks[index].fechaTarea,
              idTarea: tasks[index].idTarea,
            );
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      verInfoLista(context, tm);
                    },
                    title: Row(
                      children: [
                        Expanded(flex: 8, child: BodyTile(tarea: tm)),
                        Expanded(
                          flex: 2,
                          child: TrailingTile(
                            tm: tm,
                            functionCancelar: () {
                              Navigator.of(context).pop();
                            },
                            functionConfirmar: () async {
                              TareaModel tm = TareaModel(
                                nombreTarea: tasks[index].nombreTarea,
                                nombreClase: tasks[index].nombreClase,
                                descripcionTarea: tasks[index].descripcionTarea,
                                completadaTarea: true,
                                fechaTarea: tasks[index].fechaTarea,
                                idTarea: tasks[index].idTarea,
                              );
                              tasks.removeWhere((t) => t.idTarea == tm.idTarea);
                              appManagement.observerComplete.add(tm);
                              appManagement.observerTasksToday = tasks;
                              await Controller.updateTasks([tm]);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    subtitle: FooterTile(
                      functionDelete: () async {
                        tasks.removeWhere((t) => t.idTarea == tm.idTarea);
                        appManagement.observerTasks = tasks;
                        await Controller.deleteTasks([tm]);
                        Navigator.of(context).pop();
                      },
                      tareaModel: tm,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    }
    
  }
}

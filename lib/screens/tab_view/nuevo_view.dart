// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../controller/models/tarea_models.dart';
import '../../observables/app_management.dart';
import '../../widget/body_tile.dart';
import '../../widget/custom_dialog_view.dart';
import '../../widget/footer_tile.dart';
import '../../widget/trailing_tile.dart';

class NuevoView extends StatefulWidget {
  const NuevoView({super.key});

  @override
  State<NuevoView> createState() => _NuevoViewState();
}

class _NuevoViewState extends State<NuevoView> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);
    appManagement.tabIndex = 1;
    return lista(appManagement);
  }

  Observer lista(AppManagement appManagement) {
    appManagement.setAsyncTask();
    var fehcaHoy = DateTime.now();
    String formattedDateHoy = DateFormat('yyyy-MM-dd').format(fehcaHoy);
    return Observer(
      builder: (context) {
        List<TareaModel> tasks = appManagement.observerTasks;
        tasks = tasks
            .where((element) =>
                element.completadaTarea == false &&
                element.fechaTarea != formattedDateHoy)
            .toList();
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
              child: ListTile(
                tileColor: Colors.white,
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
                          appManagement.observerTasks = tasks;
                          Navigator.of(context).pop();
                          await Controller.updateTasks([tm]);
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
            );
          },
        );
      },
    );
  }
}

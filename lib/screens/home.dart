// ignore_for_file: file_names, must_be_immutable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/screens/tab_view/completadas_view.dart';
import 'package:todo_app/screens/tab_view/hoy_view.dart';
import 'package:todo_app/screens/tab_view/nuevo_view.dart';
import '../controller/models/tarea_models.dart';
import '../observables/app_management.dart';
import '../screens/formulario/form_nuevo.dart';
import '../utils/utils.dart';
import '../widget/float_action_button.dart';

class Home extends StatefulWidget {
  TareaModel? tareaModel;
  final AppManagement? appManagement;
  Home({super.key, required this.appManagement, this.tareaModel});
  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(
      () {
        widget.appManagement!.tabIndex = tabController.index;
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: "Hoy"),
                  Tab(text: "Proximas"),
                  Tab(text: "Completadas"),
                ],
              ),
              title: const Text("Tareas")),
          body: TabBarView(
            controller: tabController,
            children: const [HoyView(), NuevoView(), CompletadasView()],
          ),
          floatingActionButton: Observer(
            builder: (context) {
              return caseFAB(
                  index: appManagement.tabIndex, appManagement: appManagement);
            },
          ),
        ),
      ),
    );
  }

  Widget caseFAB({required int index, AppManagement? appManagement}) {
    final fechahoy = Utils.formatoFecha(DateTime.now());
    return ExpandableFabClass(
      distanceBetween: 80.0,
      subChildren: [
        IconButton(
          onPressed: () async {
            switch (index) {
              case 0:
                if (appManagement != null) {
                  List<TareaModel> tareasFiltradas = appManagement
                      .observerTasksToday
                      .where((e) =>
                          e.completadaTarea == false &&
                          e.fechaTarea == fechahoy)
                      .toList();
                  int afectados = await Controller.deleteTasks(tareasFiltradas);
                  // ignore: use_build_context_synchronously
                  MotionToast.delete(
                          title: const Text("Eliminados"),
                          description: Text("Se eliminaron: $afectados"))
                      .show(context);
                }
                break;
              case 1:
                if (appManagement != null) {
                  List<TareaModel> tareasFiltradas = appManagement.observerTasks
                      .where((e) =>
                          e.completadaTarea == false &&
                          e.fechaTarea != fechahoy)
                      .toList();
                  int afectados = await Controller.deleteTasks(tareasFiltradas);
                  // ignore: use_build_context_synchronously
                  MotionToast.delete(
                          title: const Text("Eliminados"),
                          description: Text("Se eliminaron: $afectados"))
                      .show(context);
                }
                break;
              case 2:
                if (appManagement != null) {
                  List<TareaModel> tareasFiltradas = appManagement
                      .observerComplete
                      .where((e) => e.completadaTarea == true)
                      .toList();
                  int afectados = await Controller.deleteTasks(tareasFiltradas);
                  // ignore: use_build_context_synchronously
                  MotionToast.delete(
                          title: const Text("Eliminados"),
                          description: Text("Se eliminaron: $afectados"))
                      .show(context);
                  appManagement.observerComplete.clear();
                }
                break;
              default:
            }
            widget.appManagement!.setAsyncTask();
          },
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormNuevo()));
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

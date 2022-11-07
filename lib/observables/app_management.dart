// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../controller/controller.dart';
import '../controller/models/tarea_models.dart';
import '../utils/utils.dart';

part 'app_management.g.dart';

// This is the class used by rest of your codebase
class AppManagement = _AppManagement with _$AppManagement;

// The store-class
abstract class _AppManagement with Store {
  @observable
  int tabIndex = 0;

  @observable
  List<TareaModel> observerTasks = ObservableList<TareaModel>.of([]);

  @action
  Future<void> setAsyncTask() async {
    try {
      observerTasks = await Controller.allTasks;
    } catch (e) {
      observerTasks = [];
    }

    observerTasksToday = observerTasks
        .where((t) =>
            t.fechaTarea == Utils.formatoFecha(DateTime.now()) &&
            t.completadaTarea == false)
        .toList();
  }

  @observable
  List<TareaModel> observerComplete = ObservableList<TareaModel>.of([]);

  @observable
  List<TareaModel> observerTasksToday = ObservableList<TareaModel>.of([]);
}

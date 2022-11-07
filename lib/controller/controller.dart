// ignore: file_names

import 'database/database.dart';
import 'models/tarea_models.dart';

class Controller {
  static Future<AppDataBase> initDb() async {
    return await $FloorAppDataBase.databaseBuilder('app_database.db').build();
  }

  static Future<void> insertTask(TareaModel tareaModel) async {
    final db = await initDb();
    await db.tareaDao.insertTarea(tareaModel);
  }

  static Future<List<TareaModel>> get allTasks async {
    final db = await initDb();
    final List<TareaModel> result = await db.tareaDao.findAllTarea();
    return result;
  }

  static Future<bool> updateTasks(List<TareaModel> tareasModel) async {
    final db = await initDb();
    final int result = await db.tareaDao.updateTarea(tareasModel);
    return (result > 0);
  }

  static Future<int> deleteTasks(List<TareaModel>? tareasModel) async {
    final db = await initDb();
    final int result = await db.tareaDao.deleteTarea(tareasModel!);
    return result;
  }
}

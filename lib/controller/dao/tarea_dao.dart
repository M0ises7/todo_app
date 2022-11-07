

import 'package:floor/floor.dart';

import '../models/tarea_models.dart';

@dao
abstract class TareaDao {
  @Query('SELECT * FROM tareaModel')
  Future<List<TareaModel>> findAllTarea();

  @Query('SELECT * FROM tareaModel WHERE id = :id')
  Stream<TareaModel?> findTareaById(int id);

  @Query('DELETE FROM tareaModel')
  Future<void> deleteAlltareaModel();

  @delete
  Future<int> deleteTarea(List<TareaModel> tareasModels);

  @insert
  Future<void> insertTarea(TareaModel tareaModel);

  @update
  Future<int> updateTarea(List<TareaModel> tareasModels);

}
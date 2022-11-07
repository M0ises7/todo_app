
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/tarea_dao.dart';
import '../models/tarea_models.dart';

part 'database.g.dart';
@Database(version: 1, entities: [TareaModel])
abstract class AppDataBase extends FloorDatabase {
  TareaDao get tareaDao;
}

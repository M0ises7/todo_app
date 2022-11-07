// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TareaDao? _tareaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TareaModel` (`idTarea` INTEGER PRIMARY KEY AUTOINCREMENT, `nombreTarea` TEXT NOT NULL, `nombreClase` TEXT NOT NULL, `descripcionTarea` TEXT NOT NULL, `completadaTarea` INTEGER NOT NULL, `fechaTarea` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TareaDao get tareaDao {
    return _tareaDaoInstance ??= _$TareaDao(database, changeListener);
  }
}

class _$TareaDao extends TareaDao {
  _$TareaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _tareaModelInsertionAdapter = InsertionAdapter(
            database,
            'TareaModel',
            (TareaModel item) => <String, Object?>{
                  'idTarea': item.idTarea,
                  'nombreTarea': item.nombreTarea,
                  'nombreClase': item.nombreClase,
                  'descripcionTarea': item.descripcionTarea,
                  'completadaTarea': item.completadaTarea ? 1 : 0,
                  'fechaTarea': item.fechaTarea
                },
            changeListener),
        _tareaModelUpdateAdapter = UpdateAdapter(
            database,
            'TareaModel',
            ['idTarea'],
            (TareaModel item) => <String, Object?>{
                  'idTarea': item.idTarea,
                  'nombreTarea': item.nombreTarea,
                  'nombreClase': item.nombreClase,
                  'descripcionTarea': item.descripcionTarea,
                  'completadaTarea': item.completadaTarea ? 1 : 0,
                  'fechaTarea': item.fechaTarea
                },
            changeListener),
        _tareaModelDeletionAdapter = DeletionAdapter(
            database,
            'TareaModel',
            ['idTarea'],
            (TareaModel item) => <String, Object?>{
                  'idTarea': item.idTarea,
                  'nombreTarea': item.nombreTarea,
                  'nombreClase': item.nombreClase,
                  'descripcionTarea': item.descripcionTarea,
                  'completadaTarea': item.completadaTarea ? 1 : 0,
                  'fechaTarea': item.fechaTarea
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TareaModel> _tareaModelInsertionAdapter;

  final UpdateAdapter<TareaModel> _tareaModelUpdateAdapter;

  final DeletionAdapter<TareaModel> _tareaModelDeletionAdapter;

  @override
  Future<List<TareaModel>> findAllTarea() async {
    return _queryAdapter.queryList('SELECT * FROM tareaModel',
        mapper: (Map<String, Object?> row) => TareaModel(
            idTarea: row['idTarea'] as int?,
            nombreTarea: row['nombreTarea'] as String,
            nombreClase: row['nombreClase'] as String,
            descripcionTarea: row['descripcionTarea'] as String,
            completadaTarea: (row['completadaTarea'] as int) != 0,
            fechaTarea: row['fechaTarea'] as String));
  }

  @override
  Stream<TareaModel?> findTareaById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM tareaModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TareaModel(
            idTarea: row['idTarea'] as int?,
            nombreTarea: row['nombreTarea'] as String,
            nombreClase: row['nombreClase'] as String,
            descripcionTarea: row['descripcionTarea'] as String,
            completadaTarea: (row['completadaTarea'] as int) != 0,
            fechaTarea: row['fechaTarea'] as String),
        arguments: [id],
        queryableName: 'TareaModel',
        isView: false);
  }

  @override
  Future<void> deleteAlltareaModel() async {
    await _queryAdapter.queryNoReturn('DELETE FROM tareaModel');
  }

  @override
  Future<void> insertTarea(TareaModel tareaModel) async {
    await _tareaModelInsertionAdapter.insert(
        tareaModel, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTarea(List<TareaModel> tareasModels) {
    return _tareaModelUpdateAdapter.updateListAndReturnChangedRows(
        tareasModels, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTarea(List<TareaModel> tareasModels) {
    return _tareaModelDeletionAdapter
        .deleteListAndReturnChangedRows(tareasModels);
  }
}

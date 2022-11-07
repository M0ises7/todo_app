// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_management.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppManagement on _AppManagement, Store {
  late final _$tabIndexAtom =
      Atom(name: '_AppManagement.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$observerTasksAtom =
      Atom(name: '_AppManagement.observerTasks', context: context);

  @override
  List<TareaModel> get observerTasks {
    _$observerTasksAtom.reportRead();
    return super.observerTasks;
  }

  @override
  set observerTasks(List<TareaModel> value) {
    _$observerTasksAtom.reportWrite(value, super.observerTasks, () {
      super.observerTasks = value;
    });
  }

  late final _$observerCompleteAtom =
      Atom(name: '_AppManagement.observerComplete', context: context);

  @override
  List<TareaModel> get observerComplete {
    _$observerCompleteAtom.reportRead();
    return super.observerComplete;
  }

  @override
  set observerComplete(List<TareaModel> value) {
    _$observerCompleteAtom.reportWrite(value, super.observerComplete, () {
      super.observerComplete = value;
    });
  }

  late final _$observerTasksTodayAtom =
      Atom(name: '_AppManagement.observerTasksToday', context: context);

  @override
  List<TareaModel> get observerTasksToday {
    _$observerTasksTodayAtom.reportRead();
    return super.observerTasksToday;
  }

  @override
  set observerTasksToday(List<TareaModel> value) {
    _$observerTasksTodayAtom.reportWrite(value, super.observerTasksToday, () {
      super.observerTasksToday = value;
    });
  }

  late final _$setAsyncTaskAsyncAction =
      AsyncAction('_AppManagement.setAsyncTask', context: context);

  @override
  Future<void> setAsyncTask() {
    return _$setAsyncTaskAsyncAction.run(() => super.setAsyncTask());
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex},
observerTasks: ${observerTasks},
observerComplete: ${observerComplete},
observerTasksToday: ${observerTasksToday}
    ''';
  }
}

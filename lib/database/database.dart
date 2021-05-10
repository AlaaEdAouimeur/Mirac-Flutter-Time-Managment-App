import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// Moor works by source gen. This file will all the generated code.
part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();
  IntColumn get category =>
      integer().customConstraint('NULL REFERENCES categories(id)')();
  TextColumn get note => text()();
  IntColumn get color => integer().nullable()();
  IntColumn get icon => integer().nullable()();
  DateTimeColumn get dueDate => dateTime()();
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().withLength(min: 1, max: 50)();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  IntColumn get taskId =>
      integer().customConstraint('NULL REFERENCES tasks(id)')();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get color => integer().withDefault(Constant(0xff))();
  TextColumn get content => text().withLength(min: 1, max: 50)();
}

@UseMoor(tables: [Tasks, Todos, Categories])
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<List<Todo>> getAllNotes(int id) async {
    List<Todo> list = await select(todos).get();
    return list.where((element) => element.id == id).toList();
  }

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future insertTask(Task task) => into(tasks).insert(task);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);

  Future insertTodo(Todo todo) => into(todos).insert(todo);

  Future updateTodo(Todo todo) => update(todos).replace(todo);

  Future deleteTodo(Todo todo) => delete(todos).delete(todo);
  void insertCategories(Categorie c) => into(categories).insert(c);
}

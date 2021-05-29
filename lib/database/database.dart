import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tyme/utils/konstants.dart' as K;

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();
  IntColumn get category =>
      integer().customConstraint('NULL REFERENCES categories(id)')();
  TextColumn get note => text()();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueDate => dateTime()();
  DateTimeColumn get reminderDate => dateTime().nullable()();
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().withLength(min: 0, max: 50)();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  IntColumn get taskId =>
      integer().customConstraint('NULL REFERENCES tasks(id)')();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get color => integer().withDefault(Constant(0xff))();
  IntColumn get iconData => integer().withDefault(Constant(0xff))();
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
//  Future<List<Task>> getTasksByDate(DateTime dateTime) =>   (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<Task> getTask(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<List<Todo>> getAllNotes(int id) async {
    List<Todo> list = await select(todos).get();
    return list.where((element) => element.id == id).toList();
  }

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Stream<List<Task>> watchTasksByCategory(int index) =>
      (select(tasks)..where((tbl) => tbl.category.equals(index))).watch();
  Future<List<Todo>> getAllTodos() => select(todos).get();
  Stream<List<Todo>> watchAllTodos(int id) {
    return (select(todos)..where((tbl) => tbl.taskId.equals(id))).watch();
  }

  Future insertTask(TasksCompanion task) => into(tasks).insert(task);
  Future insertC(CategoriesCompanion cc) => into(categories).insert(cc);
  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);

  Future insertTodo(TodosCompanion todo) => into(todos).insert(todo);

  Future updateTodo(Todo todo) => update(todos).replace(todo);
  Future getAllC() => select(categories).get();
  Future deleteTodo(Todo todo) => delete(todos).delete(todo);
  void insertCategories(Categorie c) => into(categories).insert(c);
  Future<List<Categorie>> getCategories() => select(categories).get();
  void deleteCategory(Categorie c) async {
    delete(categories).delete(c);
    delete(tasks).where((tbl) => tbl.category.equals(c.id));
    K.categories = await getCategories();
  }
}

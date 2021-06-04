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

class PastTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateFinished => dateTime()();
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
  TextColumn get content => text().withLength(min: 2, max: 50)();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  IntColumn get completedTasks => integer().withDefault(Constant(0))();
  IntColumn get pendingTasks => integer().withDefault(Constant(0))();
}

@UseMoor(tables: [PastTasks, Users, Tasks, Todos, Categories])
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

  /////////////TASKS//////////////
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future insertTask(TasksCompanion task) {
    changePendingTasks(1);
    return into(tasks).insert(task);
  }

  Future updateTask(Task task) => update(tasks).replace(task);
  Future deleteTask(Task task) {
    task.isDone ? insertPastTask() : null;
    return delete(tasks).delete(task);
  }

  Stream<List<Task>> watchTasksByCategory(int index) =>
      (select(tasks)..where((tbl) => tbl.category.equals(index))).watch();
  Future<Task> getTask(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingle();
/////////////////////////////////////////////////////////

  //////////////TODOS/////////////
  Future<List<Todo>> getAllNotes(int id) async {
    List<Todo> list = await select(todos).get();
    return list.where((element) => element.id == id).toList();
  }

  Future<List<Todo>> getAllTodos() => select(todos).get();
  Stream<List<Todo>> watchAllTodos(int id) {
    return (select(todos)..where((tbl) => tbl.taskId.equals(id))).watch();
  }

  Future insertTodo(TodosCompanion todo) => into(todos).insert(todo);
  Future updateTodo(Todo todo) => update(todos).replace(todo);
  Future getAllC() => select(categories).get();
  Future deleteTodo(Todo todo) => delete(todos).delete(todo);
////////////////////////////////////////

  ///////////CATEGORIS////////
  void insertCategories(Categorie c) => into(categories).insert(c);
  Future<List<Categorie>> getCategories() => select(categories).get();
  void deleteCategory(Categorie c) async {
    delete(categories).delete(c);
    delete(tasks).where((tbl) => tbl.category.equals(c.id));
    K.categories = await getCategories();
  }
  ////////////////////////////////

/////////////////USER/////////////
  Stream<User> watchUser() {
    return (select(users)).watchSingle();
  }

  void ii() async {
    List<User> _users = await select(users).get();
    print(_users);
  }

  Future insertUser(UsersCompanion user) => into(users).insert(user);
  Future updateUser(User user) => update(users).replace(user);
  Future deleteUser(User user) => delete(users).delete(user);
  Future<int> count() => (select(users).get()).then((value) => value.length);

  Future<void> changeDoneTasks(int x) async {
    User _user = await select(users).getSingle();
    int temp1 = _user.completedTasks + x;
    update(users).replace(_user.copyWith(completedTasks: temp1));
  }

  Future<void> changePendingTasks(int x) async {
    User _user = await select(users).getSingle();
    int temp2 = _user.pendingTasks + x;
    update(users).replace(_user.copyWith(pendingTasks: temp2));
  }
///////////////////////////////////////////

///////////////PAST TASKS///////////////
  Future insertPastTask() => into(pastTasks)
      .insert(PastTasksCompanion(dateFinished: Value(DateTime.now())));

  Stream<List<PastTask>> getPastTasks() => select(pastTasks).watch();
  await(SimpleSelectStatement<$UsersTable, User> simpleSelectStatement) {}
}

import 'dart:math';

import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tyme/utils/konstants.dart' as k;

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();
  IntColumn get category => integer()();
  TextColumn get note => text()();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  BoolColumn get isChallenge => boolean().withDefault(Constant(false))();
  IntColumn get score => integer().nullable()();
  IntColumn get completedTasks => integer().nullable()();
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
  IntColumn get taskId => integer()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get color => integer().withDefault(Constant(0xff))();
  IntColumn get iconData => integer().withDefault(Constant(0xff))();
  TextColumn get content => text().withLength(min: 2, max: 50)();
}

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isChecked => boolean().withDefault(Constant(true))();
  TextColumn get content => text()();
  TextColumn get author => text().nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer().withDefault(Constant(0))();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  IntColumn get completedTasks => integer().withDefault(Constant(0))();
  IntColumn get pendingTasks => integer().withDefault(Constant(0))();
}

@UseMoor(tables: [PastTasks, Users, Tasks, Todos, Categories, Quotes])
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
  Future<List<Task>> getTaskByCategory(int c) =>
      (select(tasks)..where((tbl) => tbl.category.equals(c))).get();
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
    var list = await select(todos).get();
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
  Future<void> insertCategories(CategoriesCompanion c) async {
    await into(categories).insert(c);
    await refreshCategories();
  }

  Future<List<Categorie>> getCategories() => select(categories).get();

  Future<void> initCategories() async {
    await getCategories().then((value) {
      if (value.isEmpty) {
        k.categories = k.premadeCategories;
        k.categories
            .forEach((element) => insertCategories(element.toCompanion(true)));
      } else {
        k.categories = value;
      }
    });
  }

  Future<void> refreshCategories() async {
    await getCategories().then((value) {
      k.categories = value;
    });
  }

  Future<void> deleteCategory(Categorie c) async {
    await (delete(tasks)..where((tbl) => tbl.category.equals(c.id))).go();
    await delete(categories).delete(c);
    await getCategories().then((value) => value.isEmpty
        ? k.categories = k.premadeCategories
        : k.categories = value);
  }
  ////////////////////////////////

/////////////////USER/////////////
  Stream<User> watchUser() {
    return (select(users)).watchSingle();
  }

  Future<User> getUser() async {
    var _users = await select(users).get();
    return _users.first;
  }

  Future insertUser(UsersCompanion user) => into(users).insert(user);
  Future updateUser(User user) => update(users).replace(user);
  Future deleteUser(User user) => delete(users).delete(user);
  Future<int> count() => (select(users).get()).then((value) => value.length);

  Future<void> changeDoneTasks(int x) async {
    var _user = await select(users).getSingle();
    var temp1 = _user.completedTasks + x;
    // ignore: unawaited_futures
    update(users).replace(_user.copyWith(completedTasks: temp1));
  }

  Future<void> changePendingTasks(int x) async {
    var _user = await select(users).getSingle();
    var temp2 = _user.pendingTasks + x;
    await update(users).replace(_user.copyWith(pendingTasks: temp2));
  }

  void inscreaseScore(int amount) async {
    var user = await getUser();
    await updateUser(user.copyWith(score: user.score + amount));
  }
///////////////////////////////////////////

///////////////PAST TASKS///////////////
  Future insertPastTask() => into(pastTasks)
      .insert(PastTasksCompanion(dateFinished: Value(DateTime.now())));

  Stream<List<PastTask>> getPastTasks() => select(pastTasks).watch();
////////////////////////////////////////

//////QUOTES///////////////
  Stream<List<Quote>> watchQuotes() => select(quotes).watch();
  Future<List<Quote>> getQuotes() => select(quotes).get();
  Quote getRandomQuote() {
    return k.quotes[Random().nextInt(k.quotes.length)];
  }

  Future<void> initQuotes() async {
    await getQuotes().then((value) {
      if (value.isEmpty) {
        k.quotes = k.premadeQuotes;
        k.quotes.forEach((element) => insertQuote(element.toCompanion(true)));
      } else {
        k.quotes = value;
      }
    });
  }

  Future<Quote> getQuoteById(int id) =>
      (select(quotes)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future insertQuote(QuotesCompanion q) async {
    await into(quotes).insert(q);
    await refreshQuotes();
  }

  Future<void> refreshQuotes() async {
    await getQuotes().then((value) {
      k.quotes = value;
    });
  }

  Future updateQuote(QuotesCompanion q) => update(quotes).replace(q);
  Future deleteQuote(Quote q) => delete(quotes).delete(q);

///////////////////////
}

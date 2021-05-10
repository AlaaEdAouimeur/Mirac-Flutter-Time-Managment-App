// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final int category;
  final String note;
  final int? color;
  final int? icon;
  final DateTime dueDate;
  Task(
      {required this.id,
      required this.title,
      required this.category,
      required this.note,
      this.color,
      this.icon,
      required this.dueDate});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      category:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      icon: intType.mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<int>(category);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int?>(color);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<int?>(icon);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      note: Value(note),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      dueDate: Value(dueDate),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<int>(json['category']),
      note: serializer.fromJson<String>(json['note']),
      color: serializer.fromJson<int?>(json['color']),
      icon: serializer.fromJson<int?>(json['icon']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<int>(category),
      'note': serializer.toJson<String>(note),
      'color': serializer.toJson<int?>(color),
      'icon': serializer.toJson<int?>(icon),
      'dueDate': serializer.toJson<DateTime>(dueDate),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          int? category,
          String? note,
          int? color,
          int? icon,
          DateTime? dueDate}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        note: note ?? this.note,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        dueDate: dueDate ?? this.dueDate,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              category.hashCode,
              $mrjc(
                  note.hashCode,
                  $mrjc(color.hashCode,
                      $mrjc(icon.hashCode, dueDate.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.note == this.note &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.dueDate == this.dueDate);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> category;
  final Value<String> note;
  final Value<int?> color;
  final Value<int?> icon;
  final Value<DateTime> dueDate;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.dueDate = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int category,
    required String note,
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    required DateTime dueDate,
  })   : title = Value(title),
        category = Value(category),
        note = Value(note),
        dueDate = Value(dueDate);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? category,
    Expression<String>? note,
    Expression<int?>? color,
    Expression<int?>? icon,
    Expression<DateTime>? dueDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (dueDate != null) 'due_date': dueDate,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? category,
      Value<String>? note,
      Value<int?>? color,
      Value<int?>? icon,
      Value<DateTime>? dueDate}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      note: note ?? this.note,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (color.present) {
      map['color'] = Variable<int?>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int?>(icon.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedIntColumn category = _constructCategory();
  GeneratedIntColumn _constructCategory() {
    return GeneratedIntColumn('category', $tableName, false,
        $customConstraints: 'NULL REFERENCES categories(id)');
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedTextColumn note = _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedIntColumn color = _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      true,
    );
  }

  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedIntColumn icon = _constructIcon();
  GeneratedIntColumn _constructIcon() {
    return GeneratedIntColumn(
      'icon',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  @override
  late final GeneratedDateTimeColumn dueDate = _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, category, note, color, icon, dueDate];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String content;
  final bool isDone;
  final int taskId;
  Todo(
      {required this.id,
      required this.content,
      required this.isDone,
      required this.taskId});
  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Todo(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      content: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done'])!,
      taskId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}task_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['is_done'] = Variable<bool>(isDone);
    map['task_id'] = Variable<int>(taskId);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      content: Value(content),
      isDone: Value(isDone),
      taskId: Value(taskId),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      taskId: serializer.fromJson<int>(json['taskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'isDone': serializer.toJson<bool>(isDone),
      'taskId': serializer.toJson<int>(taskId),
    };
  }

  Todo copyWith({int? id, String? content, bool? isDone, int? taskId}) => Todo(
        id: id ?? this.id,
        content: content ?? this.content,
        isDone: isDone ?? this.isDone,
        taskId: taskId ?? this.taskId,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('isDone: $isDone, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(content.hashCode, $mrjc(isDone.hashCode, taskId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.content == this.content &&
          other.isDone == this.isDone &&
          other.taskId == this.taskId);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> content;
  final Value<bool> isDone;
  final Value<int> taskId;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.isDone = const Value.absent(),
    this.taskId = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.isDone = const Value.absent(),
    required int taskId,
  })   : content = Value(content),
        taskId = Value(taskId);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<bool>? isDone,
    Expression<int>? taskId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (isDone != null) 'is_done': isDone,
      if (taskId != null) 'task_id': taskId,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<bool>? isDone,
      Value<int>? taskId}) {
    return TodosCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      taskId: taskId ?? this.taskId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('isDone: $isDone, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedTextColumn content = _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn('content', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedBoolColumn isDone = _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedIntColumn taskId = _constructTaskId();
  GeneratedIntColumn _constructTaskId() {
    return GeneratedIntColumn('task_id', $tableName, false,
        $customConstraints: 'NULL REFERENCES tasks(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, content, isDone, taskId];
  @override
  $TodosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'todos';
  @override
  final String actualTableName = 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Todo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

class Categorie extends DataClass implements Insertable<Categorie> {
  final int id;
  final int color;
  final String content;
  Categorie({required this.id, required this.color, required this.content});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Categorie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      content: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color'] = Variable<int>(color);
    map['content'] = Variable<String>(content);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      color: Value(color),
      content: Value(content),
    );
  }

  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Categorie(
      id: serializer.fromJson<int>(json['id']),
      color: serializer.fromJson<int>(json['color']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'color': serializer.toJson<int>(color),
      'content': serializer.toJson<String>(content),
    };
  }

  Categorie copyWith({int? id, int? color, String? content}) => Categorie(
        id: id ?? this.id,
        color: color ?? this.color,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(color.hashCode, content.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.id == this.id &&
          other.color == this.color &&
          other.content == this.content);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<int> id;
  final Value<int> color;
  final Value<String> content;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.content = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Categorie> custom({
    Expression<int>? id,
    Expression<int>? color,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (color != null) 'color': color,
      if (content != null) 'content': content,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id, Value<int>? color, Value<String>? content}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      color: color ?? this.color,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Categorie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedIntColumn color = _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn('color', $tableName, false,
        defaultValue: Constant(0xff));
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedTextColumn content = _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn('content', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, color, content];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Categorie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categorie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TodosTable todos = $TodosTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, todos, categories];
}

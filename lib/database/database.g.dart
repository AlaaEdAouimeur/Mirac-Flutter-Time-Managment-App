// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PastTask extends DataClass implements Insertable<PastTask> {
  final int id;
  final DateTime dateFinished;
  PastTask({required this.id, required this.dateFinished});
  factory PastTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PastTask(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      dateFinished: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_finished'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_finished'] = Variable<DateTime>(dateFinished);
    return map;
  }

  PastTasksCompanion toCompanion(bool nullToAbsent) {
    return PastTasksCompanion(
      id: Value(id),
      dateFinished: Value(dateFinished),
    );
  }

  factory PastTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PastTask(
      id: serializer.fromJson<int>(json['id']),
      dateFinished: serializer.fromJson<DateTime>(json['dateFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateFinished': serializer.toJson<DateTime>(dateFinished),
    };
  }

  PastTask copyWith({int? id, DateTime? dateFinished}) => PastTask(
        id: id ?? this.id,
        dateFinished: dateFinished ?? this.dateFinished,
      );
  @override
  String toString() {
    return (StringBuffer('PastTask(')
          ..write('id: $id, ')
          ..write('dateFinished: $dateFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, dateFinished.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PastTask &&
          other.id == this.id &&
          other.dateFinished == this.dateFinished);
}

class PastTasksCompanion extends UpdateCompanion<PastTask> {
  final Value<int> id;
  final Value<DateTime> dateFinished;
  const PastTasksCompanion({
    this.id = const Value.absent(),
    this.dateFinished = const Value.absent(),
  });
  PastTasksCompanion.insert({
    this.id = const Value.absent(),
    required DateTime dateFinished,
  }) : dateFinished = Value(dateFinished);
  static Insertable<PastTask> custom({
    Expression<int>? id,
    Expression<DateTime>? dateFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateFinished != null) 'date_finished': dateFinished,
    });
  }

  PastTasksCompanion copyWith({Value<int>? id, Value<DateTime>? dateFinished}) {
    return PastTasksCompanion(
      id: id ?? this.id,
      dateFinished: dateFinished ?? this.dateFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateFinished.present) {
      map['date_finished'] = Variable<DateTime>(dateFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastTasksCompanion(')
          ..write('id: $id, ')
          ..write('dateFinished: $dateFinished')
          ..write(')'))
        .toString();
  }
}

class $PastTasksTable extends PastTasks
    with TableInfo<$PastTasksTable, PastTask> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PastTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateFinishedMeta =
      const VerificationMeta('dateFinished');
  @override
  late final GeneratedDateTimeColumn dateFinished = _constructDateFinished();
  GeneratedDateTimeColumn _constructDateFinished() {
    return GeneratedDateTimeColumn(
      'date_finished',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, dateFinished];
  @override
  $PastTasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'past_tasks';
  @override
  final String actualTableName = 'past_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<PastTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_finished')) {
      context.handle(
          _dateFinishedMeta,
          dateFinished.isAcceptableOrUnknown(
              data['date_finished']!, _dateFinishedMeta));
    } else if (isInserting) {
      context.missing(_dateFinishedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PastTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PastTask.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PastTasksTable createAlias(String alias) {
    return $PastTasksTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final int score;
  final String firstName;
  final String lastName;
  final int completedTasks;
  final int pendingTasks;
  User(
      {required this.id,
      required this.score,
      required this.firstName,
      required this.lastName,
      required this.completedTasks,
      required this.pendingTasks});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      score: intType.mapFromDatabaseResponse(data['${effectivePrefix}score'])!,
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      completedTasks: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_tasks'])!,
      pendingTasks: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}pending_tasks'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['completed_tasks'] = Variable<int>(completedTasks);
    map['pending_tasks'] = Variable<int>(pendingTasks);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      score: Value(score),
      firstName: Value(firstName),
      lastName: Value(lastName),
      completedTasks: Value(completedTasks),
      pendingTasks: Value(pendingTasks),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      completedTasks: serializer.fromJson<int>(json['completedTasks']),
      pendingTasks: serializer.fromJson<int>(json['pendingTasks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'completedTasks': serializer.toJson<int>(completedTasks),
      'pendingTasks': serializer.toJson<int>(pendingTasks),
    };
  }

  User copyWith(
          {int? id,
          int? score,
          String? firstName,
          String? lastName,
          int? completedTasks,
          int? pendingTasks}) =>
      User(
        id: id ?? this.id,
        score: score ?? this.score,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        completedTasks: completedTasks ?? this.completedTasks,
        pendingTasks: pendingTasks ?? this.pendingTasks,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('pendingTasks: $pendingTasks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          score.hashCode,
          $mrjc(
              firstName.hashCode,
              $mrjc(lastName.hashCode,
                  $mrjc(completedTasks.hashCode, pendingTasks.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.score == this.score &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.completedTasks == this.completedTasks &&
          other.pendingTasks == this.pendingTasks);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<int> score;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int> completedTasks;
  final Value<int> pendingTasks;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.completedTasks = const Value.absent(),
    this.pendingTasks = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    required String firstName,
    required String lastName,
    this.completedTasks = const Value.absent(),
    this.pendingTasks = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? completedTasks,
    Expression<int>? pendingTasks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (completedTasks != null) 'completed_tasks': completedTasks,
      if (pendingTasks != null) 'pending_tasks': pendingTasks,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<int>? score,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<int>? completedTasks,
      Value<int>? pendingTasks}) {
    return UsersCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      completedTasks: completedTasks ?? this.completedTasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (completedTasks.present) {
      map['completed_tasks'] = Variable<int>(completedTasks.value);
    }
    if (pendingTasks.present) {
      map['pending_tasks'] = Variable<int>(pendingTasks.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('pendingTasks: $pendingTasks')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedIntColumn score = _constructScore();
  GeneratedIntColumn _constructScore() {
    return GeneratedIntColumn('score', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedTextColumn firstName = _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn('first_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedTextColumn lastName = _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn('last_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _completedTasksMeta =
      const VerificationMeta('completedTasks');
  @override
  late final GeneratedIntColumn completedTasks = _constructCompletedTasks();
  GeneratedIntColumn _constructCompletedTasks() {
    return GeneratedIntColumn('completed_tasks', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _pendingTasksMeta =
      const VerificationMeta('pendingTasks');
  @override
  late final GeneratedIntColumn pendingTasks = _constructPendingTasks();
  GeneratedIntColumn _constructPendingTasks() {
    return GeneratedIntColumn('pending_tasks', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, score, firstName, lastName, completedTasks, pendingTasks];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('completed_tasks')) {
      context.handle(
          _completedTasksMeta,
          completedTasks.isAcceptableOrUnknown(
              data['completed_tasks']!, _completedTasksMeta));
    }
    if (data.containsKey('pending_tasks')) {
      context.handle(
          _pendingTasksMeta,
          pendingTasks.isAcceptableOrUnknown(
              data['pending_tasks']!, _pendingTasksMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final int category;
  final String note;
  final bool isDone;
  final bool isChallenge;
  final int? score;
  final int? completedTasks;
  final DateTime dueDate;
  final DateTime? reminderDate;
  Task(
      {required this.id,
      required this.title,
      required this.category,
      required this.note,
      required this.isDone,
      required this.isChallenge,
      this.score,
      this.completedTasks,
      required this.dueDate,
      this.reminderDate});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      category:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done'])!,
      isChallenge: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_challenge'])!,
      score: intType.mapFromDatabaseResponse(data['${effectivePrefix}score']),
      completedTasks: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_tasks']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date'])!,
      reminderDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}reminder_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<int>(category);
    map['note'] = Variable<String>(note);
    map['is_done'] = Variable<bool>(isDone);
    map['is_challenge'] = Variable<bool>(isChallenge);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<int?>(score);
    }
    if (!nullToAbsent || completedTasks != null) {
      map['completed_tasks'] = Variable<int?>(completedTasks);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || reminderDate != null) {
      map['reminder_date'] = Variable<DateTime?>(reminderDate);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      note: Value(note),
      isDone: Value(isDone),
      isChallenge: Value(isChallenge),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      completedTasks: completedTasks == null && nullToAbsent
          ? const Value.absent()
          : Value(completedTasks),
      dueDate: Value(dueDate),
      reminderDate: reminderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDate),
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
      isDone: serializer.fromJson<bool>(json['isDone']),
      isChallenge: serializer.fromJson<bool>(json['isChallenge']),
      score: serializer.fromJson<int?>(json['score']),
      completedTasks: serializer.fromJson<int?>(json['completedTasks']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      reminderDate: serializer.fromJson<DateTime?>(json['reminderDate']),
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
      'isDone': serializer.toJson<bool>(isDone),
      'isChallenge': serializer.toJson<bool>(isChallenge),
      'score': serializer.toJson<int?>(score),
      'completedTasks': serializer.toJson<int?>(completedTasks),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'reminderDate': serializer.toJson<DateTime?>(reminderDate),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          int? category,
          String? note,
          bool? isDone,
          bool? isChallenge,
          int? score,
          int? completedTasks,
          DateTime? dueDate,
          DateTime? reminderDate}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        note: note ?? this.note,
        isDone: isDone ?? this.isDone,
        isChallenge: isChallenge ?? this.isChallenge,
        score: score ?? this.score,
        completedTasks: completedTasks ?? this.completedTasks,
        dueDate: dueDate ?? this.dueDate,
        reminderDate: reminderDate ?? this.reminderDate,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('isDone: $isDone, ')
          ..write('isChallenge: $isChallenge, ')
          ..write('score: $score, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderDate: $reminderDate')
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
                  $mrjc(
                      isDone.hashCode,
                      $mrjc(
                          isChallenge.hashCode,
                          $mrjc(
                              score.hashCode,
                              $mrjc(
                                  completedTasks.hashCode,
                                  $mrjc(dueDate.hashCode,
                                      reminderDate.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.note == this.note &&
          other.isDone == this.isDone &&
          other.isChallenge == this.isChallenge &&
          other.score == this.score &&
          other.completedTasks == this.completedTasks &&
          other.dueDate == this.dueDate &&
          other.reminderDate == this.reminderDate);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> category;
  final Value<String> note;
  final Value<bool> isDone;
  final Value<bool> isChallenge;
  final Value<int?> score;
  final Value<int?> completedTasks;
  final Value<DateTime> dueDate;
  final Value<DateTime?> reminderDate;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isChallenge = const Value.absent(),
    this.score = const Value.absent(),
    this.completedTasks = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.reminderDate = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int category,
    required String note,
    this.isDone = const Value.absent(),
    this.isChallenge = const Value.absent(),
    this.score = const Value.absent(),
    this.completedTasks = const Value.absent(),
    required DateTime dueDate,
    this.reminderDate = const Value.absent(),
  })  : title = Value(title),
        category = Value(category),
        note = Value(note),
        dueDate = Value(dueDate);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? category,
    Expression<String>? note,
    Expression<bool>? isDone,
    Expression<bool>? isChallenge,
    Expression<int?>? score,
    Expression<int?>? completedTasks,
    Expression<DateTime>? dueDate,
    Expression<DateTime?>? reminderDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (isDone != null) 'is_done': isDone,
      if (isChallenge != null) 'is_challenge': isChallenge,
      if (score != null) 'score': score,
      if (completedTasks != null) 'completed_tasks': completedTasks,
      if (dueDate != null) 'due_date': dueDate,
      if (reminderDate != null) 'reminder_date': reminderDate,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? category,
      Value<String>? note,
      Value<bool>? isDone,
      Value<bool>? isChallenge,
      Value<int?>? score,
      Value<int?>? completedTasks,
      Value<DateTime>? dueDate,
      Value<DateTime?>? reminderDate}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
      isChallenge: isChallenge ?? this.isChallenge,
      score: score ?? this.score,
      completedTasks: completedTasks ?? this.completedTasks,
      dueDate: dueDate ?? this.dueDate,
      reminderDate: reminderDate ?? this.reminderDate,
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
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (isChallenge.present) {
      map['is_challenge'] = Variable<bool>(isChallenge.value);
    }
    if (score.present) {
      map['score'] = Variable<int?>(score.value);
    }
    if (completedTasks.present) {
      map['completed_tasks'] = Variable<int?>(completedTasks.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (reminderDate.present) {
      map['reminder_date'] = Variable<DateTime?>(reminderDate.value);
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
          ..write('isDone: $isDone, ')
          ..write('isChallenge: $isChallenge, ')
          ..write('score: $score, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderDate: $reminderDate')
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

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedBoolColumn isDone = _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isChallengeMeta =
      const VerificationMeta('isChallenge');
  @override
  late final GeneratedBoolColumn isChallenge = _constructIsChallenge();
  GeneratedBoolColumn _constructIsChallenge() {
    return GeneratedBoolColumn('is_challenge', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedIntColumn score = _constructScore();
  GeneratedIntColumn _constructScore() {
    return GeneratedIntColumn(
      'score',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedTasksMeta =
      const VerificationMeta('completedTasks');
  @override
  late final GeneratedIntColumn completedTasks = _constructCompletedTasks();
  GeneratedIntColumn _constructCompletedTasks() {
    return GeneratedIntColumn(
      'completed_tasks',
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

  final VerificationMeta _reminderDateMeta =
      const VerificationMeta('reminderDate');
  @override
  late final GeneratedDateTimeColumn reminderDate = _constructReminderDate();
  GeneratedDateTimeColumn _constructReminderDate() {
    return GeneratedDateTimeColumn(
      'reminder_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        category,
        note,
        isDone,
        isChallenge,
        score,
        completedTasks,
        dueDate,
        reminderDate
      ];
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
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('is_challenge')) {
      context.handle(
          _isChallengeMeta,
          isChallenge.isAcceptableOrUnknown(
              data['is_challenge']!, _isChallengeMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('completed_tasks')) {
      context.handle(
          _completedTasksMeta,
          completedTasks.isAcceptableOrUnknown(
              data['completed_tasks']!, _completedTasksMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('reminder_date')) {
      context.handle(
          _reminderDateMeta,
          reminderDate.isAcceptableOrUnknown(
              data['reminder_date']!, _reminderDateMeta));
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
        minTextLength: 0, maxTextLength: 50);
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
  final int iconData;
  final String content;
  Categorie(
      {required this.id,
      required this.color,
      required this.iconData,
      required this.content});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Categorie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      iconData:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}icon_data'])!,
      content: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color'] = Variable<int>(color);
    map['icon_data'] = Variable<int>(iconData);
    map['content'] = Variable<String>(content);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      color: Value(color),
      iconData: Value(iconData),
      content: Value(content),
    );
  }

  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Categorie(
      id: serializer.fromJson<int>(json['id']),
      color: serializer.fromJson<int>(json['color']),
      iconData: serializer.fromJson<int>(json['iconData']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'color': serializer.toJson<int>(color),
      'iconData': serializer.toJson<int>(iconData),
      'content': serializer.toJson<String>(content),
    };
  }

  Categorie copyWith({int? id, int? color, int? iconData, String? content}) =>
      Categorie(
        id: id ?? this.id,
        color: color ?? this.color,
        iconData: iconData ?? this.iconData,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('iconData: $iconData, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(color.hashCode, $mrjc(iconData.hashCode, content.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.id == this.id &&
          other.color == this.color &&
          other.iconData == this.iconData &&
          other.content == this.content);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<int> id;
  final Value<int> color;
  final Value<int> iconData;
  final Value<String> content;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.iconData = const Value.absent(),
    this.content = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.iconData = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Categorie> custom({
    Expression<int>? id,
    Expression<int>? color,
    Expression<int>? iconData,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (color != null) 'color': color,
      if (iconData != null) 'icon_data': iconData,
      if (content != null) 'content': content,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? color,
      Value<int>? iconData,
      Value<String>? content}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      color: color ?? this.color,
      iconData: iconData ?? this.iconData,
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
    if (iconData.present) {
      map['icon_data'] = Variable<int>(iconData.value);
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
          ..write('iconData: $iconData, ')
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

  final VerificationMeta _iconDataMeta = const VerificationMeta('iconData');
  @override
  late final GeneratedIntColumn iconData = _constructIconData();
  GeneratedIntColumn _constructIconData() {
    return GeneratedIntColumn('icon_data', $tableName, false,
        defaultValue: Constant(0xff));
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedTextColumn content = _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn('content', $tableName, false,
        minTextLength: 2, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, color, iconData, content];
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
    if (data.containsKey('icon_data')) {
      context.handle(_iconDataMeta,
          iconData.isAcceptableOrUnknown(data['icon_data']!, _iconDataMeta));
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
  late final $PastTasksTable pastTasks = $PastTasksTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TodosTable todos = $TodosTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pastTasks, users, tasks, todos, categories];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, color, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final int id;
  final String title;
  final int color;
  final int priority;
  const CategoriesTableData({
    required this.id,
    required this.title,
    required this.color,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['color'] = Variable<int>(color);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      title: Value(title),
      color: Value(color),
      priority: Value(priority),
    );
  }

  factory CategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int>(json['color']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int>(color),
      'priority': serializer.toJson<int>(priority),
    };
  }

  CategoriesTableData copyWith({
    int? id,
    String? title,
    int? color,
    int? priority,
  }) => CategoriesTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    color: color ?? this.color,
    priority: priority ?? this.priority,
  );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      color: data.color.present ? data.color.value : this.color,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, color, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.priority == this.priority);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> color;
  final Value<int> priority;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.priority = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int color,
    this.priority = const Value.absent(),
  }) : title = Value(title),
       color = Value(color);
  static Insertable<CategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? color,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (priority != null) 'priority': priority,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? color,
    Value<int>? priority,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      priority: priority ?? this.priority,
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
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTitleMeta = const VerificationMeta(
    'subTitle',
  );
  @override
  late final GeneratedColumn<String> subTitle = GeneratedColumn<String>(
    'sub_title',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateInitMeta = const VerificationMeta(
    'dateInit',
  );
  @override
  late final GeneratedColumn<DateTime> dateInit = GeneratedColumn<DateTime>(
    'date_init',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFinishMeta = const VerificationMeta(
    'dateFinish',
  );
  @override
  late final GeneratedColumn<DateTime> dateFinish = GeneratedColumn<DateTime>(
    'date_finish',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAllDayMeta = const VerificationMeta(
    'isAllDay',
  );
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
    'is_all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fkCategoryIDMeta = const VerificationMeta(
    'fkCategoryID',
  );
  @override
  late final GeneratedColumn<int> fkCategoryID = GeneratedColumn<int>(
    'fk_category_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    subTitle,
    description,
    dateInit,
    dateFinish,
    isAllDay,
    isDone,
    color,
    fkCategoryID,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sub_title')) {
      context.handle(
        _subTitleMeta,
        subTitle.isAcceptableOrUnknown(data['sub_title']!, _subTitleMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('date_init')) {
      context.handle(
        _dateInitMeta,
        dateInit.isAcceptableOrUnknown(data['date_init']!, _dateInitMeta),
      );
    } else if (isInserting) {
      context.missing(_dateInitMeta);
    }
    if (data.containsKey('date_finish')) {
      context.handle(
        _dateFinishMeta,
        dateFinish.isAcceptableOrUnknown(data['date_finish']!, _dateFinishMeta),
      );
    } else if (isInserting) {
      context.missing(_dateFinishMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('fk_category_i_d')) {
      context.handle(
        _fkCategoryIDMeta,
        fkCategoryID.isAcceptableOrUnknown(
          data['fk_category_i_d']!,
          _fkCategoryIDMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      subTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_title'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      dateInit: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_init'],
      )!,
      dateFinish: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_finish'],
      )!,
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      ),
      fkCategoryID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fk_category_i_d'],
      ),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String title;
  final String? subTitle;
  final String? description;
  final DateTime dateInit;
  final DateTime dateFinish;
  final bool isAllDay;
  final bool isDone;
  final int? color;
  final int? fkCategoryID;
  const Event({
    required this.id,
    required this.title,
    this.subTitle,
    this.description,
    required this.dateInit,
    required this.dateFinish,
    required this.isAllDay,
    required this.isDone,
    this.color,
    this.fkCategoryID,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subTitle != null) {
      map['sub_title'] = Variable<String>(subTitle);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['date_init'] = Variable<DateTime>(dateInit);
    map['date_finish'] = Variable<DateTime>(dateFinish);
    map['is_all_day'] = Variable<bool>(isAllDay);
    map['is_done'] = Variable<bool>(isDone);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    if (!nullToAbsent || fkCategoryID != null) {
      map['fk_category_i_d'] = Variable<int>(fkCategoryID);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      title: Value(title),
      subTitle: subTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subTitle),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dateInit: Value(dateInit),
      dateFinish: Value(dateFinish),
      isAllDay: Value(isAllDay),
      isDone: Value(isDone),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      fkCategoryID: fkCategoryID == null && nullToAbsent
          ? const Value.absent()
          : Value(fkCategoryID),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subTitle: serializer.fromJson<String?>(json['subTitle']),
      description: serializer.fromJson<String?>(json['description']),
      dateInit: serializer.fromJson<DateTime>(json['dateInit']),
      dateFinish: serializer.fromJson<DateTime>(json['dateFinish']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      color: serializer.fromJson<int?>(json['color']),
      fkCategoryID: serializer.fromJson<int?>(json['fkCategoryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'subTitle': serializer.toJson<String?>(subTitle),
      'description': serializer.toJson<String?>(description),
      'dateInit': serializer.toJson<DateTime>(dateInit),
      'dateFinish': serializer.toJson<DateTime>(dateFinish),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'isDone': serializer.toJson<bool>(isDone),
      'color': serializer.toJson<int?>(color),
      'fkCategoryID': serializer.toJson<int?>(fkCategoryID),
    };
  }

  Event copyWith({
    int? id,
    String? title,
    Value<String?> subTitle = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? dateInit,
    DateTime? dateFinish,
    bool? isAllDay,
    bool? isDone,
    Value<int?> color = const Value.absent(),
    Value<int?> fkCategoryID = const Value.absent(),
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    subTitle: subTitle.present ? subTitle.value : this.subTitle,
    description: description.present ? description.value : this.description,
    dateInit: dateInit ?? this.dateInit,
    dateFinish: dateFinish ?? this.dateFinish,
    isAllDay: isAllDay ?? this.isAllDay,
    isDone: isDone ?? this.isDone,
    color: color.present ? color.value : this.color,
    fkCategoryID: fkCategoryID.present ? fkCategoryID.value : this.fkCategoryID,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subTitle: data.subTitle.present ? data.subTitle.value : this.subTitle,
      description: data.description.present
          ? data.description.value
          : this.description,
      dateInit: data.dateInit.present ? data.dateInit.value : this.dateInit,
      dateFinish: data.dateFinish.present
          ? data.dateFinish.value
          : this.dateFinish,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      color: data.color.present ? data.color.value : this.color,
      fkCategoryID: data.fkCategoryID.present
          ? data.fkCategoryID.value
          : this.fkCategoryID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('description: $description, ')
          ..write('dateInit: $dateInit, ')
          ..write('dateFinish: $dateFinish, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('isDone: $isDone, ')
          ..write('color: $color, ')
          ..write('fkCategoryID: $fkCategoryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    subTitle,
    description,
    dateInit,
    dateFinish,
    isAllDay,
    isDone,
    color,
    fkCategoryID,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.subTitle == this.subTitle &&
          other.description == this.description &&
          other.dateInit == this.dateInit &&
          other.dateFinish == this.dateFinish &&
          other.isAllDay == this.isAllDay &&
          other.isDone == this.isDone &&
          other.color == this.color &&
          other.fkCategoryID == this.fkCategoryID);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> subTitle;
  final Value<String?> description;
  final Value<DateTime> dateInit;
  final Value<DateTime> dateFinish;
  final Value<bool> isAllDay;
  final Value<bool> isDone;
  final Value<int?> color;
  final Value<int?> fkCategoryID;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.dateInit = const Value.absent(),
    this.dateFinish = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.isDone = const Value.absent(),
    this.color = const Value.absent(),
    this.fkCategoryID = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.subTitle = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime dateInit,
    required DateTime dateFinish,
    this.isAllDay = const Value.absent(),
    this.isDone = const Value.absent(),
    this.color = const Value.absent(),
    this.fkCategoryID = const Value.absent(),
  }) : title = Value(title),
       dateInit = Value(dateInit),
       dateFinish = Value(dateFinish);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? subTitle,
    Expression<String>? description,
    Expression<DateTime>? dateInit,
    Expression<DateTime>? dateFinish,
    Expression<bool>? isAllDay,
    Expression<bool>? isDone,
    Expression<int>? color,
    Expression<int>? fkCategoryID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subTitle != null) 'sub_title': subTitle,
      if (description != null) 'description': description,
      if (dateInit != null) 'date_init': dateInit,
      if (dateFinish != null) 'date_finish': dateFinish,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (isDone != null) 'is_done': isDone,
      if (color != null) 'color': color,
      if (fkCategoryID != null) 'fk_category_i_d': fkCategoryID,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? subTitle,
    Value<String?>? description,
    Value<DateTime>? dateInit,
    Value<DateTime>? dateFinish,
    Value<bool>? isAllDay,
    Value<bool>? isDone,
    Value<int?>? color,
    Value<int?>? fkCategoryID,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      dateInit: dateInit ?? this.dateInit,
      dateFinish: dateFinish ?? this.dateFinish,
      isAllDay: isAllDay ?? this.isAllDay,
      isDone: isDone ?? this.isDone,
      color: color ?? this.color,
      fkCategoryID: fkCategoryID ?? this.fkCategoryID,
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
    if (subTitle.present) {
      map['sub_title'] = Variable<String>(subTitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dateInit.present) {
      map['date_init'] = Variable<DateTime>(dateInit.value);
    }
    if (dateFinish.present) {
      map['date_finish'] = Variable<DateTime>(dateFinish.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (fkCategoryID.present) {
      map['fk_category_i_d'] = Variable<int>(fkCategoryID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('description: $description, ')
          ..write('dateInit: $dateInit, ')
          ..write('dateFinish: $dateFinish, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('isDone: $isDone, ')
          ..write('color: $color, ')
          ..write('fkCategoryID: $fkCategoryID')
          ..write(')'))
        .toString();
  }
}

class $NotificationTableTable extends NotificationTable
    with TableInfo<$NotificationTableTable, NotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scheduleDateMeta = const VerificationMeta(
    'scheduleDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduleDate = GeneratedColumn<DateTime>(
    'schedule_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventId, scheduleDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('schedule_date')) {
      context.handle(
        _scheduleDateMeta,
        scheduleDate.isAcceptableOrUnknown(
          data['schedule_date']!,
          _scheduleDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      scheduleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}schedule_date'],
      )!,
    );
  }

  @override
  $NotificationTableTable createAlias(String alias) {
    return $NotificationTableTable(attachedDatabase, alias);
  }
}

class NotificationTableData extends DataClass
    implements Insertable<NotificationTableData> {
  final int id;
  final int eventId;
  final DateTime scheduleDate;
  const NotificationTableData({
    required this.id,
    required this.eventId,
    required this.scheduleDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['schedule_date'] = Variable<DateTime>(scheduleDate);
    return map;
  }

  NotificationTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      scheduleDate: Value(scheduleDate),
    );
  }

  factory NotificationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      scheduleDate: serializer.fromJson<DateTime>(json['scheduleDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'scheduleDate': serializer.toJson<DateTime>(scheduleDate),
    };
  }

  NotificationTableData copyWith({
    int? id,
    int? eventId,
    DateTime? scheduleDate,
  }) => NotificationTableData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    scheduleDate: scheduleDate ?? this.scheduleDate,
  );
  NotificationTableData copyWithCompanion(NotificationTableCompanion data) {
    return NotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      scheduleDate: data.scheduleDate.present
          ? data.scheduleDate.value
          : this.scheduleDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('scheduleDate: $scheduleDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, scheduleDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.scheduleDate == this.scheduleDate);
}

class NotificationTableCompanion
    extends UpdateCompanion<NotificationTableData> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<DateTime> scheduleDate;
  const NotificationTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.scheduleDate = const Value.absent(),
  });
  NotificationTableCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required DateTime scheduleDate,
  }) : eventId = Value(eventId),
       scheduleDate = Value(scheduleDate);
  static Insertable<NotificationTableData> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<DateTime>? scheduleDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (scheduleDate != null) 'schedule_date': scheduleDate,
    });
  }

  NotificationTableCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<DateTime>? scheduleDate,
  }) {
    return NotificationTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      scheduleDate: scheduleDate ?? this.scheduleDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (scheduleDate.present) {
      map['schedule_date'] = Variable<DateTime>(scheduleDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('scheduleDate: $scheduleDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $EventsTable events = $EventsTable(this);
  late final $NotificationTableTable notificationTable =
      $NotificationTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesTable,
    events,
    notificationTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notification_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      required String title,
      required int color,
      Value<int> priority,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> color,
      Value<int> priority,
    });

final class $$CategoriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData
        > {
  $$CategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: $_aliasNameGenerator(
      db.categoriesTable.id,
      db.events.fkCategoryID,
    ),
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.fkCategoryID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.fkCategoryID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.fkCategoryID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (CategoriesTableData, $$CategoriesTableTableReferences),
          CategoriesTableData,
          PrefetchHooks Function({bool eventsRefs})
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                title: title,
                color: color,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int color,
                Value<int> priority = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                title: title,
                color: color,
                priority: priority,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (eventsRefs) db.events],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsRefs)
                    await $_getPrefetchedData<
                      CategoriesTableData,
                      $CategoriesTableTable,
                      Event
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableTableReferences
                          ._eventsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).eventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.fkCategoryID == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (CategoriesTableData, $$CategoriesTableTableReferences),
      CategoriesTableData,
      PrefetchHooks Function({bool eventsRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> subTitle,
      Value<String?> description,
      required DateTime dateInit,
      required DateTime dateFinish,
      Value<bool> isAllDay,
      Value<bool> isDone,
      Value<int?> color,
      Value<int?> fkCategoryID,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> subTitle,
      Value<String?> description,
      Value<DateTime> dateInit,
      Value<DateTime> dateFinish,
      Value<bool> isAllDay,
      Value<bool> isDone,
      Value<int?> color,
      Value<int?> fkCategoryID,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _fkCategoryIDTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(db.events.fkCategoryID, db.categoriesTable.id),
      );

  $$CategoriesTableTableProcessedTableManager? get fkCategoryID {
    final $_column = $_itemColumn<int>('fk_category_i_d');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fkCategoryIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $NotificationTableTable,
    List<NotificationTableData>
  >
  _notificationTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.notificationTable,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.notificationTable.eventId,
        ),
      );

  $$NotificationTableTableProcessedTableManager get notificationTableRefs {
    final manager = $$NotificationTableTableTableManager(
      $_db,
      $_db.notificationTable,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _notificationTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subTitle => $composableBuilder(
    column: $table.subTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateInit => $composableBuilder(
    column: $table.dateInit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFinish => $composableBuilder(
    column: $table.dateFinish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableTableFilterComposer get fkCategoryID {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fkCategoryID,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> notificationTableRefs(
    Expression<bool> Function($$NotificationTableTableFilterComposer f) f,
  ) {
    final $$NotificationTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notificationTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationTableTableFilterComposer(
            $db: $db,
            $table: $db.notificationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subTitle => $composableBuilder(
    column: $table.subTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateInit => $composableBuilder(
    column: $table.dateInit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFinish => $composableBuilder(
    column: $table.dateFinish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableTableOrderingComposer get fkCategoryID {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fkCategoryID,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subTitle =>
      $composableBuilder(column: $table.subTitle, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateInit =>
      $composableBuilder(column: $table.dateInit, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFinish => $composableBuilder(
    column: $table.dateFinish,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get fkCategoryID {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fkCategoryID,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> notificationTableRefs<T extends Object>(
    Expression<T> Function($$NotificationTableTableAnnotationComposer a) f,
  ) {
    final $$NotificationTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.notificationTable,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NotificationTableTableAnnotationComposer(
                $db: $db,
                $table: $db.notificationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, $$EventsTableReferences),
          Event,
          PrefetchHooks Function({
            bool fkCategoryID,
            bool notificationTableRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> subTitle = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> dateInit = const Value.absent(),
                Value<DateTime> dateFinish = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int?> color = const Value.absent(),
                Value<int?> fkCategoryID = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                title: title,
                subTitle: subTitle,
                description: description,
                dateInit: dateInit,
                dateFinish: dateFinish,
                isAllDay: isAllDay,
                isDone: isDone,
                color: color,
                fkCategoryID: fkCategoryID,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> subTitle = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime dateInit,
                required DateTime dateFinish,
                Value<bool> isAllDay = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int?> color = const Value.absent(),
                Value<int?> fkCategoryID = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                subTitle: subTitle,
                description: description,
                dateInit: dateInit,
                dateFinish: dateFinish,
                isAllDay: isAllDay,
                isDone: isDone,
                color: color,
                fkCategoryID: fkCategoryID,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({fkCategoryID = false, notificationTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (notificationTableRefs) db.notificationTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fkCategoryID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fkCategoryID,
                                    referencedTable: $$EventsTableReferences
                                        ._fkCategoryIDTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._fkCategoryIDTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (notificationTableRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          NotificationTableData
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._notificationTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).notificationTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, $$EventsTableReferences),
      Event,
      PrefetchHooks Function({bool fkCategoryID, bool notificationTableRefs})
    >;
typedef $$NotificationTableTableCreateCompanionBuilder =
    NotificationTableCompanion Function({
      Value<int> id,
      required int eventId,
      required DateTime scheduleDate,
    });
typedef $$NotificationTableTableUpdateCompanionBuilder =
    NotificationTableCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<DateTime> scheduleDate,
    });

final class $$NotificationTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NotificationTableTable,
          NotificationTableData
        > {
  $$NotificationTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.notificationTable.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotificationTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationTableTable> {
  $$NotificationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationTableTable> {
  $$NotificationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationTableTable> {
  $$NotificationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationTableTable,
          NotificationTableData,
          $$NotificationTableTableFilterComposer,
          $$NotificationTableTableOrderingComposer,
          $$NotificationTableTableAnnotationComposer,
          $$NotificationTableTableCreateCompanionBuilder,
          $$NotificationTableTableUpdateCompanionBuilder,
          (NotificationTableData, $$NotificationTableTableReferences),
          NotificationTableData,
          PrefetchHooks Function({bool eventId})
        > {
  $$NotificationTableTableTableManager(
    _$AppDatabase db,
    $NotificationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<DateTime> scheduleDate = const Value.absent(),
              }) => NotificationTableCompanion(
                id: id,
                eventId: eventId,
                scheduleDate: scheduleDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required DateTime scheduleDate,
              }) => NotificationTableCompanion.insert(
                id: id,
                eventId: eventId,
                scheduleDate: scheduleDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NotificationTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$NotificationTableTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$NotificationTableTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotificationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationTableTable,
      NotificationTableData,
      $$NotificationTableTableFilterComposer,
      $$NotificationTableTableOrderingComposer,
      $$NotificationTableTableAnnotationComposer,
      $$NotificationTableTableCreateCompanionBuilder,
      $$NotificationTableTableUpdateCompanionBuilder,
      (NotificationTableData, $$NotificationTableTableReferences),
      NotificationTableData,
      PrefetchHooks Function({bool eventId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$NotificationTableTableTableManager get notificationTable =>
      $$NotificationTableTableTableManager(_db, _db.notificationTable);
}

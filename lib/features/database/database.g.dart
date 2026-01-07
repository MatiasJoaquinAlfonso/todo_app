// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    color,
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
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
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
      ),
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
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
  final DateTime? dateFinish;
  final bool isAllDay;
  final int? color;
  const Event({
    required this.id,
    required this.title,
    this.subTitle,
    this.description,
    required this.dateInit,
    this.dateFinish,
    required this.isAllDay,
    this.color,
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
    if (!nullToAbsent || dateFinish != null) {
      map['date_finish'] = Variable<DateTime>(dateFinish);
    }
    map['is_all_day'] = Variable<bool>(isAllDay);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
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
      dateFinish: dateFinish == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFinish),
      isAllDay: Value(isAllDay),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
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
      dateFinish: serializer.fromJson<DateTime?>(json['dateFinish']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      color: serializer.fromJson<int?>(json['color']),
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
      'dateFinish': serializer.toJson<DateTime?>(dateFinish),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'color': serializer.toJson<int?>(color),
    };
  }

  Event copyWith({
    int? id,
    String? title,
    Value<String?> subTitle = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? dateInit,
    Value<DateTime?> dateFinish = const Value.absent(),
    bool? isAllDay,
    Value<int?> color = const Value.absent(),
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    subTitle: subTitle.present ? subTitle.value : this.subTitle,
    description: description.present ? description.value : this.description,
    dateInit: dateInit ?? this.dateInit,
    dateFinish: dateFinish.present ? dateFinish.value : this.dateFinish,
    isAllDay: isAllDay ?? this.isAllDay,
    color: color.present ? color.value : this.color,
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
      color: data.color.present ? data.color.value : this.color,
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
          ..write('color: $color')
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
    color,
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
          other.color == this.color);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> subTitle;
  final Value<String?> description;
  final Value<DateTime> dateInit;
  final Value<DateTime?> dateFinish;
  final Value<bool> isAllDay;
  final Value<int?> color;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.dateInit = const Value.absent(),
    this.dateFinish = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.color = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.subTitle = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime dateInit,
    this.dateFinish = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.color = const Value.absent(),
  }) : title = Value(title),
       dateInit = Value(dateInit);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? subTitle,
    Expression<String>? description,
    Expression<DateTime>? dateInit,
    Expression<DateTime>? dateFinish,
    Expression<bool>? isAllDay,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subTitle != null) 'sub_title': subTitle,
      if (description != null) 'description': description,
      if (dateInit != null) 'date_init': dateInit,
      if (dateFinish != null) 'date_finish': dateFinish,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (color != null) 'color': color,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? subTitle,
    Value<String?>? description,
    Value<DateTime>? dateInit,
    Value<DateTime?>? dateFinish,
    Value<bool>? isAllDay,
    Value<int?>? color,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      dateInit: dateInit ?? this.dateInit,
      dateFinish: dateFinish ?? this.dateFinish,
      isAllDay: isAllDay ?? this.isAllDay,
      color: color ?? this.color,
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
    if (color.present) {
      map['color'] = Variable<int>(color.value);
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
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EventsTable events = $EventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}

typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> subTitle,
      Value<String?> description,
      required DateTime dateInit,
      Value<DateTime?> dateFinish,
      Value<bool> isAllDay,
      Value<int?> color,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> subTitle,
      Value<String?> description,
      Value<DateTime> dateInit,
      Value<DateTime?> dateFinish,
      Value<bool> isAllDay,
      Value<int?> color,
    });

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

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );
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

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);
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
          (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
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
                Value<DateTime?> dateFinish = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<int?> color = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                title: title,
                subTitle: subTitle,
                description: description,
                dateInit: dateInit,
                dateFinish: dateFinish,
                isAllDay: isAllDay,
                color: color,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> subTitle = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime dateInit,
                Value<DateTime?> dateFinish = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<int?> color = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                subTitle: subTitle,
                description: description,
                dateInit: dateInit,
                dateFinish: dateFinish,
                isAllDay: isAllDay,
                color: color,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
}

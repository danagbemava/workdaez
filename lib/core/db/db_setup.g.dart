// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_setup.dart';

// ignore_for_file: type=lint
class $WorkProfileTable extends WorkProfile
    with TableInfo<$WorkProfileTable, WorkProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _trackTimeMeta =
      const VerificationMeta('trackTime');
  @override
  late final GeneratedColumn<bool> trackTime = GeneratedColumn<bool>(
      'track_time', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("track_time" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _trackWeekendsMeta =
      const VerificationMeta('trackWeekends');
  @override
  late final GeneratedColumn<bool> trackWeekends = GeneratedColumn<bool>(
      'track_weekends', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("track_weekends" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, trackTime, trackWeekends];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_profile';
  @override
  VerificationContext validateIntegrity(Insertable<WorkProfileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_time')) {
      context.handle(_trackTimeMeta,
          trackTime.isAcceptableOrUnknown(data['track_time']!, _trackTimeMeta));
    }
    if (data.containsKey('track_weekends')) {
      context.handle(
          _trackWeekendsMeta,
          trackWeekends.isAcceptableOrUnknown(
              data['track_weekends']!, _trackWeekendsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkProfileData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      trackTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}track_time'])!,
      trackWeekends: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}track_weekends'])!,
    );
  }

  @override
  $WorkProfileTable createAlias(String alias) {
    return $WorkProfileTable(attachedDatabase, alias);
  }
}

class WorkProfileData extends DataClass implements Insertable<WorkProfileData> {
  final int id;
  final String name;
  final bool trackTime;
  final bool trackWeekends;
  const WorkProfileData(
      {required this.id,
      required this.name,
      required this.trackTime,
      required this.trackWeekends});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['track_time'] = Variable<bool>(trackTime);
    map['track_weekends'] = Variable<bool>(trackWeekends);
    return map;
  }

  WorkProfileCompanion toCompanion(bool nullToAbsent) {
    return WorkProfileCompanion(
      id: Value(id),
      name: Value(name),
      trackTime: Value(trackTime),
      trackWeekends: Value(trackWeekends),
    );
  }

  factory WorkProfileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkProfileData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      trackTime: serializer.fromJson<bool>(json['trackTime']),
      trackWeekends: serializer.fromJson<bool>(json['trackWeekends']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'trackTime': serializer.toJson<bool>(trackTime),
      'trackWeekends': serializer.toJson<bool>(trackWeekends),
    };
  }

  WorkProfileData copyWith(
          {int? id, String? name, bool? trackTime, bool? trackWeekends}) =>
      WorkProfileData(
        id: id ?? this.id,
        name: name ?? this.name,
        trackTime: trackTime ?? this.trackTime,
        trackWeekends: trackWeekends ?? this.trackWeekends,
      );
  @override
  String toString() {
    return (StringBuffer('WorkProfileData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('trackTime: $trackTime, ')
          ..write('trackWeekends: $trackWeekends')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, trackTime, trackWeekends);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkProfileData &&
          other.id == this.id &&
          other.name == this.name &&
          other.trackTime == this.trackTime &&
          other.trackWeekends == this.trackWeekends);
}

class WorkProfileCompanion extends UpdateCompanion<WorkProfileData> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> trackTime;
  final Value<bool> trackWeekends;
  const WorkProfileCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.trackTime = const Value.absent(),
    this.trackWeekends = const Value.absent(),
  });
  WorkProfileCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.trackTime = const Value.absent(),
    this.trackWeekends = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkProfileData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? trackTime,
    Expression<bool>? trackWeekends,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (trackTime != null) 'track_time': trackTime,
      if (trackWeekends != null) 'track_weekends': trackWeekends,
    });
  }

  WorkProfileCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? trackTime,
      Value<bool>? trackWeekends}) {
    return WorkProfileCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      trackTime: trackTime ?? this.trackTime,
      trackWeekends: trackWeekends ?? this.trackWeekends,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackTime.present) {
      map['track_time'] = Variable<bool>(trackTime.value);
    }
    if (trackWeekends.present) {
      map['track_weekends'] = Variable<bool>(trackWeekends.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkProfileCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('trackTime: $trackTime, ')
          ..write('trackWeekends: $trackWeekends')
          ..write(')'))
        .toString();
  }
}

class $WorkTrackerTable extends WorkTracker
    with TableInfo<$WorkTrackerTable, WorkTrackerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkTrackerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
      'day', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _didWorkMeta =
      const VerificationMeta('didWork');
  @override
  late final GeneratedColumn<bool> didWork = GeneratedColumn<bool>(
      'did_work', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("did_work" IN (0, 1))'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES work_profile (id)'));
  static const VerificationMeta _absentReasonMeta =
      const VerificationMeta('absentReason');
  @override
  late final GeneratedColumn<String> absentReason = GeneratedColumn<String>(
      'absent_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateGeneratedMeta =
      const VerificationMeta('dateGenerated');
  @override
  late final GeneratedColumn<DateTime> dateGenerated =
      GeneratedColumn<DateTime>('date_generated', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, day, didWork, profileId, absentReason, dateGenerated, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_tracker';
  @override
  VerificationContext validateIntegrity(Insertable<WorkTrackerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('did_work')) {
      context.handle(_didWorkMeta,
          didWork.isAcceptableOrUnknown(data['did_work']!, _didWorkMeta));
    } else if (isInserting) {
      context.missing(_didWorkMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('absent_reason')) {
      context.handle(
          _absentReasonMeta,
          absentReason.isAcceptableOrUnknown(
              data['absent_reason']!, _absentReasonMeta));
    }
    if (data.containsKey('date_generated')) {
      context.handle(
          _dateGeneratedMeta,
          dateGenerated.isAcceptableOrUnknown(
              data['date_generated']!, _dateGeneratedMeta));
    } else if (isInserting) {
      context.missing(_dateGeneratedMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkTrackerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkTrackerData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      day: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day'])!,
      didWork: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}did_work'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_id'])!,
      absentReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}absent_reason']),
      dateGenerated: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_generated'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $WorkTrackerTable createAlias(String alias) {
    return $WorkTrackerTable(attachedDatabase, alias);
  }
}

class WorkTrackerData extends DataClass implements Insertable<WorkTrackerData> {
  final int id;
  final String day;
  final bool didWork;
  final int profileId;
  final String? absentReason;
  final DateTime dateGenerated;
  final String? notes;
  const WorkTrackerData(
      {required this.id,
      required this.day,
      required this.didWork,
      required this.profileId,
      this.absentReason,
      required this.dateGenerated,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day'] = Variable<String>(day);
    map['did_work'] = Variable<bool>(didWork);
    map['profile_id'] = Variable<int>(profileId);
    if (!nullToAbsent || absentReason != null) {
      map['absent_reason'] = Variable<String>(absentReason);
    }
    map['date_generated'] = Variable<DateTime>(dateGenerated);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WorkTrackerCompanion toCompanion(bool nullToAbsent) {
    return WorkTrackerCompanion(
      id: Value(id),
      day: Value(day),
      didWork: Value(didWork),
      profileId: Value(profileId),
      absentReason: absentReason == null && nullToAbsent
          ? const Value.absent()
          : Value(absentReason),
      dateGenerated: Value(dateGenerated),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WorkTrackerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkTrackerData(
      id: serializer.fromJson<int>(json['id']),
      day: serializer.fromJson<String>(json['day']),
      didWork: serializer.fromJson<bool>(json['didWork']),
      profileId: serializer.fromJson<int>(json['profileId']),
      absentReason: serializer.fromJson<String?>(json['absentReason']),
      dateGenerated: serializer.fromJson<DateTime>(json['dateGenerated']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'day': serializer.toJson<String>(day),
      'didWork': serializer.toJson<bool>(didWork),
      'profileId': serializer.toJson<int>(profileId),
      'absentReason': serializer.toJson<String?>(absentReason),
      'dateGenerated': serializer.toJson<DateTime>(dateGenerated),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WorkTrackerData copyWith(
          {int? id,
          String? day,
          bool? didWork,
          int? profileId,
          Value<String?> absentReason = const Value.absent(),
          DateTime? dateGenerated,
          Value<String?> notes = const Value.absent()}) =>
      WorkTrackerData(
        id: id ?? this.id,
        day: day ?? this.day,
        didWork: didWork ?? this.didWork,
        profileId: profileId ?? this.profileId,
        absentReason:
            absentReason.present ? absentReason.value : this.absentReason,
        dateGenerated: dateGenerated ?? this.dateGenerated,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('WorkTrackerData(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('didWork: $didWork, ')
          ..write('profileId: $profileId, ')
          ..write('absentReason: $absentReason, ')
          ..write('dateGenerated: $dateGenerated, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, day, didWork, profileId, absentReason, dateGenerated, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkTrackerData &&
          other.id == this.id &&
          other.day == this.day &&
          other.didWork == this.didWork &&
          other.profileId == this.profileId &&
          other.absentReason == this.absentReason &&
          other.dateGenerated == this.dateGenerated &&
          other.notes == this.notes);
}

class WorkTrackerCompanion extends UpdateCompanion<WorkTrackerData> {
  final Value<int> id;
  final Value<String> day;
  final Value<bool> didWork;
  final Value<int> profileId;
  final Value<String?> absentReason;
  final Value<DateTime> dateGenerated;
  final Value<String?> notes;
  const WorkTrackerCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.didWork = const Value.absent(),
    this.profileId = const Value.absent(),
    this.absentReason = const Value.absent(),
    this.dateGenerated = const Value.absent(),
    this.notes = const Value.absent(),
  });
  WorkTrackerCompanion.insert({
    this.id = const Value.absent(),
    required String day,
    required bool didWork,
    required int profileId,
    this.absentReason = const Value.absent(),
    required DateTime dateGenerated,
    this.notes = const Value.absent(),
  })  : day = Value(day),
        didWork = Value(didWork),
        profileId = Value(profileId),
        dateGenerated = Value(dateGenerated);
  static Insertable<WorkTrackerData> custom({
    Expression<int>? id,
    Expression<String>? day,
    Expression<bool>? didWork,
    Expression<int>? profileId,
    Expression<String>? absentReason,
    Expression<DateTime>? dateGenerated,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (didWork != null) 'did_work': didWork,
      if (profileId != null) 'profile_id': profileId,
      if (absentReason != null) 'absent_reason': absentReason,
      if (dateGenerated != null) 'date_generated': dateGenerated,
      if (notes != null) 'notes': notes,
    });
  }

  WorkTrackerCompanion copyWith(
      {Value<int>? id,
      Value<String>? day,
      Value<bool>? didWork,
      Value<int>? profileId,
      Value<String?>? absentReason,
      Value<DateTime>? dateGenerated,
      Value<String?>? notes}) {
    return WorkTrackerCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      didWork: didWork ?? this.didWork,
      profileId: profileId ?? this.profileId,
      absentReason: absentReason ?? this.absentReason,
      dateGenerated: dateGenerated ?? this.dateGenerated,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (didWork.present) {
      map['did_work'] = Variable<bool>(didWork.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (absentReason.present) {
      map['absent_reason'] = Variable<String>(absentReason.value);
    }
    if (dateGenerated.present) {
      map['date_generated'] = Variable<DateTime>(dateGenerated.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkTrackerCompanion(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('didWork: $didWork, ')
          ..write('profileId: $profileId, ')
          ..write('absentReason: $absentReason, ')
          ..write('dateGenerated: $dateGenerated, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $WorkProfileTable workProfile = $WorkProfileTable(this);
  late final $WorkTrackerTable workTracker = $WorkTrackerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [workProfile, workTracker];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

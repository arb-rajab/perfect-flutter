// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $CouponsTable extends Coupons with TableInfo<$CouponsTable, coupons> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CouponsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serialMeta = const VerificationMeta('serial');
  @override
  late final GeneratedColumn<String> serial = GeneratedColumn<String>(
      'serial', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _freeMeta = const VerificationMeta('free');
  @override
  late final GeneratedColumn<int> free = GeneratedColumn<int>(
      'free', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _activationDateMeta =
      const VerificationMeta('activationDate');
  @override
  late final GeneratedColumn<DateTime> activationDate =
      GeneratedColumn<DateTime>('activationDate', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _expirationDaysMeta =
      const VerificationMeta('expirationDays');
  @override
  late final GeneratedColumn<int> expirationDays = GeneratedColumn<int>(
      'expirationDays', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(-1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, serial, type, free, creation, activationDate, expirationDays];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coupons';
  @override
  VerificationContext validateIntegrity(Insertable<coupons> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('serial')) {
      context.handle(_serialMeta,
          serial.isAcceptableOrUnknown(data['serial']!, _serialMeta));
    } else if (isInserting) {
      context.missing(_serialMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('free')) {
      context.handle(
          _freeMeta, free.isAcceptableOrUnknown(data['free']!, _freeMeta));
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    if (data.containsKey('activationDate')) {
      context.handle(
          _activationDateMeta,
          activationDate.isAcceptableOrUnknown(
              data['activationDate']!, _activationDateMeta));
    }
    if (data.containsKey('expirationDays')) {
      context.handle(
          _expirationDaysMeta,
          expirationDays.isAcceptableOrUnknown(
              data['expirationDays']!, _expirationDaysMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  coupons map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return coupons(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      free: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}free'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      activationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}activationDate']),
      expirationDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}expirationDays'])!,
    );
  }

  @override
  $CouponsTable createAlias(String alias) {
    return $CouponsTable(attachedDatabase, alias);
  }
}

class coupons extends DataClass implements Insertable<coupons> {
  final int id;
  final String serial;
  final int type;
  final int free;
  final DateTime creation;
  final DateTime? activationDate;
  final int expirationDays;
  const coupons(
      {required this.id,
      required this.serial,
      required this.type,
      required this.free,
      required this.creation,
      this.activationDate,
      required this.expirationDays});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['serial'] = Variable<String>(serial);
    map['type'] = Variable<int>(type);
    map['free'] = Variable<int>(free);
    map['creation'] = Variable<DateTime>(creation);
    if (!nullToAbsent || activationDate != null) {
      map['activationDate'] = Variable<DateTime>(activationDate);
    }
    map['expirationDays'] = Variable<int>(expirationDays);
    return map;
  }

  CouponsCompanion toCompanion(bool nullToAbsent) {
    return CouponsCompanion(
      id: Value(id),
      serial: Value(serial),
      type: Value(type),
      free: Value(free),
      creation: Value(creation),
      activationDate: activationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(activationDate),
      expirationDays: Value(expirationDays),
    );
  }

  factory coupons.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return coupons(
      id: serializer.fromJson<int>(json['id']),
      serial: serializer.fromJson<String>(json['serial']),
      type: serializer.fromJson<int>(json['type']),
      free: serializer.fromJson<int>(json['free']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      activationDate: serializer.fromJson<DateTime?>(json['activationDate']),
      expirationDays: serializer.fromJson<int>(json['expirationDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serial': serializer.toJson<String>(serial),
      'type': serializer.toJson<int>(type),
      'free': serializer.toJson<int>(free),
      'creation': serializer.toJson<DateTime>(creation),
      'activationDate': serializer.toJson<DateTime?>(activationDate),
      'expirationDays': serializer.toJson<int>(expirationDays),
    };
  }

  coupons copyWith(
          {int? id,
          String? serial,
          int? type,
          int? free,
          DateTime? creation,
          Value<DateTime?> activationDate = const Value.absent(),
          int? expirationDays}) =>
      coupons(
        id: id ?? this.id,
        serial: serial ?? this.serial,
        type: type ?? this.type,
        free: free ?? this.free,
        creation: creation ?? this.creation,
        activationDate:
            activationDate.present ? activationDate.value : this.activationDate,
        expirationDays: expirationDays ?? this.expirationDays,
      );
  @override
  String toString() {
    return (StringBuffer('coupons(')
          ..write('id: $id, ')
          ..write('serial: $serial, ')
          ..write('type: $type, ')
          ..write('free: $free, ')
          ..write('creation: $creation, ')
          ..write('activationDate: $activationDate, ')
          ..write('expirationDays: $expirationDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, serial, type, free, creation, activationDate, expirationDays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is coupons &&
          other.id == this.id &&
          other.serial == this.serial &&
          other.type == this.type &&
          other.free == this.free &&
          other.creation == this.creation &&
          other.activationDate == this.activationDate &&
          other.expirationDays == this.expirationDays);
}

class CouponsCompanion extends UpdateCompanion<coupons> {
  final Value<int> id;
  final Value<String> serial;
  final Value<int> type;
  final Value<int> free;
  final Value<DateTime> creation;
  final Value<DateTime?> activationDate;
  final Value<int> expirationDays;
  const CouponsCompanion({
    this.id = const Value.absent(),
    this.serial = const Value.absent(),
    this.type = const Value.absent(),
    this.free = const Value.absent(),
    this.creation = const Value.absent(),
    this.activationDate = const Value.absent(),
    this.expirationDays = const Value.absent(),
  });
  CouponsCompanion.insert({
    this.id = const Value.absent(),
    required String serial,
    required int type,
    this.free = const Value.absent(),
    required DateTime creation,
    this.activationDate = const Value.absent(),
    this.expirationDays = const Value.absent(),
  })  : serial = Value(serial),
        type = Value(type),
        creation = Value(creation);
  static Insertable<coupons> custom({
    Expression<int>? id,
    Expression<String>? serial,
    Expression<int>? type,
    Expression<int>? free,
    Expression<DateTime>? creation,
    Expression<DateTime>? activationDate,
    Expression<int>? expirationDays,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serial != null) 'serial': serial,
      if (type != null) 'type': type,
      if (free != null) 'free': free,
      if (creation != null) 'creation': creation,
      if (activationDate != null) 'activationDate': activationDate,
      if (expirationDays != null) 'expirationDays': expirationDays,
    });
  }

  CouponsCompanion copyWith(
      {Value<int>? id,
      Value<String>? serial,
      Value<int>? type,
      Value<int>? free,
      Value<DateTime>? creation,
      Value<DateTime?>? activationDate,
      Value<int>? expirationDays}) {
    return CouponsCompanion(
      id: id ?? this.id,
      serial: serial ?? this.serial,
      type: type ?? this.type,
      free: free ?? this.free,
      creation: creation ?? this.creation,
      activationDate: activationDate ?? this.activationDate,
      expirationDays: expirationDays ?? this.expirationDays,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serial.present) {
      map['serial'] = Variable<String>(serial.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (free.present) {
      map['free'] = Variable<int>(free.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (activationDate.present) {
      map['activationDate'] = Variable<DateTime>(activationDate.value);
    }
    if (expirationDays.present) {
      map['expirationDays'] = Variable<int>(expirationDays.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CouponsCompanion(')
          ..write('id: $id, ')
          ..write('serial: $serial, ')
          ..write('type: $type, ')
          ..write('free: $free, ')
          ..write('creation: $creation, ')
          ..write('activationDate: $activationDate, ')
          ..write('expirationDays: $expirationDays')
          ..write(')'))
        .toString();
  }
}

class $TermsTable extends Terms with TableInfo<$TermsTable, terms> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
      'enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _freeMeta = const VerificationMeta('free');
  @override
  late final GeneratedColumn<int> free = GeneratedColumn<int>(
      'free', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _orderingMeta =
      const VerificationMeta('ordering');
  @override
  late final GeneratedColumn<int> ordering = GeneratedColumn<int>(
      'ordering', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _needsUpdateMeta =
      const VerificationMeta('needsUpdate');
  @override
  late final GeneratedColumn<int> needsUpdate = GeneratedColumn<int>(
      'needsUpdate', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _captureableMeta =
      const VerificationMeta('captureable');
  @override
  late final GeneratedColumn<int> captureable = GeneratedColumn<int>(
      'captureable', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _textCulumnMeta =
      const VerificationMeta('textCulumn');
  @override
  late final GeneratedColumn<String> textCulumn = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        name,
        type,
        creation,
        enabled,
        free,
        ordering,
        needsUpdate,
        captureable,
        textCulumn
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terms';
  @override
  VerificationContext validateIntegrity(Insertable<terms> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('free')) {
      context.handle(
          _freeMeta, free.isAcceptableOrUnknown(data['free']!, _freeMeta));
    } else if (isInserting) {
      context.missing(_freeMeta);
    }
    if (data.containsKey('ordering')) {
      context.handle(_orderingMeta,
          ordering.isAcceptableOrUnknown(data['ordering']!, _orderingMeta));
    } else if (isInserting) {
      context.missing(_orderingMeta);
    }
    if (data.containsKey('needsUpdate')) {
      context.handle(
          _needsUpdateMeta,
          needsUpdate.isAcceptableOrUnknown(
              data['needsUpdate']!, _needsUpdateMeta));
    }
    if (data.containsKey('captureable')) {
      context.handle(
          _captureableMeta,
          captureable.isAcceptableOrUnknown(
              data['captureable']!, _captureableMeta));
    }
    if (data.containsKey('text')) {
      context.handle(_textCulumnMeta,
          textCulumn.isAcceptableOrUnknown(data['text']!, _textCulumnMeta));
    } else if (isInserting) {
      context.missing(_textCulumnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  terms map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return terms(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}enabled'])!,
      free: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}free'])!,
      ordering: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordering'])!,
      needsUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}needsUpdate'])!,
      captureable: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}captureable'])!,
      textCulumn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
    );
  }

  @override
  $TermsTable createAlias(String alias) {
    return $TermsTable(attachedDatabase, alias);
  }
}

class terms extends DataClass implements Insertable<terms> {
  final int id;
  final String uuid;
  final String name;
  final int type;
  final DateTime creation;
  final int enabled;
  final int free;
  final int ordering;
  final int needsUpdate;
  final int captureable;
  final String textCulumn;
  const terms(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.type,
      required this.creation,
      required this.enabled,
      required this.free,
      required this.ordering,
      required this.needsUpdate,
      required this.captureable,
      required this.textCulumn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<int>(type);
    map['creation'] = Variable<DateTime>(creation);
    map['enabled'] = Variable<int>(enabled);
    map['free'] = Variable<int>(free);
    map['ordering'] = Variable<int>(ordering);
    map['needsUpdate'] = Variable<int>(needsUpdate);
    map['captureable'] = Variable<int>(captureable);
    map['text'] = Variable<String>(textCulumn);
    return map;
  }

  TermsCompanion toCompanion(bool nullToAbsent) {
    return TermsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      type: Value(type),
      creation: Value(creation),
      enabled: Value(enabled),
      free: Value(free),
      ordering: Value(ordering),
      needsUpdate: Value(needsUpdate),
      captureable: Value(captureable),
      textCulumn: Value(textCulumn),
    );
  }

  factory terms.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return terms(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<int>(json['type']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      enabled: serializer.fromJson<int>(json['enabled']),
      free: serializer.fromJson<int>(json['free']),
      ordering: serializer.fromJson<int>(json['ordering']),
      needsUpdate: serializer.fromJson<int>(json['needsUpdate']),
      captureable: serializer.fromJson<int>(json['captureable']),
      textCulumn: serializer.fromJson<String>(json['text']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<int>(type),
      'creation': serializer.toJson<DateTime>(creation),
      'enabled': serializer.toJson<int>(enabled),
      'free': serializer.toJson<int>(free),
      'ordering': serializer.toJson<int>(ordering),
      'needsUpdate': serializer.toJson<int>(needsUpdate),
      'captureable': serializer.toJson<int>(captureable),
      'text': serializer.toJson<String>(textCulumn),
    };
  }

  terms copyWith(
          {int? id,
          String? uuid,
          String? name,
          int? type,
          DateTime? creation,
          int? enabled,
          int? free,
          int? ordering,
          int? needsUpdate,
          int? captureable,
          String? textCulumn}) =>
      terms(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        type: type ?? this.type,
        creation: creation ?? this.creation,
        enabled: enabled ?? this.enabled,
        free: free ?? this.free,
        ordering: ordering ?? this.ordering,
        needsUpdate: needsUpdate ?? this.needsUpdate,
        captureable: captureable ?? this.captureable,
        textCulumn: textCulumn ?? this.textCulumn,
      );
  @override
  String toString() {
    return (StringBuffer('terms(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('creation: $creation, ')
          ..write('enabled: $enabled, ')
          ..write('free: $free, ')
          ..write('ordering: $ordering, ')
          ..write('needsUpdate: $needsUpdate, ')
          ..write('captureable: $captureable, ')
          ..write('textCulumn: $textCulumn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, name, type, creation, enabled, free,
      ordering, needsUpdate, captureable, textCulumn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is terms &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.type == this.type &&
          other.creation == this.creation &&
          other.enabled == this.enabled &&
          other.free == this.free &&
          other.ordering == this.ordering &&
          other.needsUpdate == this.needsUpdate &&
          other.captureable == this.captureable &&
          other.textCulumn == this.textCulumn);
}

class TermsCompanion extends UpdateCompanion<terms> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<int> type;
  final Value<DateTime> creation;
  final Value<int> enabled;
  final Value<int> free;
  final Value<int> ordering;
  final Value<int> needsUpdate;
  final Value<int> captureable;
  final Value<String> textCulumn;
  const TermsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.creation = const Value.absent(),
    this.enabled = const Value.absent(),
    this.free = const Value.absent(),
    this.ordering = const Value.absent(),
    this.needsUpdate = const Value.absent(),
    this.captureable = const Value.absent(),
    this.textCulumn = const Value.absent(),
  });
  TermsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    required int type,
    required DateTime creation,
    this.enabled = const Value.absent(),
    required int free,
    required int ordering,
    this.needsUpdate = const Value.absent(),
    this.captureable = const Value.absent(),
    required String textCulumn,
  })  : uuid = Value(uuid),
        name = Value(name),
        type = Value(type),
        creation = Value(creation),
        free = Value(free),
        ordering = Value(ordering),
        textCulumn = Value(textCulumn);
  static Insertable<terms> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<int>? type,
    Expression<DateTime>? creation,
    Expression<int>? enabled,
    Expression<int>? free,
    Expression<int>? ordering,
    Expression<int>? needsUpdate,
    Expression<int>? captureable,
    Expression<String>? textCulumn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (creation != null) 'creation': creation,
      if (enabled != null) 'enabled': enabled,
      if (free != null) 'free': free,
      if (ordering != null) 'ordering': ordering,
      if (needsUpdate != null) 'needsUpdate': needsUpdate,
      if (captureable != null) 'captureable': captureable,
      if (textCulumn != null) 'text': textCulumn,
    });
  }

  TermsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? name,
      Value<int>? type,
      Value<DateTime>? creation,
      Value<int>? enabled,
      Value<int>? free,
      Value<int>? ordering,
      Value<int>? needsUpdate,
      Value<int>? captureable,
      Value<String>? textCulumn}) {
    return TermsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      type: type ?? this.type,
      creation: creation ?? this.creation,
      enabled: enabled ?? this.enabled,
      free: free ?? this.free,
      ordering: ordering ?? this.ordering,
      needsUpdate: needsUpdate ?? this.needsUpdate,
      captureable: captureable ?? this.captureable,
      textCulumn: textCulumn ?? this.textCulumn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (free.present) {
      map['free'] = Variable<int>(free.value);
    }
    if (ordering.present) {
      map['ordering'] = Variable<int>(ordering.value);
    }
    if (needsUpdate.present) {
      map['needsUpdate'] = Variable<int>(needsUpdate.value);
    }
    if (captureable.present) {
      map['captureable'] = Variable<int>(captureable.value);
    }
    if (textCulumn.present) {
      map['text'] = Variable<String>(textCulumn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('creation: $creation, ')
          ..write('enabled: $enabled, ')
          ..write('free: $free, ')
          ..write('ordering: $ordering, ')
          ..write('needsUpdate: $needsUpdate, ')
          ..write('captureable: $captureable, ')
          ..write('textCulumn: $textCulumn')
          ..write(')'))
        .toString();
  }
}

class $AnswersTable extends Answers with TableInfo<$AnswersTable, answers> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleTranslationMeta =
      const VerificationMeta('titleTranslation');
  @override
  late final GeneratedColumn<String> titleTranslation = GeneratedColumn<String>(
      'titleTranslation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<int> isCorrect = GeneratedColumn<int>(
      'isCorrect', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentQuestionIdMeta =
      const VerificationMeta('parentQuestionId');
  @override
  late final GeneratedColumn<int> parentQuestionId = GeneratedColumn<int>(
      'parentQuestionId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _specialCharacterMeta =
      const VerificationMeta('specialCharacter');
  @override
  late final GeneratedColumn<int> specialCharacter = GeneratedColumn<int>(
      'specialCharacter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _checkedCountMeta =
      const VerificationMeta('checkedCount');
  @override
  late final GeneratedColumn<int> checkedCount = GeneratedColumn<int>(
      'checkedCount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        title,
        titleTranslation,
        isCorrect,
        parentQuestionId,
        specialCharacter,
        creation,
        checkedCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answers';
  @override
  VerificationContext validateIntegrity(Insertable<answers> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('titleTranslation')) {
      context.handle(
          _titleTranslationMeta,
          titleTranslation.isAcceptableOrUnknown(
              data['titleTranslation']!, _titleTranslationMeta));
    }
    if (data.containsKey('isCorrect')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['isCorrect']!, _isCorrectMeta));
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('parentQuestionId')) {
      context.handle(
          _parentQuestionIdMeta,
          parentQuestionId.isAcceptableOrUnknown(
              data['parentQuestionId']!, _parentQuestionIdMeta));
    } else if (isInserting) {
      context.missing(_parentQuestionIdMeta);
    }
    if (data.containsKey('specialCharacter')) {
      context.handle(
          _specialCharacterMeta,
          specialCharacter.isAcceptableOrUnknown(
              data['specialCharacter']!, _specialCharacterMeta));
    } else if (isInserting) {
      context.missing(_specialCharacterMeta);
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    if (data.containsKey('checkedCount')) {
      context.handle(
          _checkedCountMeta,
          checkedCount.isAcceptableOrUnknown(
              data['checkedCount']!, _checkedCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  answers map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return answers(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      titleTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}titleTranslation'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}isCorrect'])!,
      parentQuestionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentQuestionId'])!,
      specialCharacter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}specialCharacter'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      checkedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}checkedCount'])!,
    );
  }

  @override
  $AnswersTable createAlias(String alias) {
    return $AnswersTable(attachedDatabase, alias);
  }
}

class answers extends DataClass implements Insertable<answers> {
  final int id;
  final String uuid;
  final String title;
  final String titleTranslation;
  final int isCorrect;
  final int parentQuestionId;
  final int specialCharacter;
  final DateTime creation;
  final int checkedCount;
  const answers(
      {required this.id,
      required this.uuid,
      required this.title,
      required this.titleTranslation,
      required this.isCorrect,
      required this.parentQuestionId,
      required this.specialCharacter,
      required this.creation,
      required this.checkedCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['titleTranslation'] = Variable<String>(titleTranslation);
    map['isCorrect'] = Variable<int>(isCorrect);
    map['parentQuestionId'] = Variable<int>(parentQuestionId);
    map['specialCharacter'] = Variable<int>(specialCharacter);
    map['creation'] = Variable<DateTime>(creation);
    map['checkedCount'] = Variable<int>(checkedCount);
    return map;
  }

  AnswersCompanion toCompanion(bool nullToAbsent) {
    return AnswersCompanion(
      id: Value(id),
      uuid: Value(uuid),
      title: Value(title),
      titleTranslation: Value(titleTranslation),
      isCorrect: Value(isCorrect),
      parentQuestionId: Value(parentQuestionId),
      specialCharacter: Value(specialCharacter),
      creation: Value(creation),
      checkedCount: Value(checkedCount),
    );
  }

  factory answers.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return answers(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      titleTranslation: serializer.fromJson<String>(json['titleTranslation']),
      isCorrect: serializer.fromJson<int>(json['isCorrect']),
      parentQuestionId: serializer.fromJson<int>(json['parentQuestionId']),
      specialCharacter: serializer.fromJson<int>(json['specialCharacter']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      checkedCount: serializer.fromJson<int>(json['checkedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'titleTranslation': serializer.toJson<String>(titleTranslation),
      'isCorrect': serializer.toJson<int>(isCorrect),
      'parentQuestionId': serializer.toJson<int>(parentQuestionId),
      'specialCharacter': serializer.toJson<int>(specialCharacter),
      'creation': serializer.toJson<DateTime>(creation),
      'checkedCount': serializer.toJson<int>(checkedCount),
    };
  }

  answers copyWith(
          {int? id,
          String? uuid,
          String? title,
          String? titleTranslation,
          int? isCorrect,
          int? parentQuestionId,
          int? specialCharacter,
          DateTime? creation,
          int? checkedCount}) =>
      answers(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        titleTranslation: titleTranslation ?? this.titleTranslation,
        isCorrect: isCorrect ?? this.isCorrect,
        parentQuestionId: parentQuestionId ?? this.parentQuestionId,
        specialCharacter: specialCharacter ?? this.specialCharacter,
        creation: creation ?? this.creation,
        checkedCount: checkedCount ?? this.checkedCount,
      );
  @override
  String toString() {
    return (StringBuffer('answers(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('titleTranslation: $titleTranslation, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('parentQuestionId: $parentQuestionId, ')
          ..write('specialCharacter: $specialCharacter, ')
          ..write('creation: $creation, ')
          ..write('checkedCount: $checkedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, title, titleTranslation, isCorrect,
      parentQuestionId, specialCharacter, creation, checkedCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is answers &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.titleTranslation == this.titleTranslation &&
          other.isCorrect == this.isCorrect &&
          other.parentQuestionId == this.parentQuestionId &&
          other.specialCharacter == this.specialCharacter &&
          other.creation == this.creation &&
          other.checkedCount == this.checkedCount);
}

class AnswersCompanion extends UpdateCompanion<answers> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> titleTranslation;
  final Value<int> isCorrect;
  final Value<int> parentQuestionId;
  final Value<int> specialCharacter;
  final Value<DateTime> creation;
  final Value<int> checkedCount;
  const AnswersCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.titleTranslation = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.parentQuestionId = const Value.absent(),
    this.specialCharacter = const Value.absent(),
    this.creation = const Value.absent(),
    this.checkedCount = const Value.absent(),
  });
  AnswersCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String title,
    this.titleTranslation = const Value.absent(),
    required int isCorrect,
    required int parentQuestionId,
    required int specialCharacter,
    required DateTime creation,
    this.checkedCount = const Value.absent(),
  })  : uuid = Value(uuid),
        title = Value(title),
        isCorrect = Value(isCorrect),
        parentQuestionId = Value(parentQuestionId),
        specialCharacter = Value(specialCharacter),
        creation = Value(creation);
  static Insertable<answers> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? titleTranslation,
    Expression<int>? isCorrect,
    Expression<int>? parentQuestionId,
    Expression<int>? specialCharacter,
    Expression<DateTime>? creation,
    Expression<int>? checkedCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (titleTranslation != null) 'titleTranslation': titleTranslation,
      if (isCorrect != null) 'isCorrect': isCorrect,
      if (parentQuestionId != null) 'parentQuestionId': parentQuestionId,
      if (specialCharacter != null) 'specialCharacter': specialCharacter,
      if (creation != null) 'creation': creation,
      if (checkedCount != null) 'checkedCount': checkedCount,
    });
  }

  AnswersCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? title,
      Value<String>? titleTranslation,
      Value<int>? isCorrect,
      Value<int>? parentQuestionId,
      Value<int>? specialCharacter,
      Value<DateTime>? creation,
      Value<int>? checkedCount}) {
    return AnswersCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      titleTranslation: titleTranslation ?? this.titleTranslation,
      isCorrect: isCorrect ?? this.isCorrect,
      parentQuestionId: parentQuestionId ?? this.parentQuestionId,
      specialCharacter: specialCharacter ?? this.specialCharacter,
      creation: creation ?? this.creation,
      checkedCount: checkedCount ?? this.checkedCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleTranslation.present) {
      map['titleTranslation'] = Variable<String>(titleTranslation.value);
    }
    if (isCorrect.present) {
      map['isCorrect'] = Variable<int>(isCorrect.value);
    }
    if (parentQuestionId.present) {
      map['parentQuestionId'] = Variable<int>(parentQuestionId.value);
    }
    if (specialCharacter.present) {
      map['specialCharacter'] = Variable<int>(specialCharacter.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (checkedCount.present) {
      map['checkedCount'] = Variable<int>(checkedCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswersCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('titleTranslation: $titleTranslation, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('parentQuestionId: $parentQuestionId, ')
          ..write('specialCharacter: $specialCharacter, ')
          ..write('creation: $creation, ')
          ..write('checkedCount: $checkedCount')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, questions> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleTranslationMeta =
      const VerificationMeta('titleTranslation');
  @override
  late final GeneratedColumn<String> titleTranslation = GeneratedColumn<String>(
      'titleTranslation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _labelIdMeta =
      const VerificationMeta('labelId');
  @override
  late final GeneratedColumn<int> labelId = GeneratedColumn<int>(
      'labelId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteTranslationMeta =
      const VerificationMeta('noteTranslation');
  @override
  late final GeneratedColumn<String> noteTranslation = GeneratedColumn<String>(
      'noteTranslation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _specialCharacterMeta =
      const VerificationMeta('specialCharacter');
  @override
  late final GeneratedColumn<int> specialCharacter = GeneratedColumn<int>(
      'specialCharacter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _editedMeta = const VerificationMeta('edited');
  @override
  late final GeneratedColumn<int> edited = GeneratedColumn<int>(
      'edited', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'imageUrl', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _editionDateMeta =
      const VerificationMeta('editionDate');
  @override
  late final GeneratedColumn<DateTime> editionDate = GeneratedColumn<DateTime>(
      'editionDate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        title,
        titleTranslation,
        labelId,
        note,
        noteTranslation,
        parentTermId,
        specialCharacter,
        type,
        edited,
        imageUrl,
        creation,
        editionDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<questions> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('titleTranslation')) {
      context.handle(
          _titleTranslationMeta,
          titleTranslation.isAcceptableOrUnknown(
              data['titleTranslation']!, _titleTranslationMeta));
    }
    if (data.containsKey('labelId')) {
      context.handle(_labelIdMeta,
          labelId.isAcceptableOrUnknown(data['labelId']!, _labelIdMeta));
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('noteTranslation')) {
      context.handle(
          _noteTranslationMeta,
          noteTranslation.isAcceptableOrUnknown(
              data['noteTranslation']!, _noteTranslationMeta));
    }
    if (data.containsKey('parentTermId')) {
      context.handle(
          _parentTermIdMeta,
          parentTermId.isAcceptableOrUnknown(
              data['parentTermId']!, _parentTermIdMeta));
    } else if (isInserting) {
      context.missing(_parentTermIdMeta);
    }
    if (data.containsKey('specialCharacter')) {
      context.handle(
          _specialCharacterMeta,
          specialCharacter.isAcceptableOrUnknown(
              data['specialCharacter']!, _specialCharacterMeta));
    } else if (isInserting) {
      context.missing(_specialCharacterMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('edited')) {
      context.handle(_editedMeta,
          edited.isAcceptableOrUnknown(data['edited']!, _editedMeta));
    }
    if (data.containsKey('imageUrl')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['imageUrl']!, _imageUrlMeta));
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    if (data.containsKey('editionDate')) {
      context.handle(
          _editionDateMeta,
          editionDate.isAcceptableOrUnknown(
              data['editionDate']!, _editionDateMeta));
    } else if (isInserting) {
      context.missing(_editionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  questions map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return questions(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      titleTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}titleTranslation'])!,
      labelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}labelId'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      noteTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}noteTranslation'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      specialCharacter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}specialCharacter'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      edited: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}edited'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imageUrl'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      editionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}editionDate'])!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class questions extends DataClass implements Insertable<questions> {
  final int id;
  final String uuid;
  final String title;
  final String titleTranslation;
  final int labelId;
  final String note;
  final String noteTranslation;
  final int parentTermId;
  final int specialCharacter;
  final int type;
  final int edited;
  final String imageUrl;
  final DateTime creation;
  final DateTime editionDate;
  const questions(
      {required this.id,
      required this.uuid,
      required this.title,
      required this.titleTranslation,
      required this.labelId,
      required this.note,
      required this.noteTranslation,
      required this.parentTermId,
      required this.specialCharacter,
      required this.type,
      required this.edited,
      required this.imageUrl,
      required this.creation,
      required this.editionDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['titleTranslation'] = Variable<String>(titleTranslation);
    map['labelId'] = Variable<int>(labelId);
    map['note'] = Variable<String>(note);
    map['noteTranslation'] = Variable<String>(noteTranslation);
    map['parentTermId'] = Variable<int>(parentTermId);
    map['specialCharacter'] = Variable<int>(specialCharacter);
    map['type'] = Variable<int>(type);
    map['edited'] = Variable<int>(edited);
    map['imageUrl'] = Variable<String>(imageUrl);
    map['creation'] = Variable<DateTime>(creation);
    map['editionDate'] = Variable<DateTime>(editionDate);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      title: Value(title),
      titleTranslation: Value(titleTranslation),
      labelId: Value(labelId),
      note: Value(note),
      noteTranslation: Value(noteTranslation),
      parentTermId: Value(parentTermId),
      specialCharacter: Value(specialCharacter),
      type: Value(type),
      edited: Value(edited),
      imageUrl: Value(imageUrl),
      creation: Value(creation),
      editionDate: Value(editionDate),
    );
  }

  factory questions.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return questions(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      titleTranslation: serializer.fromJson<String>(json['titleTranslation']),
      labelId: serializer.fromJson<int>(json['labelId']),
      note: serializer.fromJson<String>(json['note']),
      noteTranslation: serializer.fromJson<String>(json['noteTranslation']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      specialCharacter: serializer.fromJson<int>(json['specialCharacter']),
      type: serializer.fromJson<int>(json['type']),
      edited: serializer.fromJson<int>(json['edited']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      editionDate: serializer.fromJson<DateTime>(json['editionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'titleTranslation': serializer.toJson<String>(titleTranslation),
      'labelId': serializer.toJson<int>(labelId),
      'note': serializer.toJson<String>(note),
      'noteTranslation': serializer.toJson<String>(noteTranslation),
      'parentTermId': serializer.toJson<int>(parentTermId),
      'specialCharacter': serializer.toJson<int>(specialCharacter),
      'type': serializer.toJson<int>(type),
      'edited': serializer.toJson<int>(edited),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'creation': serializer.toJson<DateTime>(creation),
      'editionDate': serializer.toJson<DateTime>(editionDate),
    };
  }

  questions copyWith(
          {int? id,
          String? uuid,
          String? title,
          String? titleTranslation,
          int? labelId,
          String? note,
          String? noteTranslation,
          int? parentTermId,
          int? specialCharacter,
          int? type,
          int? edited,
          String? imageUrl,
          DateTime? creation,
          DateTime? editionDate}) =>
      questions(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        titleTranslation: titleTranslation ?? this.titleTranslation,
        labelId: labelId ?? this.labelId,
        note: note ?? this.note,
        noteTranslation: noteTranslation ?? this.noteTranslation,
        parentTermId: parentTermId ?? this.parentTermId,
        specialCharacter: specialCharacter ?? this.specialCharacter,
        type: type ?? this.type,
        edited: edited ?? this.edited,
        imageUrl: imageUrl ?? this.imageUrl,
        creation: creation ?? this.creation,
        editionDate: editionDate ?? this.editionDate,
      );
  @override
  String toString() {
    return (StringBuffer('questions(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('titleTranslation: $titleTranslation, ')
          ..write('labelId: $labelId, ')
          ..write('note: $note, ')
          ..write('noteTranslation: $noteTranslation, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('specialCharacter: $specialCharacter, ')
          ..write('type: $type, ')
          ..write('edited: $edited, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('creation: $creation, ')
          ..write('editionDate: $editionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      title,
      titleTranslation,
      labelId,
      note,
      noteTranslation,
      parentTermId,
      specialCharacter,
      type,
      edited,
      imageUrl,
      creation,
      editionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is questions &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.titleTranslation == this.titleTranslation &&
          other.labelId == this.labelId &&
          other.note == this.note &&
          other.noteTranslation == this.noteTranslation &&
          other.parentTermId == this.parentTermId &&
          other.specialCharacter == this.specialCharacter &&
          other.type == this.type &&
          other.edited == this.edited &&
          other.imageUrl == this.imageUrl &&
          other.creation == this.creation &&
          other.editionDate == this.editionDate);
}

class QuestionsCompanion extends UpdateCompanion<questions> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> titleTranslation;
  final Value<int> labelId;
  final Value<String> note;
  final Value<String> noteTranslation;
  final Value<int> parentTermId;
  final Value<int> specialCharacter;
  final Value<int> type;
  final Value<int> edited;
  final Value<String> imageUrl;
  final Value<DateTime> creation;
  final Value<DateTime> editionDate;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.titleTranslation = const Value.absent(),
    this.labelId = const Value.absent(),
    this.note = const Value.absent(),
    this.noteTranslation = const Value.absent(),
    this.parentTermId = const Value.absent(),
    this.specialCharacter = const Value.absent(),
    this.type = const Value.absent(),
    this.edited = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.creation = const Value.absent(),
    this.editionDate = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String title,
    this.titleTranslation = const Value.absent(),
    required int labelId,
    required String note,
    this.noteTranslation = const Value.absent(),
    required int parentTermId,
    required int specialCharacter,
    required int type,
    this.edited = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required DateTime creation,
    required DateTime editionDate,
  })  : uuid = Value(uuid),
        title = Value(title),
        labelId = Value(labelId),
        note = Value(note),
        parentTermId = Value(parentTermId),
        specialCharacter = Value(specialCharacter),
        type = Value(type),
        creation = Value(creation),
        editionDate = Value(editionDate);
  static Insertable<questions> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? titleTranslation,
    Expression<int>? labelId,
    Expression<String>? note,
    Expression<String>? noteTranslation,
    Expression<int>? parentTermId,
    Expression<int>? specialCharacter,
    Expression<int>? type,
    Expression<int>? edited,
    Expression<String>? imageUrl,
    Expression<DateTime>? creation,
    Expression<DateTime>? editionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (titleTranslation != null) 'titleTranslation': titleTranslation,
      if (labelId != null) 'labelId': labelId,
      if (note != null) 'note': note,
      if (noteTranslation != null) 'noteTranslation': noteTranslation,
      if (parentTermId != null) 'parentTermId': parentTermId,
      if (specialCharacter != null) 'specialCharacter': specialCharacter,
      if (type != null) 'type': type,
      if (edited != null) 'edited': edited,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (creation != null) 'creation': creation,
      if (editionDate != null) 'editionDate': editionDate,
    });
  }

  QuestionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? title,
      Value<String>? titleTranslation,
      Value<int>? labelId,
      Value<String>? note,
      Value<String>? noteTranslation,
      Value<int>? parentTermId,
      Value<int>? specialCharacter,
      Value<int>? type,
      Value<int>? edited,
      Value<String>? imageUrl,
      Value<DateTime>? creation,
      Value<DateTime>? editionDate}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      titleTranslation: titleTranslation ?? this.titleTranslation,
      labelId: labelId ?? this.labelId,
      note: note ?? this.note,
      noteTranslation: noteTranslation ?? this.noteTranslation,
      parentTermId: parentTermId ?? this.parentTermId,
      specialCharacter: specialCharacter ?? this.specialCharacter,
      type: type ?? this.type,
      edited: edited ?? this.edited,
      imageUrl: imageUrl ?? this.imageUrl,
      creation: creation ?? this.creation,
      editionDate: editionDate ?? this.editionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleTranslation.present) {
      map['titleTranslation'] = Variable<String>(titleTranslation.value);
    }
    if (labelId.present) {
      map['labelId'] = Variable<int>(labelId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (noteTranslation.present) {
      map['noteTranslation'] = Variable<String>(noteTranslation.value);
    }
    if (parentTermId.present) {
      map['parentTermId'] = Variable<int>(parentTermId.value);
    }
    if (specialCharacter.present) {
      map['specialCharacter'] = Variable<int>(specialCharacter.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (edited.present) {
      map['edited'] = Variable<int>(edited.value);
    }
    if (imageUrl.present) {
      map['imageUrl'] = Variable<String>(imageUrl.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (editionDate.present) {
      map['editionDate'] = Variable<DateTime>(editionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('titleTranslation: $titleTranslation, ')
          ..write('labelId: $labelId, ')
          ..write('note: $note, ')
          ..write('noteTranslation: $noteTranslation, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('specialCharacter: $specialCharacter, ')
          ..write('type: $type, ')
          ..write('edited: $edited, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('creation: $creation, ')
          ..write('editionDate: $editionDate')
          ..write(')'))
        .toString();
  }
}

class $QuestionTagsTable extends QuestionTags
    with TableInfo<$QuestionTagsTable, questionTags> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentTagIdMeta =
      const VerificationMeta('parentTagId');
  @override
  late final GeneratedColumn<int> parentTagId = GeneratedColumn<int>(
      'parentTagId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hasInformationMeta =
      const VerificationMeta('hasInformation');
  @override
  late final GeneratedColumn<int> hasInformation = GeneratedColumn<int>(
      'hasInformation', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, parentTagId, hasInformation, creation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_tags';
  @override
  VerificationContext validateIntegrity(Insertable<questionTags> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parentTagId')) {
      context.handle(
          _parentTagIdMeta,
          parentTagId.isAcceptableOrUnknown(
              data['parentTagId']!, _parentTagIdMeta));
    } else if (isInserting) {
      context.missing(_parentTagIdMeta);
    }
    if (data.containsKey('hasInformation')) {
      context.handle(
          _hasInformationMeta,
          hasInformation.isAcceptableOrUnknown(
              data['hasInformation']!, _hasInformationMeta));
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  questionTags map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return questionTags(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentTagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTagId'])!,
      hasInformation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hasInformation'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
    );
  }

  @override
  $QuestionTagsTable createAlias(String alias) {
    return $QuestionTagsTable(attachedDatabase, alias);
  }
}

class questionTags extends DataClass implements Insertable<questionTags> {
  final int id;
  final String name;
  final int parentTagId;
  final int hasInformation;
  final DateTime creation;
  const questionTags(
      {required this.id,
      required this.name,
      required this.parentTagId,
      required this.hasInformation,
      required this.creation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['parentTagId'] = Variable<int>(parentTagId);
    map['hasInformation'] = Variable<int>(hasInformation);
    map['creation'] = Variable<DateTime>(creation);
    return map;
  }

  QuestionTagsCompanion toCompanion(bool nullToAbsent) {
    return QuestionTagsCompanion(
      id: Value(id),
      name: Value(name),
      parentTagId: Value(parentTagId),
      hasInformation: Value(hasInformation),
      creation: Value(creation),
    );
  }

  factory questionTags.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return questionTags(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentTagId: serializer.fromJson<int>(json['parentTagId']),
      hasInformation: serializer.fromJson<int>(json['hasInformation']),
      creation: serializer.fromJson<DateTime>(json['creation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentTagId': serializer.toJson<int>(parentTagId),
      'hasInformation': serializer.toJson<int>(hasInformation),
      'creation': serializer.toJson<DateTime>(creation),
    };
  }

  questionTags copyWith(
          {int? id,
          String? name,
          int? parentTagId,
          int? hasInformation,
          DateTime? creation}) =>
      questionTags(
        id: id ?? this.id,
        name: name ?? this.name,
        parentTagId: parentTagId ?? this.parentTagId,
        hasInformation: hasInformation ?? this.hasInformation,
        creation: creation ?? this.creation,
      );
  @override
  String toString() {
    return (StringBuffer('questionTags(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentTagId: $parentTagId, ')
          ..write('hasInformation: $hasInformation, ')
          ..write('creation: $creation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, parentTagId, hasInformation, creation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is questionTags &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentTagId == this.parentTagId &&
          other.hasInformation == this.hasInformation &&
          other.creation == this.creation);
}

class QuestionTagsCompanion extends UpdateCompanion<questionTags> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> parentTagId;
  final Value<int> hasInformation;
  final Value<DateTime> creation;
  final Value<int> rowid;
  const QuestionTagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentTagId = const Value.absent(),
    this.hasInformation = const Value.absent(),
    this.creation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionTagsCompanion.insert({
    required int id,
    required String name,
    required int parentTagId,
    this.hasInformation = const Value.absent(),
    required DateTime creation,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        parentTagId = Value(parentTagId),
        creation = Value(creation);
  static Insertable<questionTags> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? parentTagId,
    Expression<int>? hasInformation,
    Expression<DateTime>? creation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentTagId != null) 'parentTagId': parentTagId,
      if (hasInformation != null) 'hasInformation': hasInformation,
      if (creation != null) 'creation': creation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionTagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? parentTagId,
      Value<int>? hasInformation,
      Value<DateTime>? creation,
      Value<int>? rowid}) {
    return QuestionTagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentTagId: parentTagId ?? this.parentTagId,
      hasInformation: hasInformation ?? this.hasInformation,
      creation: creation ?? this.creation,
      rowid: rowid ?? this.rowid,
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
    if (parentTagId.present) {
      map['parentTagId'] = Variable<int>(parentTagId.value);
    }
    if (hasInformation.present) {
      map['hasInformation'] = Variable<int>(hasInformation.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentTagId: $parentTagId, ')
          ..write('hasInformation: $hasInformation, ')
          ..write('creation: $creation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionMediasTable extends QuestionMedias
    with TableInfo<$QuestionMediasTable, questionMedias> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionMediasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentQuestionIdMeta =
      const VerificationMeta('parentQuestionId');
  @override
  late final GeneratedColumn<int> parentQuestionId = GeneratedColumn<int>(
      'parentQuestionId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, url, parentQuestionId, creation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_medias';
  @override
  VerificationContext validateIntegrity(Insertable<questionMedias> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('parentQuestionId')) {
      context.handle(
          _parentQuestionIdMeta,
          parentQuestionId.isAcceptableOrUnknown(
              data['parentQuestionId']!, _parentQuestionIdMeta));
    } else if (isInserting) {
      context.missing(_parentQuestionIdMeta);
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, parentQuestionId};
  @override
  questionMedias map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return questionMedias(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      parentQuestionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentQuestionId'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
    );
  }

  @override
  $QuestionMediasTable createAlias(String alias) {
    return $QuestionMediasTable(attachedDatabase, alias);
  }
}

class questionMedias extends DataClass implements Insertable<questionMedias> {
  final int id;
  final String url;
  final int parentQuestionId;
  final DateTime creation;
  const questionMedias(
      {required this.id,
      required this.url,
      required this.parentQuestionId,
      required this.creation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['parentQuestionId'] = Variable<int>(parentQuestionId);
    map['creation'] = Variable<DateTime>(creation);
    return map;
  }

  QuestionMediasCompanion toCompanion(bool nullToAbsent) {
    return QuestionMediasCompanion(
      id: Value(id),
      url: Value(url),
      parentQuestionId: Value(parentQuestionId),
      creation: Value(creation),
    );
  }

  factory questionMedias.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return questionMedias(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      parentQuestionId: serializer.fromJson<int>(json['parentQuestionId']),
      creation: serializer.fromJson<DateTime>(json['creation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'parentQuestionId': serializer.toJson<int>(parentQuestionId),
      'creation': serializer.toJson<DateTime>(creation),
    };
  }

  questionMedias copyWith(
          {int? id, String? url, int? parentQuestionId, DateTime? creation}) =>
      questionMedias(
        id: id ?? this.id,
        url: url ?? this.url,
        parentQuestionId: parentQuestionId ?? this.parentQuestionId,
        creation: creation ?? this.creation,
      );
  @override
  String toString() {
    return (StringBuffer('questionMedias(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('parentQuestionId: $parentQuestionId, ')
          ..write('creation: $creation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, parentQuestionId, creation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is questionMedias &&
          other.id == this.id &&
          other.url == this.url &&
          other.parentQuestionId == this.parentQuestionId &&
          other.creation == this.creation);
}

class QuestionMediasCompanion extends UpdateCompanion<questionMedias> {
  final Value<int> id;
  final Value<String> url;
  final Value<int> parentQuestionId;
  final Value<DateTime> creation;
  final Value<int> rowid;
  const QuestionMediasCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.parentQuestionId = const Value.absent(),
    this.creation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionMediasCompanion.insert({
    required int id,
    required String url,
    required int parentQuestionId,
    required DateTime creation,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        url = Value(url),
        parentQuestionId = Value(parentQuestionId),
        creation = Value(creation);
  static Insertable<questionMedias> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<int>? parentQuestionId,
    Expression<DateTime>? creation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (parentQuestionId != null) 'parentQuestionId': parentQuestionId,
      if (creation != null) 'creation': creation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionMediasCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<int>? parentQuestionId,
      Value<DateTime>? creation,
      Value<int>? rowid}) {
    return QuestionMediasCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      parentQuestionId: parentQuestionId ?? this.parentQuestionId,
      creation: creation ?? this.creation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (parentQuestionId.present) {
      map['parentQuestionId'] = Variable<int>(parentQuestionId.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionMediasCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('parentQuestionId: $parentQuestionId, ')
          ..write('creation: $creation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FcmTopicsTable extends FcmTopics
    with TableInfo<$FcmTopicsTable, FCMTopics> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FcmTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionSucceedMeta =
      const VerificationMeta('subscriptionSucceed');
  @override
  late final GeneratedColumn<bool> subscriptionSucceed = GeneratedColumn<bool>(
      'subscriptionSucceed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("subscriptionSucceed" IN (0, 1))'));
  static const VerificationMeta _subscribedMeta =
      const VerificationMeta('subscribed');
  @override
  late final GeneratedColumn<bool> subscribed = GeneratedColumn<bool>(
      'subscribed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("subscribed" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [title, subscriptionSucceed, subscribed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fcm_topics';
  @override
  VerificationContext validateIntegrity(Insertable<FCMTopics> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subscriptionSucceed')) {
      context.handle(
          _subscriptionSucceedMeta,
          subscriptionSucceed.isAcceptableOrUnknown(
              data['subscriptionSucceed']!, _subscriptionSucceedMeta));
    } else if (isInserting) {
      context.missing(_subscriptionSucceedMeta);
    }
    if (data.containsKey('subscribed')) {
      context.handle(
          _subscribedMeta,
          subscribed.isAcceptableOrUnknown(
              data['subscribed']!, _subscribedMeta));
    } else if (isInserting) {
      context.missing(_subscribedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  FCMTopics map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FCMTopics(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subscriptionSucceed: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}subscriptionSucceed'])!,
      subscribed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}subscribed'])!,
    );
  }

  @override
  $FcmTopicsTable createAlias(String alias) {
    return $FcmTopicsTable(attachedDatabase, alias);
  }
}

class FCMTopics extends DataClass implements Insertable<FCMTopics> {
  final String title;
  final bool subscriptionSucceed;
  final bool subscribed;
  const FCMTopics(
      {required this.title,
      required this.subscriptionSucceed,
      required this.subscribed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['subscriptionSucceed'] = Variable<bool>(subscriptionSucceed);
    map['subscribed'] = Variable<bool>(subscribed);
    return map;
  }

  FcmTopicsCompanion toCompanion(bool nullToAbsent) {
    return FcmTopicsCompanion(
      title: Value(title),
      subscriptionSucceed: Value(subscriptionSucceed),
      subscribed: Value(subscribed),
    );
  }

  factory FCMTopics.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FCMTopics(
      title: serializer.fromJson<String>(json['title']),
      subscriptionSucceed:
          serializer.fromJson<bool>(json['subscriptionSucceed']),
      subscribed: serializer.fromJson<bool>(json['subscribed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'subscriptionSucceed': serializer.toJson<bool>(subscriptionSucceed),
      'subscribed': serializer.toJson<bool>(subscribed),
    };
  }

  FCMTopics copyWith(
          {String? title, bool? subscriptionSucceed, bool? subscribed}) =>
      FCMTopics(
        title: title ?? this.title,
        subscriptionSucceed: subscriptionSucceed ?? this.subscriptionSucceed,
        subscribed: subscribed ?? this.subscribed,
      );
  @override
  String toString() {
    return (StringBuffer('FCMTopics(')
          ..write('title: $title, ')
          ..write('subscriptionSucceed: $subscriptionSucceed, ')
          ..write('subscribed: $subscribed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, subscriptionSucceed, subscribed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCMTopics &&
          other.title == this.title &&
          other.subscriptionSucceed == this.subscriptionSucceed &&
          other.subscribed == this.subscribed);
}

class FcmTopicsCompanion extends UpdateCompanion<FCMTopics> {
  final Value<String> title;
  final Value<bool> subscriptionSucceed;
  final Value<bool> subscribed;
  final Value<int> rowid;
  const FcmTopicsCompanion({
    this.title = const Value.absent(),
    this.subscriptionSucceed = const Value.absent(),
    this.subscribed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FcmTopicsCompanion.insert({
    required String title,
    required bool subscriptionSucceed,
    required bool subscribed,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        subscriptionSucceed = Value(subscriptionSucceed),
        subscribed = Value(subscribed);
  static Insertable<FCMTopics> custom({
    Expression<String>? title,
    Expression<bool>? subscriptionSucceed,
    Expression<bool>? subscribed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (subscriptionSucceed != null)
        'subscriptionSucceed': subscriptionSucceed,
      if (subscribed != null) 'subscribed': subscribed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FcmTopicsCompanion copyWith(
      {Value<String>? title,
      Value<bool>? subscriptionSucceed,
      Value<bool>? subscribed,
      Value<int>? rowid}) {
    return FcmTopicsCompanion(
      title: title ?? this.title,
      subscriptionSucceed: subscriptionSucceed ?? this.subscriptionSucceed,
      subscribed: subscribed ?? this.subscribed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subscriptionSucceed.present) {
      map['subscriptionSucceed'] = Variable<bool>(subscriptionSucceed.value);
    }
    if (subscribed.present) {
      map['subscribed'] = Variable<bool>(subscribed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FcmTopicsCompanion(')
          ..write('title: $title, ')
          ..write('subscriptionSucceed: $subscriptionSucceed, ')
          ..write('subscribed: $subscribed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswerPropertiesTable extends AnswerProperties
    with TableInfo<$AnswerPropertiesTable, answerProperties> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerPropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _answerIdMeta =
      const VerificationMeta('answerId');
  @override
  late final GeneratedColumn<int> answerId = GeneratedColumn<int>(
      'answerId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [answerId, name, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_properties';
  @override
  VerificationContext validateIntegrity(Insertable<answerProperties> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('answerId')) {
      context.handle(_answerIdMeta,
          answerId.isAcceptableOrUnknown(data['answerId']!, _answerIdMeta));
    } else if (isInserting) {
      context.missing(_answerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {answerId, name};
  @override
  answerProperties map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return answerProperties(
      answerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}answerId'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AnswerPropertiesTable createAlias(String alias) {
    return $AnswerPropertiesTable(attachedDatabase, alias);
  }
}

class answerProperties extends DataClass
    implements Insertable<answerProperties> {
  final int answerId;
  final String name;
  final String value;
  const answerProperties(
      {required this.answerId, required this.name, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['answerId'] = Variable<int>(answerId);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    return map;
  }

  AnswerPropertiesCompanion toCompanion(bool nullToAbsent) {
    return AnswerPropertiesCompanion(
      answerId: Value(answerId),
      name: Value(name),
      value: Value(value),
    );
  }

  factory answerProperties.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return answerProperties(
      answerId: serializer.fromJson<int>(json['answerId']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'answerId': serializer.toJson<int>(answerId),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  answerProperties copyWith({int? answerId, String? name, String? value}) =>
      answerProperties(
        answerId: answerId ?? this.answerId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('answerProperties(')
          ..write('answerId: $answerId, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(answerId, name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is answerProperties &&
          other.answerId == this.answerId &&
          other.name == this.name &&
          other.value == this.value);
}

class AnswerPropertiesCompanion extends UpdateCompanion<answerProperties> {
  final Value<int> answerId;
  final Value<String> name;
  final Value<String> value;
  final Value<int> rowid;
  const AnswerPropertiesCompanion({
    this.answerId = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnswerPropertiesCompanion.insert({
    required int answerId,
    required String name,
    required String value,
    this.rowid = const Value.absent(),
  })  : answerId = Value(answerId),
        name = Value(name),
        value = Value(value);
  static Insertable<answerProperties> custom({
    Expression<int>? answerId,
    Expression<String>? name,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (answerId != null) 'answerId': answerId,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnswerPropertiesCompanion copyWith(
      {Value<int>? answerId,
      Value<String>? name,
      Value<String>? value,
      Value<int>? rowid}) {
    return AnswerPropertiesCompanion(
      answerId: answerId ?? this.answerId,
      name: name ?? this.name,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (answerId.present) {
      map['answerId'] = Variable<int>(answerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerPropertiesCompanion(')
          ..write('answerId: $answerId, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CouponsLinkedToTermsTable extends CouponsLinkedToTerms
    with TableInfo<$CouponsLinkedToTermsTable, couponsLinkedToTerms> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CouponsLinkedToTermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _couponIdMeta =
      const VerificationMeta('couponId');
  @override
  late final GeneratedColumn<int> couponId = GeneratedColumn<int>(
      'couponId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'termId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [couponId, termId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coupons_linked_to_terms';
  @override
  VerificationContext validateIntegrity(
      Insertable<couponsLinkedToTerms> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('couponId')) {
      context.handle(_couponIdMeta,
          couponId.isAcceptableOrUnknown(data['couponId']!, _couponIdMeta));
    } else if (isInserting) {
      context.missing(_couponIdMeta);
    }
    if (data.containsKey('termId')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['termId']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {couponId, termId};
  @override
  couponsLinkedToTerms map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return couponsLinkedToTerms(
      couponId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}couponId'])!,
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
    );
  }

  @override
  $CouponsLinkedToTermsTable createAlias(String alias) {
    return $CouponsLinkedToTermsTable(attachedDatabase, alias);
  }
}

class couponsLinkedToTerms extends DataClass
    implements Insertable<couponsLinkedToTerms> {
  final int couponId;
  final int termId;
  const couponsLinkedToTerms({required this.couponId, required this.termId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['couponId'] = Variable<int>(couponId);
    map['termId'] = Variable<int>(termId);
    return map;
  }

  CouponsLinkedToTermsCompanion toCompanion(bool nullToAbsent) {
    return CouponsLinkedToTermsCompanion(
      couponId: Value(couponId),
      termId: Value(termId),
    );
  }

  factory couponsLinkedToTerms.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return couponsLinkedToTerms(
      couponId: serializer.fromJson<int>(json['couponId']),
      termId: serializer.fromJson<int>(json['termId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'couponId': serializer.toJson<int>(couponId),
      'termId': serializer.toJson<int>(termId),
    };
  }

  couponsLinkedToTerms copyWith({int? couponId, int? termId}) =>
      couponsLinkedToTerms(
        couponId: couponId ?? this.couponId,
        termId: termId ?? this.termId,
      );
  @override
  String toString() {
    return (StringBuffer('couponsLinkedToTerms(')
          ..write('couponId: $couponId, ')
          ..write('termId: $termId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(couponId, termId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is couponsLinkedToTerms &&
          other.couponId == this.couponId &&
          other.termId == this.termId);
}

class CouponsLinkedToTermsCompanion
    extends UpdateCompanion<couponsLinkedToTerms> {
  final Value<int> couponId;
  final Value<int> termId;
  final Value<int> rowid;
  const CouponsLinkedToTermsCompanion({
    this.couponId = const Value.absent(),
    this.termId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CouponsLinkedToTermsCompanion.insert({
    required int couponId,
    required int termId,
    this.rowid = const Value.absent(),
  })  : couponId = Value(couponId),
        termId = Value(termId);
  static Insertable<couponsLinkedToTerms> custom({
    Expression<int>? couponId,
    Expression<int>? termId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (couponId != null) 'couponId': couponId,
      if (termId != null) 'termId': termId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CouponsLinkedToTermsCompanion copyWith(
      {Value<int>? couponId, Value<int>? termId, Value<int>? rowid}) {
    return CouponsLinkedToTermsCompanion(
      couponId: couponId ?? this.couponId,
      termId: termId ?? this.termId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (couponId.present) {
      map['couponId'] = Variable<int>(couponId.value);
    }
    if (termId.present) {
      map['termId'] = Variable<int>(termId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CouponsLinkedToTermsCompanion(')
          ..write('couponId: $couponId, ')
          ..write('termId: $termId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermTreesTable extends TermTrees
    with TableInfo<$TermTreesTable, termTrees> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermTreesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'termId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
      'depth', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [termId, parentTermId, depth];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_trees';
  @override
  VerificationContext validateIntegrity(Insertable<termTrees> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('termId')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['termId']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('parentTermId')) {
      context.handle(
          _parentTermIdMeta,
          parentTermId.isAcceptableOrUnknown(
              data['parentTermId']!, _parentTermIdMeta));
    } else if (isInserting) {
      context.missing(_parentTermIdMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {termId, parentTermId, depth};
  @override
  termTrees map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return termTrees(
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
    );
  }

  @override
  $TermTreesTable createAlias(String alias) {
    return $TermTreesTable(attachedDatabase, alias);
  }
}

class termTrees extends DataClass implements Insertable<termTrees> {
  final int termId;
  final int parentTermId;
  final int depth;
  const termTrees(
      {required this.termId, required this.parentTermId, required this.depth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['termId'] = Variable<int>(termId);
    map['parentTermId'] = Variable<int>(parentTermId);
    map['depth'] = Variable<int>(depth);
    return map;
  }

  TermTreesCompanion toCompanion(bool nullToAbsent) {
    return TermTreesCompanion(
      termId: Value(termId),
      parentTermId: Value(parentTermId),
      depth: Value(depth),
    );
  }

  factory termTrees.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return termTrees(
      termId: serializer.fromJson<int>(json['termId']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termId': serializer.toJson<int>(termId),
      'parentTermId': serializer.toJson<int>(parentTermId),
      'depth': serializer.toJson<int>(depth),
    };
  }

  termTrees copyWith({int? termId, int? parentTermId, int? depth}) => termTrees(
        termId: termId ?? this.termId,
        parentTermId: parentTermId ?? this.parentTermId,
        depth: depth ?? this.depth,
      );
  @override
  String toString() {
    return (StringBuffer('termTrees(')
          ..write('termId: $termId, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termId, parentTermId, depth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is termTrees &&
          other.termId == this.termId &&
          other.parentTermId == this.parentTermId &&
          other.depth == this.depth);
}

class TermTreesCompanion extends UpdateCompanion<termTrees> {
  final Value<int> termId;
  final Value<int> parentTermId;
  final Value<int> depth;
  final Value<int> rowid;
  const TermTreesCompanion({
    this.termId = const Value.absent(),
    this.parentTermId = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermTreesCompanion.insert({
    required int termId,
    required int parentTermId,
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : termId = Value(termId),
        parentTermId = Value(parentTermId);
  static Insertable<termTrees> custom({
    Expression<int>? termId,
    Expression<int>? parentTermId,
    Expression<int>? depth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termId != null) 'termId': termId,
      if (parentTermId != null) 'parentTermId': parentTermId,
      if (depth != null) 'depth': depth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermTreesCompanion copyWith(
      {Value<int>? termId,
      Value<int>? parentTermId,
      Value<int>? depth,
      Value<int>? rowid}) {
    return TermTreesCompanion(
      termId: termId ?? this.termId,
      parentTermId: parentTermId ?? this.parentTermId,
      depth: depth ?? this.depth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termId.present) {
      map['termId'] = Variable<int>(termId.value);
    }
    if (parentTermId.present) {
      map['parentTermId'] = Variable<int>(parentTermId.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermTreesCompanion(')
          ..write('termId: $termId, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('depth: $depth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EbooksTable extends Ebooks with TableInfo<$EbooksTable, ebooks> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EbooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _encryptionKeyMeta =
      const VerificationMeta('encryptionKey');
  @override
  late final GeneratedColumn<String> encryptionKey = GeneratedColumn<String>(
      'encryptionKey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'lastUpdated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [encryptionKey, parentTermId, creation, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ebooks';
  @override
  VerificationContext validateIntegrity(Insertable<ebooks> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('encryptionKey')) {
      context.handle(
          _encryptionKeyMeta,
          encryptionKey.isAcceptableOrUnknown(
              data['encryptionKey']!, _encryptionKeyMeta));
    } else if (isInserting) {
      context.missing(_encryptionKeyMeta);
    }
    if (data.containsKey('parentTermId')) {
      context.handle(
          _parentTermIdMeta,
          parentTermId.isAcceptableOrUnknown(
              data['parentTermId']!, _parentTermIdMeta));
    }
    if (data.containsKey('creation')) {
      context.handle(_creationMeta,
          creation.isAcceptableOrUnknown(data['creation']!, _creationMeta));
    } else if (isInserting) {
      context.missing(_creationMeta);
    }
    if (data.containsKey('lastUpdated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['lastUpdated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {parentTermId};
  @override
  ebooks map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ebooks(
      encryptionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}encryptionKey'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}lastUpdated'])!,
    );
  }

  @override
  $EbooksTable createAlias(String alias) {
    return $EbooksTable(attachedDatabase, alias);
  }
}

class ebooks extends DataClass implements Insertable<ebooks> {
  final String encryptionKey;
  final int parentTermId;
  final DateTime creation;
  final DateTime lastUpdated;
  const ebooks(
      {required this.encryptionKey,
      required this.parentTermId,
      required this.creation,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['encryptionKey'] = Variable<String>(encryptionKey);
    map['parentTermId'] = Variable<int>(parentTermId);
    map['creation'] = Variable<DateTime>(creation);
    map['lastUpdated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  EbooksCompanion toCompanion(bool nullToAbsent) {
    return EbooksCompanion(
      encryptionKey: Value(encryptionKey),
      parentTermId: Value(parentTermId),
      creation: Value(creation),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ebooks.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ebooks(
      encryptionKey: serializer.fromJson<String>(json['encryptionKey']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'encryptionKey': serializer.toJson<String>(encryptionKey),
      'parentTermId': serializer.toJson<int>(parentTermId),
      'creation': serializer.toJson<DateTime>(creation),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ebooks copyWith(
          {String? encryptionKey,
          int? parentTermId,
          DateTime? creation,
          DateTime? lastUpdated}) =>
      ebooks(
        encryptionKey: encryptionKey ?? this.encryptionKey,
        parentTermId: parentTermId ?? this.parentTermId,
        creation: creation ?? this.creation,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('ebooks(')
          ..write('encryptionKey: $encryptionKey, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('creation: $creation, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(encryptionKey, parentTermId, creation, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ebooks &&
          other.encryptionKey == this.encryptionKey &&
          other.parentTermId == this.parentTermId &&
          other.creation == this.creation &&
          other.lastUpdated == this.lastUpdated);
}

class EbooksCompanion extends UpdateCompanion<ebooks> {
  final Value<String> encryptionKey;
  final Value<int> parentTermId;
  final Value<DateTime> creation;
  final Value<DateTime> lastUpdated;
  const EbooksCompanion({
    this.encryptionKey = const Value.absent(),
    this.parentTermId = const Value.absent(),
    this.creation = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  EbooksCompanion.insert({
    required String encryptionKey,
    this.parentTermId = const Value.absent(),
    required DateTime creation,
    required DateTime lastUpdated,
  })  : encryptionKey = Value(encryptionKey),
        creation = Value(creation),
        lastUpdated = Value(lastUpdated);
  static Insertable<ebooks> custom({
    Expression<String>? encryptionKey,
    Expression<int>? parentTermId,
    Expression<DateTime>? creation,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (encryptionKey != null) 'encryptionKey': encryptionKey,
      if (parentTermId != null) 'parentTermId': parentTermId,
      if (creation != null) 'creation': creation,
      if (lastUpdated != null) 'lastUpdated': lastUpdated,
    });
  }

  EbooksCompanion copyWith(
      {Value<String>? encryptionKey,
      Value<int>? parentTermId,
      Value<DateTime>? creation,
      Value<DateTime>? lastUpdated}) {
    return EbooksCompanion(
      encryptionKey: encryptionKey ?? this.encryptionKey,
      parentTermId: parentTermId ?? this.parentTermId,
      creation: creation ?? this.creation,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (encryptionKey.present) {
      map['encryptionKey'] = Variable<String>(encryptionKey.value);
    }
    if (parentTermId.present) {
      map['parentTermId'] = Variable<int>(parentTermId.value);
    }
    if (creation.present) {
      map['creation'] = Variable<DateTime>(creation.value);
    }
    if (lastUpdated.present) {
      map['lastUpdated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EbooksCompanion(')
          ..write('encryptionKey: $encryptionKey, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('creation: $creation, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $TermsLastAccessesTable extends TermsLastAccesses
    with TableInfo<$TermsLastAccessesTable, termsLastAccess> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsLastAccessesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'childId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessMeta =
      const VerificationMeta('lastAccess');
  @override
  late final GeneratedColumn<DateTime> lastAccess = GeneratedColumn<DateTime>(
      'lastAccess', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [parentTermId, childId, lastAccess];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terms_last_accesses';
  @override
  VerificationContext validateIntegrity(Insertable<termsLastAccess> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('parentTermId')) {
      context.handle(
          _parentTermIdMeta,
          parentTermId.isAcceptableOrUnknown(
              data['parentTermId']!, _parentTermIdMeta));
    } else if (isInserting) {
      context.missing(_parentTermIdMeta);
    }
    if (data.containsKey('childId')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['childId']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('lastAccess')) {
      context.handle(
          _lastAccessMeta,
          lastAccess.isAcceptableOrUnknown(
              data['lastAccess']!, _lastAccessMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {parentTermId, childId};
  @override
  termsLastAccess map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return termsLastAccess(
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}childId'])!,
      lastAccess: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}lastAccess'])!,
    );
  }

  @override
  $TermsLastAccessesTable createAlias(String alias) {
    return $TermsLastAccessesTable(attachedDatabase, alias);
  }
}

class termsLastAccess extends DataClass implements Insertable<termsLastAccess> {
  final int parentTermId;
  final int childId;
  final DateTime lastAccess;
  const termsLastAccess(
      {required this.parentTermId,
      required this.childId,
      required this.lastAccess});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['parentTermId'] = Variable<int>(parentTermId);
    map['childId'] = Variable<int>(childId);
    map['lastAccess'] = Variable<DateTime>(lastAccess);
    return map;
  }

  TermsLastAccessesCompanion toCompanion(bool nullToAbsent) {
    return TermsLastAccessesCompanion(
      parentTermId: Value(parentTermId),
      childId: Value(childId),
      lastAccess: Value(lastAccess),
    );
  }

  factory termsLastAccess.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return termsLastAccess(
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      childId: serializer.fromJson<int>(json['childId']),
      lastAccess: serializer.fromJson<DateTime>(json['lastAccess']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parentTermId': serializer.toJson<int>(parentTermId),
      'childId': serializer.toJson<int>(childId),
      'lastAccess': serializer.toJson<DateTime>(lastAccess),
    };
  }

  termsLastAccess copyWith(
          {int? parentTermId, int? childId, DateTime? lastAccess}) =>
      termsLastAccess(
        parentTermId: parentTermId ?? this.parentTermId,
        childId: childId ?? this.childId,
        lastAccess: lastAccess ?? this.lastAccess,
      );
  @override
  String toString() {
    return (StringBuffer('termsLastAccess(')
          ..write('parentTermId: $parentTermId, ')
          ..write('childId: $childId, ')
          ..write('lastAccess: $lastAccess')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(parentTermId, childId, lastAccess);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is termsLastAccess &&
          other.parentTermId == this.parentTermId &&
          other.childId == this.childId &&
          other.lastAccess == this.lastAccess);
}

class TermsLastAccessesCompanion extends UpdateCompanion<termsLastAccess> {
  final Value<int> parentTermId;
  final Value<int> childId;
  final Value<DateTime> lastAccess;
  final Value<int> rowid;
  const TermsLastAccessesCompanion({
    this.parentTermId = const Value.absent(),
    this.childId = const Value.absent(),
    this.lastAccess = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermsLastAccessesCompanion.insert({
    required int parentTermId,
    required int childId,
    this.lastAccess = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : parentTermId = Value(parentTermId),
        childId = Value(childId);
  static Insertable<termsLastAccess> custom({
    Expression<int>? parentTermId,
    Expression<int>? childId,
    Expression<DateTime>? lastAccess,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (parentTermId != null) 'parentTermId': parentTermId,
      if (childId != null) 'childId': childId,
      if (lastAccess != null) 'lastAccess': lastAccess,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermsLastAccessesCompanion copyWith(
      {Value<int>? parentTermId,
      Value<int>? childId,
      Value<DateTime>? lastAccess,
      Value<int>? rowid}) {
    return TermsLastAccessesCompanion(
      parentTermId: parentTermId ?? this.parentTermId,
      childId: childId ?? this.childId,
      lastAccess: lastAccess ?? this.lastAccess,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (parentTermId.present) {
      map['parentTermId'] = Variable<int>(parentTermId.value);
    }
    if (childId.present) {
      map['childId'] = Variable<int>(childId.value);
    }
    if (lastAccess.present) {
      map['lastAccess'] = Variable<DateTime>(lastAccess.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsLastAccessesCompanion(')
          ..write('parentTermId: $parentTermId, ')
          ..write('childId: $childId, ')
          ..write('lastAccess: $lastAccess, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionTagPropertiesTable extends QuestionTagProperties
    with TableInfo<$QuestionTagPropertiesTable, questionTagProperties> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTagPropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionTagIdMeta =
      const VerificationMeta('questionTagId');
  @override
  late final GeneratedColumn<int> questionTagId = GeneratedColumn<int>(
      'questionTagId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [questionTagId, name, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_tag_properties';
  @override
  VerificationContext validateIntegrity(
      Insertable<questionTagProperties> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('questionTagId')) {
      context.handle(
          _questionTagIdMeta,
          questionTagId.isAcceptableOrUnknown(
              data['questionTagId']!, _questionTagIdMeta));
    } else if (isInserting) {
      context.missing(_questionTagIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionTagId, name};
  @override
  questionTagProperties map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return questionTagProperties(
      questionTagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}questionTagId'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $QuestionTagPropertiesTable createAlias(String alias) {
    return $QuestionTagPropertiesTable(attachedDatabase, alias);
  }
}

class questionTagProperties extends DataClass
    implements Insertable<questionTagProperties> {
  final int questionTagId;
  final String name;
  final String value;
  const questionTagProperties(
      {required this.questionTagId, required this.name, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['questionTagId'] = Variable<int>(questionTagId);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    return map;
  }

  QuestionTagPropertiesCompanion toCompanion(bool nullToAbsent) {
    return QuestionTagPropertiesCompanion(
      questionTagId: Value(questionTagId),
      name: Value(name),
      value: Value(value),
    );
  }

  factory questionTagProperties.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return questionTagProperties(
      questionTagId: serializer.fromJson<int>(json['questionTagId']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionTagId': serializer.toJson<int>(questionTagId),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  questionTagProperties copyWith(
          {int? questionTagId, String? name, String? value}) =>
      questionTagProperties(
        questionTagId: questionTagId ?? this.questionTagId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('questionTagProperties(')
          ..write('questionTagId: $questionTagId, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionTagId, name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is questionTagProperties &&
          other.questionTagId == this.questionTagId &&
          other.name == this.name &&
          other.value == this.value);
}

class QuestionTagPropertiesCompanion
    extends UpdateCompanion<questionTagProperties> {
  final Value<int> questionTagId;
  final Value<String> name;
  final Value<String> value;
  final Value<int> rowid;
  const QuestionTagPropertiesCompanion({
    this.questionTagId = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionTagPropertiesCompanion.insert({
    required int questionTagId,
    required String name,
    required String value,
    this.rowid = const Value.absent(),
  })  : questionTagId = Value(questionTagId),
        name = Value(name),
        value = Value(value);
  static Insertable<questionTagProperties> custom({
    Expression<int>? questionTagId,
    Expression<String>? name,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionTagId != null) 'questionTagId': questionTagId,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionTagPropertiesCompanion copyWith(
      {Value<int>? questionTagId,
      Value<String>? name,
      Value<String>? value,
      Value<int>? rowid}) {
    return QuestionTagPropertiesCompanion(
      questionTagId: questionTagId ?? this.questionTagId,
      name: name ?? this.name,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionTagId.present) {
      map['questionTagId'] = Variable<int>(questionTagId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTagPropertiesCompanion(')
          ..write('questionTagId: $questionTagId, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionPropertiesTable extends QuestionProperties
    with TableInfo<$QuestionPropertiesTable, questionProperties> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionPropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'questionId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [questionId, name, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_properties';
  @override
  VerificationContext validateIntegrity(Insertable<questionProperties> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('questionId')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['questionId']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, name};
  @override
  questionProperties map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return questionProperties(
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}questionId'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $QuestionPropertiesTable createAlias(String alias) {
    return $QuestionPropertiesTable(attachedDatabase, alias);
  }
}

class questionProperties extends DataClass
    implements Insertable<questionProperties> {
  final int questionId;
  final String name;
  final String value;
  const questionProperties(
      {required this.questionId, required this.name, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['questionId'] = Variable<int>(questionId);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    return map;
  }

  QuestionPropertiesCompanion toCompanion(bool nullToAbsent) {
    return QuestionPropertiesCompanion(
      questionId: Value(questionId),
      name: Value(name),
      value: Value(value),
    );
  }

  factory questionProperties.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return questionProperties(
      questionId: serializer.fromJson<int>(json['questionId']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<int>(questionId),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  questionProperties copyWith({int? questionId, String? name, String? value}) =>
      questionProperties(
        questionId: questionId ?? this.questionId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('questionProperties(')
          ..write('questionId: $questionId, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionId, name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is questionProperties &&
          other.questionId == this.questionId &&
          other.name == this.name &&
          other.value == this.value);
}

class QuestionPropertiesCompanion extends UpdateCompanion<questionProperties> {
  final Value<int> questionId;
  final Value<String> name;
  final Value<String> value;
  final Value<int> rowid;
  const QuestionPropertiesCompanion({
    this.questionId = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionPropertiesCompanion.insert({
    required int questionId,
    required String name,
    required String value,
    this.rowid = const Value.absent(),
  })  : questionId = Value(questionId),
        name = Value(name),
        value = Value(value);
  static Insertable<questionProperties> custom({
    Expression<int>? questionId,
    Expression<String>? name,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'questionId': questionId,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionPropertiesCompanion copyWith(
      {Value<int>? questionId,
      Value<String>? name,
      Value<String>? value,
      Value<int>? rowid}) {
    return QuestionPropertiesCompanion(
      questionId: questionId ?? this.questionId,
      name: name ?? this.name,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['questionId'] = Variable<int>(questionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionPropertiesCompanion(')
          ..write('questionId: $questionId, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseService extends GeneratedDatabase {
  _$DatabaseService(QueryExecutor e) : super(e);
  late final $CouponsTable coupons = $CouponsTable(this);
  late final $TermsTable terms = $TermsTable(this);
  late final $AnswersTable answers = $AnswersTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $QuestionTagsTable questionTags = $QuestionTagsTable(this);
  late final $QuestionMediasTable questionMedias = $QuestionMediasTable(this);
  late final $FcmTopicsTable fcmTopics = $FcmTopicsTable(this);
  late final $AnswerPropertiesTable answerProperties =
      $AnswerPropertiesTable(this);
  late final $CouponsLinkedToTermsTable couponsLinkedToTerms =
      $CouponsLinkedToTermsTable(this);
  late final $TermTreesTable termTrees = $TermTreesTable(this);
  late final $EbooksTable ebooks = $EbooksTable(this);
  late final $TermsLastAccessesTable termsLastAccesses =
      $TermsLastAccessesTable(this);
  late final $QuestionTagPropertiesTable questionTagProperties =
      $QuestionTagPropertiesTable(this);
  late final $QuestionPropertiesTable questionProperties =
      $QuestionPropertiesTable(this);
  late final Index parentQuestionIdIndex = Index('parentQuestionIdIndex',
      'CREATE INDEX parentQuestionIdIndex ON answers (parentQuestionId)');
  late final Index qIndex1 =
      Index('qIndex1', 'CREATE INDEX qIndex1 ON questions (parentTermId)');
  late final Index questionTagsIndex1 = Index('questionTagsIndex1',
      'CREATE INDEX questionTagsIndex1 ON question_tags (parentTagId)');
  late final Index questionMediasIndex1 = Index('questionMediasIndex1',
      'CREATE INDEX questionMediasIndex1 ON question_medias (parentQuestionId)');
  late final Index answersIndex1 = Index('answersIndex1',
      'CREATE INDEX answersIndex1 ON answer_properties (answerId)');
  late final Index qtpIndex1 = Index('qtpIndex1',
      'CREATE INDEX qtpIndex1 ON question_tag_properties (questionTagId)');
  late final Index qpIndex1 = Index(
      'qpIndex1', 'CREATE INDEX qpIndex1 ON question_properties (questionId)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        coupons,
        terms,
        answers,
        questions,
        questionTags,
        questionMedias,
        fcmTopics,
        answerProperties,
        couponsLinkedToTerms,
        termTrees,
        ebooks,
        termsLastAccesses,
        questionTagProperties,
        questionProperties,
        parentQuestionIdIndex,
        qIndex1,
        questionTagsIndex1,
        questionMediasIndex1,
        answersIndex1,
        qtpIndex1,
        qpIndex1
      ];
}

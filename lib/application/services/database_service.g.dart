// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $CouponsTable extends Coupons with TableInfo<$CouponsTable, Coupon> {
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
  VerificationContext validateIntegrity(Insertable<Coupon> instance,
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
  Coupon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Coupon(
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

class Coupon extends DataClass implements Insertable<Coupon> {
  final int id;
  final String serial;
  final int type;
  final int free;
  final DateTime creation;
  final DateTime? activationDate;
  final int expirationDays;
  const Coupon(
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

  factory Coupon.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Coupon(
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

  Coupon copyWith(
          {int? id,
          String? serial,
          int? type,
          int? free,
          DateTime? creation,
          Value<DateTime?> activationDate = const Value.absent(),
          int? expirationDays}) =>
      Coupon(
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
    return (StringBuffer('Coupon(')
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
      (other is Coupon &&
          other.id == this.id &&
          other.serial == this.serial &&
          other.type == this.type &&
          other.free == this.free &&
          other.creation == this.creation &&
          other.activationDate == this.activationDate &&
          other.expirationDays == this.expirationDays);
}

class CouponsCompanion extends UpdateCompanion<Coupon> {
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
  static Insertable<Coupon> custom({
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

class $TermsTable extends Terms with TableInfo<$TermsTable, Term> {
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
  VerificationContext validateIntegrity(Insertable<Term> instance,
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
  Term map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Term(
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

class Term extends DataClass implements Insertable<Term> {
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
  const Term(
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

  factory Term.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Term(
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

  Term copyWith(
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
      Term(
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
    return (StringBuffer('Term(')
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
      (other is Term &&
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

class TermsCompanion extends UpdateCompanion<Term> {
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
  static Insertable<Term> custom({
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

class $AnswersTable extends Answers with TableInfo<$AnswersTable, Answer> {
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
  VerificationContext validateIntegrity(Insertable<Answer> instance,
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
  Answer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Answer(
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

class Answer extends DataClass implements Insertable<Answer> {
  final int id;
  final String uuid;
  final String title;
  final String titleTranslation;
  final int isCorrect;
  final int parentQuestionId;
  final int specialCharacter;
  final DateTime creation;
  final int checkedCount;
  const Answer(
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

  factory Answer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Answer(
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

  Answer copyWith(
          {int? id,
          String? uuid,
          String? title,
          String? titleTranslation,
          int? isCorrect,
          int? parentQuestionId,
          int? specialCharacter,
          DateTime? creation,
          int? checkedCount}) =>
      Answer(
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
    return (StringBuffer('Answer(')
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
      (other is Answer &&
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

class AnswersCompanion extends UpdateCompanion<Answer> {
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
  static Insertable<Answer> custom({
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
    with TableInfo<$QuestionsTable, Question> {
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
  VerificationContext validateIntegrity(Insertable<Question> instance,
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
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
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

class Question extends DataClass implements Insertable<Question> {
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
  const Question(
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

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
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

  Question copyWith(
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
      Question(
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
    return (StringBuffer('Question(')
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
      (other is Question &&
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

class QuestionsCompanion extends UpdateCompanion<Question> {
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
  static Insertable<Question> custom({
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
    with TableInfo<$QuestionTagsTable, QuestionTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const String $name = 'questionTags';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionTag> instance,
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionTag(
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

class QuestionTag extends DataClass implements Insertable<QuestionTag> {
  final int id;
  final String name;
  final int parentTagId;
  final int hasInformation;
  final DateTime creation;
  const QuestionTag(
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

  factory QuestionTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionTag(
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

  QuestionTag copyWith(
          {int? id,
          String? name,
          int? parentTagId,
          int? hasInformation,
          DateTime? creation}) =>
      QuestionTag(
        id: id ?? this.id,
        name: name ?? this.name,
        parentTagId: parentTagId ?? this.parentTagId,
        hasInformation: hasInformation ?? this.hasInformation,
        creation: creation ?? this.creation,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionTag(')
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
      (other is QuestionTag &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentTagId == this.parentTagId &&
          other.hasInformation == this.hasInformation &&
          other.creation == this.creation);
}

class QuestionTagsCompanion extends UpdateCompanion<QuestionTag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> parentTagId;
  final Value<int> hasInformation;
  final Value<DateTime> creation;
  const QuestionTagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentTagId = const Value.absent(),
    this.hasInformation = const Value.absent(),
    this.creation = const Value.absent(),
  });
  QuestionTagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int parentTagId,
    this.hasInformation = const Value.absent(),
    required DateTime creation,
  })  : name = Value(name),
        parentTagId = Value(parentTagId),
        creation = Value(creation);
  static Insertable<QuestionTag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? parentTagId,
    Expression<int>? hasInformation,
    Expression<DateTime>? creation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentTagId != null) 'parentTagId': parentTagId,
      if (hasInformation != null) 'hasInformation': hasInformation,
      if (creation != null) 'creation': creation,
    });
  }

  QuestionTagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? parentTagId,
      Value<int>? hasInformation,
      Value<DateTime>? creation}) {
    return QuestionTagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentTagId: parentTagId ?? this.parentTagId,
      hasInformation: hasInformation ?? this.hasInformation,
      creation: creation ?? this.creation,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentTagId: $parentTagId, ')
          ..write('hasInformation: $hasInformation, ')
          ..write('creation: $creation')
          ..write(')'))
        .toString();
  }
}

class $QuestionMediasTable extends QuestionMedias
    with TableInfo<$QuestionMediasTable, QuestionMedia> {
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
  static const String $name = 'questionMedias';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionMedia> instance,
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
  QuestionMedia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionMedia(
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

class QuestionMedia extends DataClass implements Insertable<QuestionMedia> {
  final int id;
  final String url;
  final int parentQuestionId;
  final DateTime creation;
  const QuestionMedia(
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

  factory QuestionMedia.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionMedia(
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

  QuestionMedia copyWith(
          {int? id, String? url, int? parentQuestionId, DateTime? creation}) =>
      QuestionMedia(
        id: id ?? this.id,
        url: url ?? this.url,
        parentQuestionId: parentQuestionId ?? this.parentQuestionId,
        creation: creation ?? this.creation,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionMedia(')
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
      (other is QuestionMedia &&
          other.id == this.id &&
          other.url == this.url &&
          other.parentQuestionId == this.parentQuestionId &&
          other.creation == this.creation);
}

class QuestionMediasCompanion extends UpdateCompanion<QuestionMedia> {
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
  static Insertable<QuestionMedia> custom({
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
    with TableInfo<$FcmTopicsTable, FcmTopic> {
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
  @override
  List<GeneratedColumn> get $columns => [title, subscriptionSucceed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'FCMTopics';
  @override
  VerificationContext validateIntegrity(Insertable<FcmTopic> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  FcmTopic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FcmTopic(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subscriptionSucceed: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}subscriptionSucceed'])!,
    );
  }

  @override
  $FcmTopicsTable createAlias(String alias) {
    return $FcmTopicsTable(attachedDatabase, alias);
  }
}

class FcmTopic extends DataClass implements Insertable<FcmTopic> {
  final String title;
  final bool subscriptionSucceed;
  const FcmTopic({required this.title, required this.subscriptionSucceed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['subscriptionSucceed'] = Variable<bool>(subscriptionSucceed);
    return map;
  }

  FcmTopicsCompanion toCompanion(bool nullToAbsent) {
    return FcmTopicsCompanion(
      title: Value(title),
      subscriptionSucceed: Value(subscriptionSucceed),
    );
  }

  factory FcmTopic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FcmTopic(
      title: serializer.fromJson<String>(json['title']),
      subscriptionSucceed:
          serializer.fromJson<bool>(json['subscriptionSucceed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'subscriptionSucceed': serializer.toJson<bool>(subscriptionSucceed),
    };
  }

  FcmTopic copyWith({String? title, bool? subscriptionSucceed}) => FcmTopic(
        title: title ?? this.title,
        subscriptionSucceed: subscriptionSucceed ?? this.subscriptionSucceed,
      );
  @override
  String toString() {
    return (StringBuffer('FcmTopic(')
          ..write('title: $title, ')
          ..write('subscriptionSucceed: $subscriptionSucceed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, subscriptionSucceed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FcmTopic &&
          other.title == this.title &&
          other.subscriptionSucceed == this.subscriptionSucceed);
}

class FcmTopicsCompanion extends UpdateCompanion<FcmTopic> {
  final Value<String> title;
  final Value<bool> subscriptionSucceed;
  final Value<int> rowid;
  const FcmTopicsCompanion({
    this.title = const Value.absent(),
    this.subscriptionSucceed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FcmTopicsCompanion.insert({
    required String title,
    required bool subscriptionSucceed,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        subscriptionSucceed = Value(subscriptionSucceed);
  static Insertable<FcmTopic> custom({
    Expression<String>? title,
    Expression<bool>? subscriptionSucceed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (subscriptionSucceed != null)
        'subscriptionSucceed': subscriptionSucceed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FcmTopicsCompanion copyWith(
      {Value<String>? title,
      Value<bool>? subscriptionSucceed,
      Value<int>? rowid}) {
    return FcmTopicsCompanion(
      title: title ?? this.title,
      subscriptionSucceed: subscriptionSucceed ?? this.subscriptionSucceed,
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswerPropertiesTable extends AnswerProperties
    with TableInfo<$AnswerPropertiesTable, AnswerProperty> {
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
  static const String $name = 'answerProperties';
  @override
  VerificationContext validateIntegrity(Insertable<AnswerProperty> instance,
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
  AnswerProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerProperty(
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

class AnswerProperty extends DataClass implements Insertable<AnswerProperty> {
  final int answerId;
  final String name;
  final String value;
  const AnswerProperty(
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

  factory AnswerProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerProperty(
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

  AnswerProperty copyWith({int? answerId, String? name, String? value}) =>
      AnswerProperty(
        answerId: answerId ?? this.answerId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('AnswerProperty(')
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
      (other is AnswerProperty &&
          other.answerId == this.answerId &&
          other.name == this.name &&
          other.value == this.value);
}

class AnswerPropertiesCompanion extends UpdateCompanion<AnswerProperty> {
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
  static Insertable<AnswerProperty> custom({
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
    with TableInfo<$CouponsLinkedToTermsTable, CouponsLinkedToTerm> {
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
  static const String $name = 'couponsLinkedToTerms';
  @override
  VerificationContext validateIntegrity(
      Insertable<CouponsLinkedToTerm> instance,
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
  CouponsLinkedToTerm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CouponsLinkedToTerm(
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

class CouponsLinkedToTerm extends DataClass
    implements Insertable<CouponsLinkedToTerm> {
  final int couponId;
  final int termId;
  const CouponsLinkedToTerm({required this.couponId, required this.termId});
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

  factory CouponsLinkedToTerm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CouponsLinkedToTerm(
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

  CouponsLinkedToTerm copyWith({int? couponId, int? termId}) =>
      CouponsLinkedToTerm(
        couponId: couponId ?? this.couponId,
        termId: termId ?? this.termId,
      );
  @override
  String toString() {
    return (StringBuffer('CouponsLinkedToTerm(')
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
      (other is CouponsLinkedToTerm &&
          other.couponId == this.couponId &&
          other.termId == this.termId);
}

class CouponsLinkedToTermsCompanion
    extends UpdateCompanion<CouponsLinkedToTerm> {
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
  static Insertable<CouponsLinkedToTerm> custom({
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
    with TableInfo<$TermTreesTable, TermTree> {
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
  static const String $name = 'termTrees';
  @override
  VerificationContext validateIntegrity(Insertable<TermTree> instance,
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
  TermTree map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermTree(
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

class TermTree extends DataClass implements Insertable<TermTree> {
  final int termId;
  final int parentTermId;
  final int depth;
  const TermTree(
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

  factory TermTree.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermTree(
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

  TermTree copyWith({int? termId, int? parentTermId, int? depth}) => TermTree(
        termId: termId ?? this.termId,
        parentTermId: parentTermId ?? this.parentTermId,
        depth: depth ?? this.depth,
      );
  @override
  String toString() {
    return (StringBuffer('TermTree(')
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
      (other is TermTree &&
          other.termId == this.termId &&
          other.parentTermId == this.parentTermId &&
          other.depth == this.depth);
}

class TermTreesCompanion extends UpdateCompanion<TermTree> {
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
  static Insertable<TermTree> custom({
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

class $EbooksTable extends Ebooks with TableInfo<$EbooksTable, Ebook> {
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
  VerificationContext validateIntegrity(Insertable<Ebook> instance,
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
  Ebook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ebook(
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

class Ebook extends DataClass implements Insertable<Ebook> {
  final String encryptionKey;
  final int parentTermId;
  final DateTime creation;
  final DateTime lastUpdated;
  const Ebook(
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

  factory Ebook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ebook(
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

  Ebook copyWith(
          {String? encryptionKey,
          int? parentTermId,
          DateTime? creation,
          DateTime? lastUpdated}) =>
      Ebook(
        encryptionKey: encryptionKey ?? this.encryptionKey,
        parentTermId: parentTermId ?? this.parentTermId,
        creation: creation ?? this.creation,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('Ebook(')
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
      (other is Ebook &&
          other.encryptionKey == this.encryptionKey &&
          other.parentTermId == this.parentTermId &&
          other.creation == this.creation &&
          other.lastUpdated == this.lastUpdated);
}

class EbooksCompanion extends UpdateCompanion<Ebook> {
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
  static Insertable<Ebook> custom({
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
    with TableInfo<$TermsLastAccessesTable, TermsLastAccess> {
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
  static const String $name = 'termsLastAccess';
  @override
  VerificationContext validateIntegrity(Insertable<TermsLastAccess> instance,
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
  TermsLastAccess map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsLastAccess(
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

class TermsLastAccess extends DataClass implements Insertable<TermsLastAccess> {
  final int parentTermId;
  final int childId;
  final DateTime lastAccess;
  const TermsLastAccess(
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

  factory TermsLastAccess.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsLastAccess(
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

  TermsLastAccess copyWith(
          {int? parentTermId, int? childId, DateTime? lastAccess}) =>
      TermsLastAccess(
        parentTermId: parentTermId ?? this.parentTermId,
        childId: childId ?? this.childId,
        lastAccess: lastAccess ?? this.lastAccess,
      );
  @override
  String toString() {
    return (StringBuffer('TermsLastAccess(')
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
      (other is TermsLastAccess &&
          other.parentTermId == this.parentTermId &&
          other.childId == this.childId &&
          other.lastAccess == this.lastAccess);
}

class TermsLastAccessesCompanion extends UpdateCompanion<TermsLastAccess> {
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
  static Insertable<TermsLastAccess> custom({
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
    with TableInfo<$QuestionTagPropertiesTable, QuestionTagProperty> {
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
  static const String $name = 'questionTagProperties';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionTagProperty> instance,
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
  QuestionTagProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionTagProperty(
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

class QuestionTagProperty extends DataClass
    implements Insertable<QuestionTagProperty> {
  final int questionTagId;
  final String name;
  final String value;
  const QuestionTagProperty(
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

  factory QuestionTagProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionTagProperty(
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

  QuestionTagProperty copyWith(
          {int? questionTagId, String? name, String? value}) =>
      QuestionTagProperty(
        questionTagId: questionTagId ?? this.questionTagId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionTagProperty(')
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
      (other is QuestionTagProperty &&
          other.questionTagId == this.questionTagId &&
          other.name == this.name &&
          other.value == this.value);
}

class QuestionTagPropertiesCompanion
    extends UpdateCompanion<QuestionTagProperty> {
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
  static Insertable<QuestionTagProperty> custom({
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
    with TableInfo<$QuestionPropertiesTable, QuestionProperty> {
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
  static const String $name = 'questionProperties';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionProperty> instance,
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
  QuestionProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionProperty(
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

class QuestionProperty extends DataClass
    implements Insertable<QuestionProperty> {
  final int questionId;
  final String name;
  final String value;
  const QuestionProperty(
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

  factory QuestionProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionProperty(
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

  QuestionProperty copyWith({int? questionId, String? name, String? value}) =>
      QuestionProperty(
        questionId: questionId ?? this.questionId,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionProperty(')
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
      (other is QuestionProperty &&
          other.questionId == this.questionId &&
          other.name == this.name &&
          other.value == this.value);
}

class QuestionPropertiesCompanion extends UpdateCompanion<QuestionProperty> {
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
  static Insertable<QuestionProperty> custom({
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

class $HttpRequestsTable extends HttpRequests
    with TableInfo<$HttpRequestsTable, HttpRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HttpRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mappMeta = const VerificationMeta('mapp');
  @override
  late final GeneratedColumn<String> mapp = GeneratedColumn<String>(
      'map', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, url, mapp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'httpRequests';
  @override
  VerificationContext validateIntegrity(Insertable<HttpRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('map')) {
      context.handle(
          _mappMeta, mapp.isAcceptableOrUnknown(data['map']!, _mappMeta));
    } else if (isInserting) {
      context.missing(_mappMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HttpRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      mapp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}map'])!,
    );
  }

  @override
  $HttpRequestsTable createAlias(String alias) {
    return $HttpRequestsTable(attachedDatabase, alias);
  }
}

class HttpRequest extends DataClass implements Insertable<HttpRequest> {
  final int id;
  final String url;
  final String mapp;
  const HttpRequest({required this.id, required this.url, required this.mapp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['map'] = Variable<String>(mapp);
    return map;
  }

  HttpRequestsCompanion toCompanion(bool nullToAbsent) {
    return HttpRequestsCompanion(
      id: Value(id),
      url: Value(url),
      mapp: Value(mapp),
    );
  }

  factory HttpRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpRequest(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      mapp: serializer.fromJson<String>(json['mapp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'mapp': serializer.toJson<String>(mapp),
    };
  }

  HttpRequest copyWith({int? id, String? url, String? mapp}) => HttpRequest(
        id: id ?? this.id,
        url: url ?? this.url,
        mapp: mapp ?? this.mapp,
      );
  @override
  String toString() {
    return (StringBuffer('HttpRequest(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('mapp: $mapp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, mapp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpRequest &&
          other.id == this.id &&
          other.url == this.url &&
          other.mapp == this.mapp);
}

class HttpRequestsCompanion extends UpdateCompanion<HttpRequest> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> mapp;
  const HttpRequestsCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.mapp = const Value.absent(),
  });
  HttpRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String url,
    required String mapp,
  })  : url = Value(url),
        mapp = Value(mapp);
  static Insertable<HttpRequest> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? mapp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (mapp != null) 'map': mapp,
    });
  }

  HttpRequestsCompanion copyWith(
      {Value<int>? id, Value<String>? url, Value<String>? mapp}) {
    return HttpRequestsCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      mapp: mapp ?? this.mapp,
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
    if (mapp.present) {
      map['map'] = Variable<String>(mapp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpRequestsCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('mapp: $mapp')
          ..write(')'))
        .toString();
  }
}

class $TermsWithQuestionsFilteringEnabledTable
    extends TermsWithQuestionsFilteringEnabled
    with
        TableInfo<$TermsWithQuestionsFilteringEnabledTable,
            TermsWithQuestionsFilteringEnabledData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsWithQuestionsFilteringEnabledTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'term_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [termId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsWithQuestionsFilteringEnabled';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermsWithQuestionsFilteringEnabledData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term_id')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['term_id']!, _termIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {termId};
  @override
  TermsWithQuestionsFilteringEnabledData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsWithQuestionsFilteringEnabledData(
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}term_id'])!,
    );
  }

  @override
  $TermsWithQuestionsFilteringEnabledTable createAlias(String alias) {
    return $TermsWithQuestionsFilteringEnabledTable(attachedDatabase, alias);
  }
}

class TermsWithQuestionsFilteringEnabledData extends DataClass
    implements Insertable<TermsWithQuestionsFilteringEnabledData> {
  final int termId;
  const TermsWithQuestionsFilteringEnabledData({required this.termId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term_id'] = Variable<int>(termId);
    return map;
  }

  TermsWithQuestionsFilteringEnabledCompanion toCompanion(bool nullToAbsent) {
    return TermsWithQuestionsFilteringEnabledCompanion(
      termId: Value(termId),
    );
  }

  factory TermsWithQuestionsFilteringEnabledData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsWithQuestionsFilteringEnabledData(
      termId: serializer.fromJson<int>(json['termId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termId': serializer.toJson<int>(termId),
    };
  }

  TermsWithQuestionsFilteringEnabledData copyWith({int? termId}) =>
      TermsWithQuestionsFilteringEnabledData(
        termId: termId ?? this.termId,
      );
  @override
  String toString() {
    return (StringBuffer('TermsWithQuestionsFilteringEnabledData(')
          ..write('termId: $termId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => termId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsWithQuestionsFilteringEnabledData &&
          other.termId == this.termId);
}

class TermsWithQuestionsFilteringEnabledCompanion
    extends UpdateCompanion<TermsWithQuestionsFilteringEnabledData> {
  final Value<int> termId;
  const TermsWithQuestionsFilteringEnabledCompanion({
    this.termId = const Value.absent(),
  });
  TermsWithQuestionsFilteringEnabledCompanion.insert({
    this.termId = const Value.absent(),
  });
  static Insertable<TermsWithQuestionsFilteringEnabledData> custom({
    Expression<int>? termId,
  }) {
    return RawValuesInsertable({
      if (termId != null) 'term_id': termId,
    });
  }

  TermsWithQuestionsFilteringEnabledCompanion copyWith({Value<int>? termId}) {
    return TermsWithQuestionsFilteringEnabledCompanion(
      termId: termId ?? this.termId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termId.present) {
      map['term_id'] = Variable<int>(termId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsWithQuestionsFilteringEnabledCompanion(')
          ..write('termId: $termId')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards
    with TableInfo<$FlashcardsTable, Flashcard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _headMeta = const VerificationMeta('head');
  @override
  late final GeneratedColumn<String> head = GeneratedColumn<String>(
      'head', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tailMeta = const VerificationMeta('tail');
  @override
  late final GeneratedColumn<String> tail = GeneratedColumn<String>(
      'tail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, head, tail, parentTermId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(Insertable<Flashcard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('head')) {
      context.handle(
          _headMeta, head.isAcceptableOrUnknown(data['head']!, _headMeta));
    } else if (isInserting) {
      context.missing(_headMeta);
    }
    if (data.containsKey('tail')) {
      context.handle(
          _tailMeta, tail.isAcceptableOrUnknown(data['tail']!, _tailMeta));
    } else if (isInserting) {
      context.missing(_tailMeta);
    }
    if (data.containsKey('parentTermId')) {
      context.handle(
          _parentTermIdMeta,
          parentTermId.isAcceptableOrUnknown(
              data['parentTermId']!, _parentTermIdMeta));
    } else if (isInserting) {
      context.missing(_parentTermIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Flashcard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Flashcard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      head: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}head'])!,
      tail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tail'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class Flashcard extends DataClass implements Insertable<Flashcard> {
  final int id;
  final String head;
  final String tail;
  final int parentTermId;
  const Flashcard(
      {required this.id,
      required this.head,
      required this.tail,
      required this.parentTermId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['head'] = Variable<String>(head);
    map['tail'] = Variable<String>(tail);
    map['parentTermId'] = Variable<int>(parentTermId);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      head: Value(head),
      tail: Value(tail),
      parentTermId: Value(parentTermId),
    );
  }

  factory Flashcard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Flashcard(
      id: serializer.fromJson<int>(json['id']),
      head: serializer.fromJson<String>(json['head']),
      tail: serializer.fromJson<String>(json['tail']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'head': serializer.toJson<String>(head),
      'tail': serializer.toJson<String>(tail),
      'parentTermId': serializer.toJson<int>(parentTermId),
    };
  }

  Flashcard copyWith(
          {int? id, String? head, String? tail, int? parentTermId}) =>
      Flashcard(
        id: id ?? this.id,
        head: head ?? this.head,
        tail: tail ?? this.tail,
        parentTermId: parentTermId ?? this.parentTermId,
      );
  @override
  String toString() {
    return (StringBuffer('Flashcard(')
          ..write('id: $id, ')
          ..write('head: $head, ')
          ..write('tail: $tail, ')
          ..write('parentTermId: $parentTermId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, head, tail, parentTermId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Flashcard &&
          other.id == this.id &&
          other.head == this.head &&
          other.tail == this.tail &&
          other.parentTermId == this.parentTermId);
}

class FlashcardsCompanion extends UpdateCompanion<Flashcard> {
  final Value<int> id;
  final Value<String> head;
  final Value<String> tail;
  final Value<int> parentTermId;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.head = const Value.absent(),
    this.tail = const Value.absent(),
    this.parentTermId = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    this.id = const Value.absent(),
    required String head,
    required String tail,
    required int parentTermId,
  })  : head = Value(head),
        tail = Value(tail),
        parentTermId = Value(parentTermId);
  static Insertable<Flashcard> custom({
    Expression<int>? id,
    Expression<String>? head,
    Expression<String>? tail,
    Expression<int>? parentTermId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (head != null) 'head': head,
      if (tail != null) 'tail': tail,
      if (parentTermId != null) 'parentTermId': parentTermId,
    });
  }

  FlashcardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? head,
      Value<String>? tail,
      Value<int>? parentTermId}) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      head: head ?? this.head,
      tail: tail ?? this.tail,
      parentTermId: parentTermId ?? this.parentTermId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (head.present) {
      map['head'] = Variable<String>(head.value);
    }
    if (tail.present) {
      map['tail'] = Variable<String>(tail.value);
    }
    if (parentTermId.present) {
      map['parentTermId'] = Variable<int>(parentTermId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('head: $head, ')
          ..write('tail: $tail, ')
          ..write('parentTermId: $parentTermId')
          ..write(')'))
        .toString();
  }
}

class $VoiceNotesTable extends VoiceNotes
    with TableInfo<$VoiceNotesTable, VoiceNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoiceNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _encryptionKeyMeta =
      const VerificationMeta('encryptionKey');
  @override
  late final GeneratedColumn<Uint8List> encryptionKey =
      GeneratedColumn<Uint8List>('encryptionKey', aliasedName, false,
          type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _parentTermIdMeta =
      const VerificationMeta('parentTermId');
  @override
  late final GeneratedColumn<int> parentTermId = GeneratedColumn<int>(
      'parentTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const String $name = 'voiceNotes';
  @override
  VerificationContext validateIntegrity(Insertable<VoiceNote> instance,
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
  VoiceNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoiceNote(
      encryptionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}encryptionKey'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}lastUpdated'])!,
    );
  }

  @override
  $VoiceNotesTable createAlias(String alias) {
    return $VoiceNotesTable(attachedDatabase, alias);
  }
}

class VoiceNote extends DataClass implements Insertable<VoiceNote> {
  final Uint8List encryptionKey;
  final int parentTermId;
  final DateTime creation;
  final DateTime lastUpdated;
  const VoiceNote(
      {required this.encryptionKey,
      required this.parentTermId,
      required this.creation,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['encryptionKey'] = Variable<Uint8List>(encryptionKey);
    map['parentTermId'] = Variable<int>(parentTermId);
    map['creation'] = Variable<DateTime>(creation);
    map['lastUpdated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  VoiceNotesCompanion toCompanion(bool nullToAbsent) {
    return VoiceNotesCompanion(
      encryptionKey: Value(encryptionKey),
      parentTermId: Value(parentTermId),
      creation: Value(creation),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory VoiceNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoiceNote(
      encryptionKey: serializer.fromJson<Uint8List>(json['encryptionKey']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      creation: serializer.fromJson<DateTime>(json['creation']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'encryptionKey': serializer.toJson<Uint8List>(encryptionKey),
      'parentTermId': serializer.toJson<int>(parentTermId),
      'creation': serializer.toJson<DateTime>(creation),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  VoiceNote copyWith(
          {Uint8List? encryptionKey,
          int? parentTermId,
          DateTime? creation,
          DateTime? lastUpdated}) =>
      VoiceNote(
        encryptionKey: encryptionKey ?? this.encryptionKey,
        parentTermId: parentTermId ?? this.parentTermId,
        creation: creation ?? this.creation,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('VoiceNote(')
          ..write('encryptionKey: $encryptionKey, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('creation: $creation, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash($driftBlobEquality.hash(encryptionKey),
      parentTermId, creation, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoiceNote &&
          $driftBlobEquality.equals(other.encryptionKey, this.encryptionKey) &&
          other.parentTermId == this.parentTermId &&
          other.creation == this.creation &&
          other.lastUpdated == this.lastUpdated);
}

class VoiceNotesCompanion extends UpdateCompanion<VoiceNote> {
  final Value<Uint8List> encryptionKey;
  final Value<int> parentTermId;
  final Value<DateTime> creation;
  final Value<DateTime> lastUpdated;
  const VoiceNotesCompanion({
    this.encryptionKey = const Value.absent(),
    this.parentTermId = const Value.absent(),
    this.creation = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  VoiceNotesCompanion.insert({
    required Uint8List encryptionKey,
    this.parentTermId = const Value.absent(),
    required DateTime creation,
    required DateTime lastUpdated,
  })  : encryptionKey = Value(encryptionKey),
        creation = Value(creation),
        lastUpdated = Value(lastUpdated);
  static Insertable<VoiceNote> custom({
    Expression<Uint8List>? encryptionKey,
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

  VoiceNotesCompanion copyWith(
      {Value<Uint8List>? encryptionKey,
      Value<int>? parentTermId,
      Value<DateTime>? creation,
      Value<DateTime>? lastUpdated}) {
    return VoiceNotesCompanion(
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
      map['encryptionKey'] = Variable<Uint8List>(encryptionKey.value);
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
    return (StringBuffer('VoiceNotesCompanion(')
          ..write('encryptionKey: $encryptionKey, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('creation: $creation, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $RelatedTermsTable extends RelatedTerms
    with TableInfo<$RelatedTermsTable, RelatedTerm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelatedTermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _anotherTermIdMeta =
      const VerificationMeta('anotherTermId');
  @override
  late final GeneratedColumn<int> anotherTermId = GeneratedColumn<int>(
      'anotherTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'termId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [anotherTermId, termId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relatedTerms';
  @override
  VerificationContext validateIntegrity(Insertable<RelatedTerm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('anotherTermId')) {
      context.handle(
          _anotherTermIdMeta,
          anotherTermId.isAcceptableOrUnknown(
              data['anotherTermId']!, _anotherTermIdMeta));
    } else if (isInserting) {
      context.missing(_anotherTermIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {anotherTermId, termId};
  @override
  RelatedTerm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelatedTerm(
      anotherTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anotherTermId'])!,
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
    );
  }

  @override
  $RelatedTermsTable createAlias(String alias) {
    return $RelatedTermsTable(attachedDatabase, alias);
  }
}

class RelatedTerm extends DataClass implements Insertable<RelatedTerm> {
  final int anotherTermId;
  final int termId;
  const RelatedTerm({required this.anotherTermId, required this.termId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['anotherTermId'] = Variable<int>(anotherTermId);
    map['termId'] = Variable<int>(termId);
    return map;
  }

  RelatedTermsCompanion toCompanion(bool nullToAbsent) {
    return RelatedTermsCompanion(
      anotherTermId: Value(anotherTermId),
      termId: Value(termId),
    );
  }

  factory RelatedTerm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelatedTerm(
      anotherTermId: serializer.fromJson<int>(json['anotherTermId']),
      termId: serializer.fromJson<int>(json['termId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'anotherTermId': serializer.toJson<int>(anotherTermId),
      'termId': serializer.toJson<int>(termId),
    };
  }

  RelatedTerm copyWith({int? anotherTermId, int? termId}) => RelatedTerm(
        anotherTermId: anotherTermId ?? this.anotherTermId,
        termId: termId ?? this.termId,
      );
  @override
  String toString() {
    return (StringBuffer('RelatedTerm(')
          ..write('anotherTermId: $anotherTermId, ')
          ..write('termId: $termId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(anotherTermId, termId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelatedTerm &&
          other.anotherTermId == this.anotherTermId &&
          other.termId == this.termId);
}

class RelatedTermsCompanion extends UpdateCompanion<RelatedTerm> {
  final Value<int> anotherTermId;
  final Value<int> termId;
  final Value<int> rowid;
  const RelatedTermsCompanion({
    this.anotherTermId = const Value.absent(),
    this.termId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelatedTermsCompanion.insert({
    required int anotherTermId,
    required int termId,
    this.rowid = const Value.absent(),
  })  : anotherTermId = Value(anotherTermId),
        termId = Value(termId);
  static Insertable<RelatedTerm> custom({
    Expression<int>? anotherTermId,
    Expression<int>? termId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (anotherTermId != null) 'anotherTermId': anotherTermId,
      if (termId != null) 'termId': termId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelatedTermsCompanion copyWith(
      {Value<int>? anotherTermId, Value<int>? termId, Value<int>? rowid}) {
    return RelatedTermsCompanion(
      anotherTermId: anotherTermId ?? this.anotherTermId,
      termId: termId ?? this.termId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (anotherTermId.present) {
      map['anotherTermId'] = Variable<int>(anotherTermId.value);
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
    return (StringBuffer('RelatedTermsCompanion(')
          ..write('anotherTermId: $anotherTermId, ')
          ..write('termId: $termId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsLinkedToTagsTable extends QuestionsLinkedToTags
    with TableInfo<$QuestionsLinkedToTagsTable, QuestionsLinkedToTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsLinkedToTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'questionId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tagId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [questionId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questionsLinkedToTags';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionsLinkedToTag> instance,
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
    if (data.containsKey('tagId')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tagId']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, tagId};
  @override
  QuestionsLinkedToTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionsLinkedToTag(
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}questionId'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tagId'])!,
    );
  }

  @override
  $QuestionsLinkedToTagsTable createAlias(String alias) {
    return $QuestionsLinkedToTagsTable(attachedDatabase, alias);
  }
}

class QuestionsLinkedToTag extends DataClass
    implements Insertable<QuestionsLinkedToTag> {
  final int questionId;
  final int tagId;
  const QuestionsLinkedToTag({required this.questionId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['questionId'] = Variable<int>(questionId);
    map['tagId'] = Variable<int>(tagId);
    return map;
  }

  QuestionsLinkedToTagsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsLinkedToTagsCompanion(
      questionId: Value(questionId),
      tagId: Value(tagId),
    );
  }

  factory QuestionsLinkedToTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionsLinkedToTag(
      questionId: serializer.fromJson<int>(json['questionId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<int>(questionId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  QuestionsLinkedToTag copyWith({int? questionId, int? tagId}) =>
      QuestionsLinkedToTag(
        questionId: questionId ?? this.questionId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionsLinkedToTag(')
          ..write('questionId: $questionId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionsLinkedToTag &&
          other.questionId == this.questionId &&
          other.tagId == this.tagId);
}

class QuestionsLinkedToTagsCompanion
    extends UpdateCompanion<QuestionsLinkedToTag> {
  final Value<int> questionId;
  final Value<int> tagId;
  final Value<int> rowid;
  const QuestionsLinkedToTagsCompanion({
    this.questionId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsLinkedToTagsCompanion.insert({
    required int questionId,
    required int tagId,
    this.rowid = const Value.absent(),
  })  : questionId = Value(questionId),
        tagId = Value(tagId);
  static Insertable<QuestionsLinkedToTag> custom({
    Expression<int>? questionId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'questionId': questionId,
      if (tagId != null) 'tagId': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsLinkedToTagsCompanion copyWith(
      {Value<int>? questionId, Value<int>? tagId, Value<int>? rowid}) {
    return QuestionsLinkedToTagsCompanion(
      questionId: questionId ?? this.questionId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['questionId'] = Variable<int>(questionId.value);
    }
    if (tagId.present) {
      map['tagId'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsLinkedToTagsCompanion(')
          ..write('questionId: $questionId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermsParentsTable extends TermsParents
    with TableInfo<$TermsParentsTable, TermsParent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsParentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _rootTermIdMeta =
      const VerificationMeta('rootTermId');
  @override
  late final GeneratedColumn<int> rootTermId = GeneratedColumn<int>(
      'rootTermId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _creationMeta =
      const VerificationMeta('creation');
  @override
  late final GeneratedColumn<DateTime> creation = GeneratedColumn<DateTime>(
      'creation', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [termId, parentTermId, rootTermId, creation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsParents';
  @override
  VerificationContext validateIntegrity(Insertable<TermsParent> instance,
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
    if (data.containsKey('rootTermId')) {
      context.handle(
          _rootTermIdMeta,
          rootTermId.isAcceptableOrUnknown(
              data['rootTermId']!, _rootTermIdMeta));
    } else if (isInserting) {
      context.missing(_rootTermIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {termId, parentTermId, rootTermId};
  @override
  TermsParent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsParent(
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
      parentTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentTermId'])!,
      rootTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rootTermId'])!,
      creation: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation'])!,
    );
  }

  @override
  $TermsParentsTable createAlias(String alias) {
    return $TermsParentsTable(attachedDatabase, alias);
  }
}

class TermsParent extends DataClass implements Insertable<TermsParent> {
  final int termId;
  final int parentTermId;
  final int rootTermId;
  final DateTime creation;
  const TermsParent(
      {required this.termId,
      required this.parentTermId,
      required this.rootTermId,
      required this.creation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['termId'] = Variable<int>(termId);
    map['parentTermId'] = Variable<int>(parentTermId);
    map['rootTermId'] = Variable<int>(rootTermId);
    map['creation'] = Variable<DateTime>(creation);
    return map;
  }

  TermsParentsCompanion toCompanion(bool nullToAbsent) {
    return TermsParentsCompanion(
      termId: Value(termId),
      parentTermId: Value(parentTermId),
      rootTermId: Value(rootTermId),
      creation: Value(creation),
    );
  }

  factory TermsParent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsParent(
      termId: serializer.fromJson<int>(json['termId']),
      parentTermId: serializer.fromJson<int>(json['parentTermId']),
      rootTermId: serializer.fromJson<int>(json['rootTermId']),
      creation: serializer.fromJson<DateTime>(json['creation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termId': serializer.toJson<int>(termId),
      'parentTermId': serializer.toJson<int>(parentTermId),
      'rootTermId': serializer.toJson<int>(rootTermId),
      'creation': serializer.toJson<DateTime>(creation),
    };
  }

  TermsParent copyWith(
          {int? termId,
          int? parentTermId,
          int? rootTermId,
          DateTime? creation}) =>
      TermsParent(
        termId: termId ?? this.termId,
        parentTermId: parentTermId ?? this.parentTermId,
        rootTermId: rootTermId ?? this.rootTermId,
        creation: creation ?? this.creation,
      );
  @override
  String toString() {
    return (StringBuffer('TermsParent(')
          ..write('termId: $termId, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('rootTermId: $rootTermId, ')
          ..write('creation: $creation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termId, parentTermId, rootTermId, creation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsParent &&
          other.termId == this.termId &&
          other.parentTermId == this.parentTermId &&
          other.rootTermId == this.rootTermId &&
          other.creation == this.creation);
}

class TermsParentsCompanion extends UpdateCompanion<TermsParent> {
  final Value<int> termId;
  final Value<int> parentTermId;
  final Value<int> rootTermId;
  final Value<DateTime> creation;
  final Value<int> rowid;
  const TermsParentsCompanion({
    this.termId = const Value.absent(),
    this.parentTermId = const Value.absent(),
    this.rootTermId = const Value.absent(),
    this.creation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermsParentsCompanion.insert({
    required int termId,
    required int parentTermId,
    required int rootTermId,
    required DateTime creation,
    this.rowid = const Value.absent(),
  })  : termId = Value(termId),
        parentTermId = Value(parentTermId),
        rootTermId = Value(rootTermId),
        creation = Value(creation);
  static Insertable<TermsParent> custom({
    Expression<int>? termId,
    Expression<int>? parentTermId,
    Expression<int>? rootTermId,
    Expression<DateTime>? creation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termId != null) 'termId': termId,
      if (parentTermId != null) 'parentTermId': parentTermId,
      if (rootTermId != null) 'rootTermId': rootTermId,
      if (creation != null) 'creation': creation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermsParentsCompanion copyWith(
      {Value<int>? termId,
      Value<int>? parentTermId,
      Value<int>? rootTermId,
      Value<DateTime>? creation,
      Value<int>? rowid}) {
    return TermsParentsCompanion(
      termId: termId ?? this.termId,
      parentTermId: parentTermId ?? this.parentTermId,
      rootTermId: rootTermId ?? this.rootTermId,
      creation: creation ?? this.creation,
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
    if (rootTermId.present) {
      map['rootTermId'] = Variable<int>(rootTermId.value);
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
    return (StringBuffer('TermsParentsCompanion(')
          ..write('termId: $termId, ')
          ..write('parentTermId: $parentTermId, ')
          ..write('rootTermId: $rootTermId, ')
          ..write('creation: $creation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermTagsTable extends TermTags with TableInfo<$TermTagsTable, TermTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderingMeta =
      const VerificationMeta('ordering');
  @override
  late final GeneratedColumn<int> ordering = GeneratedColumn<int>(
      'ordering', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, name, ordering];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsTags';
  @override
  VerificationContext validateIntegrity(Insertable<TermTag> instance,
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
    if (data.containsKey('ordering')) {
      context.handle(_orderingMeta,
          ordering.isAcceptableOrUnknown(data['ordering']!, _orderingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermTag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ordering: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordering'])!,
    );
  }

  @override
  $TermTagsTable createAlias(String alias) {
    return $TermTagsTable(attachedDatabase, alias);
  }
}

class TermTag extends DataClass implements Insertable<TermTag> {
  final int id;
  final String name;
  final int ordering;
  const TermTag({required this.id, required this.name, required this.ordering});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['ordering'] = Variable<int>(ordering);
    return map;
  }

  TermTagsCompanion toCompanion(bool nullToAbsent) {
    return TermTagsCompanion(
      id: Value(id),
      name: Value(name),
      ordering: Value(ordering),
    );
  }

  factory TermTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermTag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ordering: serializer.fromJson<int>(json['ordering']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'ordering': serializer.toJson<int>(ordering),
    };
  }

  TermTag copyWith({int? id, String? name, int? ordering}) => TermTag(
        id: id ?? this.id,
        name: name ?? this.name,
        ordering: ordering ?? this.ordering,
      );
  @override
  String toString() {
    return (StringBuffer('TermTag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ordering: $ordering')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, ordering);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermTag &&
          other.id == this.id &&
          other.name == this.name &&
          other.ordering == this.ordering);
}

class TermTagsCompanion extends UpdateCompanion<TermTag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> ordering;
  const TermTagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ordering = const Value.absent(),
  });
  TermTagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.ordering = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TermTag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? ordering,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ordering != null) 'ordering': ordering,
    });
  }

  TermTagsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? ordering}) {
    return TermTagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ordering: ordering ?? this.ordering,
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
    if (ordering.present) {
      map['ordering'] = Variable<int>(ordering.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermTagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ordering: $ordering')
          ..write(')'))
        .toString();
  }
}

class $TermsLinkedToTagsTable extends TermsLinkedToTags
    with TableInfo<$TermsLinkedToTagsTable, TermsLinkedToTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsLinkedToTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'termId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tagId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [termId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsLinkedToTags';
  @override
  VerificationContext validateIntegrity(Insertable<TermsLinkedToTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('termId')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['termId']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('tagId')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tagId']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {termId, tagId};
  @override
  TermsLinkedToTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsLinkedToTag(
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tagId'])!,
    );
  }

  @override
  $TermsLinkedToTagsTable createAlias(String alias) {
    return $TermsLinkedToTagsTable(attachedDatabase, alias);
  }
}

class TermsLinkedToTag extends DataClass
    implements Insertable<TermsLinkedToTag> {
  final int termId;
  final int tagId;
  const TermsLinkedToTag({required this.termId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['termId'] = Variable<int>(termId);
    map['tagId'] = Variable<int>(tagId);
    return map;
  }

  TermsLinkedToTagsCompanion toCompanion(bool nullToAbsent) {
    return TermsLinkedToTagsCompanion(
      termId: Value(termId),
      tagId: Value(tagId),
    );
  }

  factory TermsLinkedToTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsLinkedToTag(
      termId: serializer.fromJson<int>(json['termId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termId': serializer.toJson<int>(termId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  TermsLinkedToTag copyWith({int? termId, int? tagId}) => TermsLinkedToTag(
        termId: termId ?? this.termId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('TermsLinkedToTag(')
          ..write('termId: $termId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsLinkedToTag &&
          other.termId == this.termId &&
          other.tagId == this.tagId);
}

class TermsLinkedToTagsCompanion extends UpdateCompanion<TermsLinkedToTag> {
  final Value<int> termId;
  final Value<int> tagId;
  final Value<int> rowid;
  const TermsLinkedToTagsCompanion({
    this.termId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermsLinkedToTagsCompanion.insert({
    required int termId,
    required int tagId,
    this.rowid = const Value.absent(),
  })  : termId = Value(termId),
        tagId = Value(tagId);
  static Insertable<TermsLinkedToTag> custom({
    Expression<int>? termId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termId != null) 'termId': termId,
      if (tagId != null) 'tagId': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermsLinkedToTagsCompanion copyWith(
      {Value<int>? termId, Value<int>? tagId, Value<int>? rowid}) {
    return TermsLinkedToTagsCompanion(
      termId: termId ?? this.termId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termId.present) {
      map['termId'] = Variable<int>(termId.value);
    }
    if (tagId.present) {
      map['tagId'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsLinkedToTagsCompanion(')
          ..write('termId: $termId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermLabelsTable extends TermLabels
    with TableInfo<$TermLabelsTable, TermLabel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermLabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsLabels';
  @override
  VerificationContext validateIntegrity(Insertable<TermLabel> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermLabel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermLabel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TermLabelsTable createAlias(String alias) {
    return $TermLabelsTable(attachedDatabase, alias);
  }
}

class TermLabel extends DataClass implements Insertable<TermLabel> {
  final int id;
  final String name;
  const TermLabel({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TermLabelsCompanion toCompanion(bool nullToAbsent) {
    return TermLabelsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory TermLabel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermLabel(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TermLabel copyWith({int? id, String? name}) => TermLabel(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TermLabel(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermLabel && other.id == this.id && other.name == this.name);
}

class TermLabelsCompanion extends UpdateCompanion<TermLabel> {
  final Value<int> id;
  final Value<String> name;
  const TermLabelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TermLabelsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TermLabel> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TermLabelsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TermLabelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermLabelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TermsLinkedToLabelsTable extends TermsLinkedToLabels
    with TableInfo<$TermsLinkedToLabelsTable, TermsLinkedToLabel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsLinkedToLabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'termId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _labelIdMeta =
      const VerificationMeta('labelId');
  @override
  late final GeneratedColumn<int> labelId = GeneratedColumn<int>(
      'labelId', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [termId, labelId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'termsLinkedToLabels';
  @override
  VerificationContext validateIntegrity(Insertable<TermsLinkedToLabel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('termId')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['termId']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('labelId')) {
      context.handle(_labelIdMeta,
          labelId.isAcceptableOrUnknown(data['labelId']!, _labelIdMeta));
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {termId, labelId};
  @override
  TermsLinkedToLabel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsLinkedToLabel(
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}termId'])!,
      labelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}labelId'])!,
    );
  }

  @override
  $TermsLinkedToLabelsTable createAlias(String alias) {
    return $TermsLinkedToLabelsTable(attachedDatabase, alias);
  }
}

class TermsLinkedToLabel extends DataClass
    implements Insertable<TermsLinkedToLabel> {
  final int termId;
  final int labelId;
  const TermsLinkedToLabel({required this.termId, required this.labelId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['termId'] = Variable<int>(termId);
    map['labelId'] = Variable<int>(labelId);
    return map;
  }

  TermsLinkedToLabelsCompanion toCompanion(bool nullToAbsent) {
    return TermsLinkedToLabelsCompanion(
      termId: Value(termId),
      labelId: Value(labelId),
    );
  }

  factory TermsLinkedToLabel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsLinkedToLabel(
      termId: serializer.fromJson<int>(json['termId']),
      labelId: serializer.fromJson<int>(json['labelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termId': serializer.toJson<int>(termId),
      'labelId': serializer.toJson<int>(labelId),
    };
  }

  TermsLinkedToLabel copyWith({int? termId, int? labelId}) =>
      TermsLinkedToLabel(
        termId: termId ?? this.termId,
        labelId: labelId ?? this.labelId,
      );
  @override
  String toString() {
    return (StringBuffer('TermsLinkedToLabel(')
          ..write('termId: $termId, ')
          ..write('labelId: $labelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termId, labelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsLinkedToLabel &&
          other.termId == this.termId &&
          other.labelId == this.labelId);
}

class TermsLinkedToLabelsCompanion extends UpdateCompanion<TermsLinkedToLabel> {
  final Value<int> termId;
  final Value<int> labelId;
  final Value<int> rowid;
  const TermsLinkedToLabelsCompanion({
    this.termId = const Value.absent(),
    this.labelId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermsLinkedToLabelsCompanion.insert({
    required int termId,
    required int labelId,
    this.rowid = const Value.absent(),
  })  : termId = Value(termId),
        labelId = Value(labelId);
  static Insertable<TermsLinkedToLabel> custom({
    Expression<int>? termId,
    Expression<int>? labelId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termId != null) 'termId': termId,
      if (labelId != null) 'labelId': labelId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermsLinkedToLabelsCompanion copyWith(
      {Value<int>? termId, Value<int>? labelId, Value<int>? rowid}) {
    return TermsLinkedToLabelsCompanion(
      termId: termId ?? this.termId,
      labelId: labelId ?? this.labelId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termId.present) {
      map['termId'] = Variable<int>(termId.value);
    }
    if (labelId.present) {
      map['labelId'] = Variable<int>(labelId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsLinkedToLabelsCompanion(')
          ..write('termId: $termId, ')
          ..write('labelId: $labelId, ')
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
  late final $HttpRequestsTable httpRequests = $HttpRequestsTable(this);
  late final $TermsWithQuestionsFilteringEnabledTable
      termsWithQuestionsFilteringEnabled =
      $TermsWithQuestionsFilteringEnabledTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $VoiceNotesTable voiceNotes = $VoiceNotesTable(this);
  late final $RelatedTermsTable relatedTerms = $RelatedTermsTable(this);
  late final $QuestionsLinkedToTagsTable questionsLinkedToTags =
      $QuestionsLinkedToTagsTable(this);
  late final $TermsParentsTable termsParents = $TermsParentsTable(this);
  late final $TermTagsTable termTags = $TermTagsTable(this);
  late final $TermsLinkedToTagsTable termsLinkedToTags =
      $TermsLinkedToTagsTable(this);
  late final $TermLabelsTable termLabels = $TermLabelsTable(this);
  late final $TermsLinkedToLabelsTable termsLinkedToLabels =
      $TermsLinkedToLabelsTable(this);
  late final Index parentQuestionIdIndex = Index('parentQuestionIdIndex',
      'CREATE INDEX parentQuestionIdIndex ON answers (parentQuestionId)');
  late final Index qIndex1 =
      Index('qIndex1', 'CREATE INDEX qIndex1 ON questions (parentTermId)');
  late final Index questionTagsIndex1 = Index('questionTagsIndex1',
      'CREATE INDEX questionTagsIndex1 ON questionTags (parentTagId)');
  late final Index questionMediasIndex1 = Index('questionMediasIndex1',
      'CREATE INDEX questionMediasIndex1 ON questionMedias (parentQuestionId)');
  late final Index answersIndex1 = Index('answersIndex1',
      'CREATE INDEX answersIndex1 ON answerProperties (answerId)');
  late final Index qtpIndex1 = Index('qtpIndex1',
      'CREATE INDEX qtpIndex1 ON questionTagProperties (questionTagId)');
  late final Index qpIndex1 = Index(
      'qpIndex1', 'CREATE INDEX qpIndex1 ON questionProperties (questionId)');
  late final Index qlttIndex1 = Index('qlttIndex1',
      'CREATE INDEX qlttIndex1 ON questionsLinkedToTags (questionId)');
  late final Index qlttIndex2 = Index(
      'qlttIndex2', 'CREATE INDEX qlttIndex2 ON questionsLinkedToTags (tagId)');
  late final Index tlttIndex1 = Index(
      'tlttIndex1', 'CREATE INDEX tlttIndex1 ON termsLinkedToTags (termId)');
  late final Index tlttIndex2 = Index(
      'tlttIndex2', 'CREATE INDEX tlttIndex2 ON termsLinkedToTags (tagId)');
  late final Index tltlIndex1 = Index(
      'tltlIndex1', 'CREATE INDEX tltlIndex1 ON termsLinkedToLabels (termId)');
  late final Index tltlIndex2 = Index(
      'tltlIndex2', 'CREATE INDEX tltlIndex2 ON termsLinkedToLabels (labelId)');
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
        httpRequests,
        termsWithQuestionsFilteringEnabled,
        flashcards,
        voiceNotes,
        relatedTerms,
        questionsLinkedToTags,
        termsParents,
        termTags,
        termsLinkedToTags,
        termLabels,
        termsLinkedToLabels,
        parentQuestionIdIndex,
        qIndex1,
        questionTagsIndex1,
        questionMediasIndex1,
        answersIndex1,
        qtpIndex1,
        qpIndex1,
        qlttIndex1,
        qlttIndex2,
        tlttIndex1,
        tlttIndex2,
        tltlIndex1,
        tltlIndex2
      ];
}

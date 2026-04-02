// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BuyersTable extends Buyers with TableInfo<$BuyersTable, Buyer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyersTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _companyMeta =
      const VerificationMeta('company');
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
      'company', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _whatsappMeta =
      const VerificationMeta('whatsapp');
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
      'whatsapp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, company, whatsapp, email, role, isSynced, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buyers';
  @override
  VerificationContext validateIntegrity(Insertable<Buyer> instance,
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
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company']!, _companyMeta));
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('whatsapp')) {
      context.handle(_whatsappMeta,
          whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta));
    } else if (isInserting) {
      context.missing(_whatsappMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Buyer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Buyer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      company: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company'])!,
      whatsapp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}whatsapp'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $BuyersTable createAlias(String alias) {
    return $BuyersTable(attachedDatabase, alias);
  }
}

class Buyer extends DataClass implements Insertable<Buyer> {
  final int id;
  final String name;
  final String company;
  final String whatsapp;
  final String? email;
  final String? role;
  final bool isSynced;
  final DateTime lastUpdated;
  const Buyer(
      {required this.id,
      required this.name,
      required this.company,
      required this.whatsapp,
      this.email,
      this.role,
      required this.isSynced,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['company'] = Variable<String>(company);
    map['whatsapp'] = Variable<String>(whatsapp);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  BuyersCompanion toCompanion(bool nullToAbsent) {
    return BuyersCompanion(
      id: Value(id),
      name: Value(name),
      company: Value(company),
      whatsapp: Value(whatsapp),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Buyer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Buyer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      company: serializer.fromJson<String>(json['company']),
      whatsapp: serializer.fromJson<String>(json['whatsapp']),
      email: serializer.fromJson<String?>(json['email']),
      role: serializer.fromJson<String?>(json['role']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'company': serializer.toJson<String>(company),
      'whatsapp': serializer.toJson<String>(whatsapp),
      'email': serializer.toJson<String?>(email),
      'role': serializer.toJson<String?>(role),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Buyer copyWith(
          {int? id,
          String? name,
          String? company,
          String? whatsapp,
          Value<String?> email = const Value.absent(),
          Value<String?> role = const Value.absent(),
          bool? isSynced,
          DateTime? lastUpdated}) =>
      Buyer(
        id: id ?? this.id,
        name: name ?? this.name,
        company: company ?? this.company,
        whatsapp: whatsapp ?? this.whatsapp,
        email: email.present ? email.value : this.email,
        role: role.present ? role.value : this.role,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  Buyer copyWithCompanion(BuyersCompanion data) {
    return Buyer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      company: data.company.present ? data.company.value : this.company,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Buyer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('company: $company, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, company, whatsapp, email, role, isSynced, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Buyer &&
          other.id == this.id &&
          other.name == this.name &&
          other.company == this.company &&
          other.whatsapp == this.whatsapp &&
          other.email == this.email &&
          other.role == this.role &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class BuyersCompanion extends UpdateCompanion<Buyer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> company;
  final Value<String> whatsapp;
  final Value<String?> email;
  final Value<String?> role;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const BuyersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.company = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  BuyersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String company,
    required String whatsapp,
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : name = Value(name),
        company = Value(company),
        whatsapp = Value(whatsapp);
  static Insertable<Buyer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? company,
    Expression<String>? whatsapp,
    Expression<String>? email,
    Expression<String>? role,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (company != null) 'company': company,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  BuyersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? company,
      Value<String>? whatsapp,
      Value<String?>? email,
      Value<String?>? role,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return BuyersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      company: company ?? this.company,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      role: role ?? this.role,
      isSynced: isSynced ?? this.isSynced,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('company: $company, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tradeNameMeta =
      const VerificationMeta('tradeName');
  @override
  late final GeneratedColumn<String> tradeName = GeneratedColumn<String>(
      'trade_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _whatsappMeta =
      const VerificationMeta('whatsapp');
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
      'whatsapp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observationsMeta =
      const VerificationMeta('observations');
  @override
  late final GeneratedColumn<String> observations = GeneratedColumn<String>(
      'observations', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSelfRegisteredMeta =
      const VerificationMeta('isSelfRegistered');
  @override
  late final GeneratedColumn<bool> isSelfRegistered = GeneratedColumn<bool>(
      'is_self_registered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_self_registered" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isRedeCotazapMeta =
      const VerificationMeta('isRedeCotazap');
  @override
  late final GeneratedColumn<bool> isRedeCotazap = GeneratedColumn<bool>(
      'is_rede_cotazap', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_rede_cotazap" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _priorityScoreMeta =
      const VerificationMeta('priorityScore');
  @override
  late final GeneratedColumn<int> priorityScore = GeneratedColumn<int>(
      'priority_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _approvedMeta =
      const VerificationMeta('approved');
  @override
  late final GeneratedColumn<bool> approved = GeneratedColumn<bool>(
      'approved', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("approved" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tradeName,
        whatsapp,
        address,
        observations,
        active,
        isSelfRegistered,
        isRedeCotazap,
        priorityScore,
        approved,
        isSynced,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trade_name')) {
      context.handle(_tradeNameMeta,
          tradeName.isAcceptableOrUnknown(data['trade_name']!, _tradeNameMeta));
    } else if (isInserting) {
      context.missing(_tradeNameMeta);
    }
    if (data.containsKey('whatsapp')) {
      context.handle(_whatsappMeta,
          whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta));
    } else if (isInserting) {
      context.missing(_whatsappMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('observations')) {
      context.handle(
          _observationsMeta,
          observations.isAcceptableOrUnknown(
              data['observations']!, _observationsMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('is_self_registered')) {
      context.handle(
          _isSelfRegisteredMeta,
          isSelfRegistered.isAcceptableOrUnknown(
              data['is_self_registered']!, _isSelfRegisteredMeta));
    }
    if (data.containsKey('is_rede_cotazap')) {
      context.handle(
          _isRedeCotazapMeta,
          isRedeCotazap.isAcceptableOrUnknown(
              data['is_rede_cotazap']!, _isRedeCotazapMeta));
    }
    if (data.containsKey('priority_score')) {
      context.handle(
          _priorityScoreMeta,
          priorityScore.isAcceptableOrUnknown(
              data['priority_score']!, _priorityScoreMeta));
    }
    if (data.containsKey('approved')) {
      context.handle(_approvedMeta,
          approved.isAcceptableOrUnknown(data['approved']!, _approvedMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tradeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trade_name'])!,
      whatsapp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}whatsapp'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      observations: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observations']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      isSelfRegistered: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_self_registered'])!,
      isRedeCotazap: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rede_cotazap'])!,
      priorityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority_score'])!,
      approved: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}approved'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String tradeName;
  final String whatsapp;
  final String? address;
  final String? observations;
  final bool active;
  final bool isSelfRegistered;
  final bool isRedeCotazap;
  final int priorityScore;
  final bool approved;
  final bool isSynced;
  final DateTime lastUpdated;
  const Supplier(
      {required this.id,
      required this.tradeName,
      required this.whatsapp,
      this.address,
      this.observations,
      required this.active,
      required this.isSelfRegistered,
      required this.isRedeCotazap,
      required this.priorityScore,
      required this.approved,
      required this.isSynced,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trade_name'] = Variable<String>(tradeName);
    map['whatsapp'] = Variable<String>(whatsapp);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || observations != null) {
      map['observations'] = Variable<String>(observations);
    }
    map['active'] = Variable<bool>(active);
    map['is_self_registered'] = Variable<bool>(isSelfRegistered);
    map['is_rede_cotazap'] = Variable<bool>(isRedeCotazap);
    map['priority_score'] = Variable<int>(priorityScore);
    map['approved'] = Variable<bool>(approved);
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      tradeName: Value(tradeName),
      whatsapp: Value(whatsapp),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      observations: observations == null && nullToAbsent
          ? const Value.absent()
          : Value(observations),
      active: Value(active),
      isSelfRegistered: Value(isSelfRegistered),
      isRedeCotazap: Value(isRedeCotazap),
      priorityScore: Value(priorityScore),
      approved: Value(approved),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Supplier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      tradeName: serializer.fromJson<String>(json['tradeName']),
      whatsapp: serializer.fromJson<String>(json['whatsapp']),
      address: serializer.fromJson<String?>(json['address']),
      observations: serializer.fromJson<String?>(json['observations']),
      active: serializer.fromJson<bool>(json['active']),
      isSelfRegistered: serializer.fromJson<bool>(json['isSelfRegistered']),
      isRedeCotazap: serializer.fromJson<bool>(json['isRedeCotazap']),
      priorityScore: serializer.fromJson<int>(json['priorityScore']),
      approved: serializer.fromJson<bool>(json['approved']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tradeName': serializer.toJson<String>(tradeName),
      'whatsapp': serializer.toJson<String>(whatsapp),
      'address': serializer.toJson<String?>(address),
      'observations': serializer.toJson<String?>(observations),
      'active': serializer.toJson<bool>(active),
      'isSelfRegistered': serializer.toJson<bool>(isSelfRegistered),
      'isRedeCotazap': serializer.toJson<bool>(isRedeCotazap),
      'priorityScore': serializer.toJson<int>(priorityScore),
      'approved': serializer.toJson<bool>(approved),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Supplier copyWith(
          {int? id,
          String? tradeName,
          String? whatsapp,
          Value<String?> address = const Value.absent(),
          Value<String?> observations = const Value.absent(),
          bool? active,
          bool? isSelfRegistered,
          bool? isRedeCotazap,
          int? priorityScore,
          bool? approved,
          bool? isSynced,
          DateTime? lastUpdated}) =>
      Supplier(
        id: id ?? this.id,
        tradeName: tradeName ?? this.tradeName,
        whatsapp: whatsapp ?? this.whatsapp,
        address: address.present ? address.value : this.address,
        observations:
            observations.present ? observations.value : this.observations,
        active: active ?? this.active,
        isSelfRegistered: isSelfRegistered ?? this.isSelfRegistered,
        isRedeCotazap: isRedeCotazap ?? this.isRedeCotazap,
        priorityScore: priorityScore ?? this.priorityScore,
        approved: approved ?? this.approved,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      tradeName: data.tradeName.present ? data.tradeName.value : this.tradeName,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      address: data.address.present ? data.address.value : this.address,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
      active: data.active.present ? data.active.value : this.active,
      isSelfRegistered: data.isSelfRegistered.present
          ? data.isSelfRegistered.value
          : this.isSelfRegistered,
      isRedeCotazap: data.isRedeCotazap.present
          ? data.isRedeCotazap.value
          : this.isRedeCotazap,
      priorityScore: data.priorityScore.present
          ? data.priorityScore.value
          : this.priorityScore,
      approved: data.approved.present ? data.approved.value : this.approved,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('tradeName: $tradeName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('observations: $observations, ')
          ..write('active: $active, ')
          ..write('isSelfRegistered: $isSelfRegistered, ')
          ..write('isRedeCotazap: $isRedeCotazap, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('approved: $approved, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tradeName,
      whatsapp,
      address,
      observations,
      active,
      isSelfRegistered,
      isRedeCotazap,
      priorityScore,
      approved,
      isSynced,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.tradeName == this.tradeName &&
          other.whatsapp == this.whatsapp &&
          other.address == this.address &&
          other.observations == this.observations &&
          other.active == this.active &&
          other.isSelfRegistered == this.isSelfRegistered &&
          other.isRedeCotazap == this.isRedeCotazap &&
          other.priorityScore == this.priorityScore &&
          other.approved == this.approved &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> tradeName;
  final Value<String> whatsapp;
  final Value<String?> address;
  final Value<String?> observations;
  final Value<bool> active;
  final Value<bool> isSelfRegistered;
  final Value<bool> isRedeCotazap;
  final Value<int> priorityScore;
  final Value<bool> approved;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.observations = const Value.absent(),
    this.active = const Value.absent(),
    this.isSelfRegistered = const Value.absent(),
    this.isRedeCotazap = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.approved = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String tradeName,
    required String whatsapp,
    this.address = const Value.absent(),
    this.observations = const Value.absent(),
    this.active = const Value.absent(),
    this.isSelfRegistered = const Value.absent(),
    this.isRedeCotazap = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.approved = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : tradeName = Value(tradeName),
        whatsapp = Value(whatsapp);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? tradeName,
    Expression<String>? whatsapp,
    Expression<String>? address,
    Expression<String>? observations,
    Expression<bool>? active,
    Expression<bool>? isSelfRegistered,
    Expression<bool>? isRedeCotazap,
    Expression<int>? priorityScore,
    Expression<bool>? approved,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tradeName != null) 'trade_name': tradeName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (address != null) 'address': address,
      if (observations != null) 'observations': observations,
      if (active != null) 'active': active,
      if (isSelfRegistered != null) 'is_self_registered': isSelfRegistered,
      if (isRedeCotazap != null) 'is_rede_cotazap': isRedeCotazap,
      if (priorityScore != null) 'priority_score': priorityScore,
      if (approved != null) 'approved': approved,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  SuppliersCompanion copyWith(
      {Value<int>? id,
      Value<String>? tradeName,
      Value<String>? whatsapp,
      Value<String?>? address,
      Value<String?>? observations,
      Value<bool>? active,
      Value<bool>? isSelfRegistered,
      Value<bool>? isRedeCotazap,
      Value<int>? priorityScore,
      Value<bool>? approved,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return SuppliersCompanion(
      id: id ?? this.id,
      tradeName: tradeName ?? this.tradeName,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      observations: observations ?? this.observations,
      active: active ?? this.active,
      isSelfRegistered: isSelfRegistered ?? this.isSelfRegistered,
      isRedeCotazap: isRedeCotazap ?? this.isRedeCotazap,
      priorityScore: priorityScore ?? this.priorityScore,
      approved: approved ?? this.approved,
      isSynced: isSynced ?? this.isSynced,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tradeName.present) {
      map['trade_name'] = Variable<String>(tradeName.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (observations.present) {
      map['observations'] = Variable<String>(observations.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (isSelfRegistered.present) {
      map['is_self_registered'] = Variable<bool>(isSelfRegistered.value);
    }
    if (isRedeCotazap.present) {
      map['is_rede_cotazap'] = Variable<bool>(isRedeCotazap.value);
    }
    if (priorityScore.present) {
      map['priority_score'] = Variable<int>(priorityScore.value);
    }
    if (approved.present) {
      map['approved'] = Variable<bool>(approved.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('tradeName: $tradeName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('observations: $observations, ')
          ..write('active: $active, ')
          ..write('isSelfRegistered: $isSelfRegistered, ')
          ..write('isRedeCotazap: $isRedeCotazap, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('approved: $approved, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeasureMeta =
      const VerificationMeta('unitMeasure');
  @override
  late final GeneratedColumn<String> unitMeasure = GeneratedColumn<String>(
      'unit_measure', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _packagingTypeMeta =
      const VerificationMeta('packagingType');
  @override
  late final GeneratedColumn<String> packagingType = GeneratedColumn<String>(
      'packaging_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attributesJsonMeta =
      const VerificationMeta('attributesJson');
  @override
  late final GeneratedColumn<String> attributesJson = GeneratedColumn<String>(
      'attributes_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFromRedeMeta =
      const VerificationMeta('isFromRede');
  @override
  late final GeneratedColumn<bool> isFromRede = GeneratedColumn<bool>(
      'is_from_rede', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_from_rede" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sku,
        description,
        unitMeasure,
        packagingType,
        attributesJson,
        isFromRede,
        isSynced,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('unit_measure')) {
      context.handle(
          _unitMeasureMeta,
          unitMeasure.isAcceptableOrUnknown(
              data['unit_measure']!, _unitMeasureMeta));
    } else if (isInserting) {
      context.missing(_unitMeasureMeta);
    }
    if (data.containsKey('packaging_type')) {
      context.handle(
          _packagingTypeMeta,
          packagingType.isAcceptableOrUnknown(
              data['packaging_type']!, _packagingTypeMeta));
    } else if (isInserting) {
      context.missing(_packagingTypeMeta);
    }
    if (data.containsKey('attributes_json')) {
      context.handle(
          _attributesJsonMeta,
          attributesJson.isAcceptableOrUnknown(
              data['attributes_json']!, _attributesJsonMeta));
    } else if (isInserting) {
      context.missing(_attributesJsonMeta);
    }
    if (data.containsKey('is_from_rede')) {
      context.handle(
          _isFromRedeMeta,
          isFromRede.isAcceptableOrUnknown(
              data['is_from_rede']!, _isFromRedeMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      unitMeasure: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_measure'])!,
      packagingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}packaging_type'])!,
      attributesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}attributes_json'])!,
      isFromRede: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_from_rede'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String? sku;
  final String description;
  final String unitMeasure;
  final String packagingType;
  final String attributesJson;
  final bool isFromRede;
  final bool isSynced;
  final DateTime lastUpdated;
  const Product(
      {required this.id,
      this.sku,
      required this.description,
      required this.unitMeasure,
      required this.packagingType,
      required this.attributesJson,
      required this.isFromRede,
      required this.isSynced,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['description'] = Variable<String>(description);
    map['unit_measure'] = Variable<String>(unitMeasure);
    map['packaging_type'] = Variable<String>(packagingType);
    map['attributes_json'] = Variable<String>(attributesJson);
    map['is_from_rede'] = Variable<bool>(isFromRede);
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      description: Value(description),
      unitMeasure: Value(unitMeasure),
      packagingType: Value(packagingType),
      attributesJson: Value(attributesJson),
      isFromRede: Value(isFromRede),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      description: serializer.fromJson<String>(json['description']),
      unitMeasure: serializer.fromJson<String>(json['unitMeasure']),
      packagingType: serializer.fromJson<String>(json['packagingType']),
      attributesJson: serializer.fromJson<String>(json['attributesJson']),
      isFromRede: serializer.fromJson<bool>(json['isFromRede']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'description': serializer.toJson<String>(description),
      'unitMeasure': serializer.toJson<String>(unitMeasure),
      'packagingType': serializer.toJson<String>(packagingType),
      'attributesJson': serializer.toJson<String>(attributesJson),
      'isFromRede': serializer.toJson<bool>(isFromRede),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Product copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? description,
          String? unitMeasure,
          String? packagingType,
          String? attributesJson,
          bool? isFromRede,
          bool? isSynced,
          DateTime? lastUpdated}) =>
      Product(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        description: description ?? this.description,
        unitMeasure: unitMeasure ?? this.unitMeasure,
        packagingType: packagingType ?? this.packagingType,
        attributesJson: attributesJson ?? this.attributesJson,
        isFromRede: isFromRede ?? this.isFromRede,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      sku: data.sku.present ? data.sku.value : this.sku,
      description:
          data.description.present ? data.description.value : this.description,
      unitMeasure:
          data.unitMeasure.present ? data.unitMeasure.value : this.unitMeasure,
      packagingType: data.packagingType.present
          ? data.packagingType.value
          : this.packagingType,
      attributesJson: data.attributesJson.present
          ? data.attributesJson.value
          : this.attributesJson,
      isFromRede:
          data.isFromRede.present ? data.isFromRede.value : this.isFromRede,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('description: $description, ')
          ..write('unitMeasure: $unitMeasure, ')
          ..write('packagingType: $packagingType, ')
          ..write('attributesJson: $attributesJson, ')
          ..write('isFromRede: $isFromRede, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, description, unitMeasure,
      packagingType, attributesJson, isFromRede, isSynced, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.description == this.description &&
          other.unitMeasure == this.unitMeasure &&
          other.packagingType == this.packagingType &&
          other.attributesJson == this.attributesJson &&
          other.isFromRede == this.isFromRede &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> description;
  final Value<String> unitMeasure;
  final Value<String> packagingType;
  final Value<String> attributesJson;
  final Value<bool> isFromRede;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.description = const Value.absent(),
    this.unitMeasure = const Value.absent(),
    this.packagingType = const Value.absent(),
    this.attributesJson = const Value.absent(),
    this.isFromRede = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String description,
    required String unitMeasure,
    required String packagingType,
    required String attributesJson,
    this.isFromRede = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : description = Value(description),
        unitMeasure = Value(unitMeasure),
        packagingType = Value(packagingType),
        attributesJson = Value(attributesJson);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? description,
    Expression<String>? unitMeasure,
    Expression<String>? packagingType,
    Expression<String>? attributesJson,
    Expression<bool>? isFromRede,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (description != null) 'description': description,
      if (unitMeasure != null) 'unit_measure': unitMeasure,
      if (packagingType != null) 'packaging_type': packagingType,
      if (attributesJson != null) 'attributes_json': attributesJson,
      if (isFromRede != null) 'is_from_rede': isFromRede,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? description,
      Value<String>? unitMeasure,
      Value<String>? packagingType,
      Value<String>? attributesJson,
      Value<bool>? isFromRede,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return ProductsCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      description: description ?? this.description,
      unitMeasure: unitMeasure ?? this.unitMeasure,
      packagingType: packagingType ?? this.packagingType,
      attributesJson: attributesJson ?? this.attributesJson,
      isFromRede: isFromRede ?? this.isFromRede,
      isSynced: isSynced ?? this.isSynced,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unitMeasure.present) {
      map['unit_measure'] = Variable<String>(unitMeasure.value);
    }
    if (packagingType.present) {
      map['packaging_type'] = Variable<String>(packagingType.value);
    }
    if (attributesJson.present) {
      map['attributes_json'] = Variable<String>(attributesJson.value);
    }
    if (isFromRede.present) {
      map['is_from_rede'] = Variable<bool>(isFromRede.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('description: $description, ')
          ..write('unitMeasure: $unitMeasure, ')
          ..write('packagingType: $packagingType, ')
          ..write('attributesJson: $attributesJson, ')
          ..write('isFromRede: $isFromRede, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ProductSuppliersTable extends ProductSuppliers
    with TableInfo<$ProductSuppliersTable, ProductSupplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductSuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, productId, supplierId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<ProductSupplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductSupplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductSupplier(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
    );
  }

  @override
  $ProductSuppliersTable createAlias(String alias) {
    return $ProductSuppliersTable(attachedDatabase, alias);
  }
}

class ProductSupplier extends DataClass implements Insertable<ProductSupplier> {
  final int id;
  final int productId;
  final int supplierId;
  const ProductSupplier(
      {required this.id, required this.productId, required this.supplierId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['supplier_id'] = Variable<int>(supplierId);
    return map;
  }

  ProductSuppliersCompanion toCompanion(bool nullToAbsent) {
    return ProductSuppliersCompanion(
      id: Value(id),
      productId: Value(productId),
      supplierId: Value(supplierId),
    );
  }

  factory ProductSupplier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductSupplier(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'supplierId': serializer.toJson<int>(supplierId),
    };
  }

  ProductSupplier copyWith({int? id, int? productId, int? supplierId}) =>
      ProductSupplier(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        supplierId: supplierId ?? this.supplierId,
      );
  ProductSupplier copyWithCompanion(ProductSuppliersCompanion data) {
    return ProductSupplier(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductSupplier(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, supplierId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductSupplier &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.supplierId == this.supplierId);
}

class ProductSuppliersCompanion extends UpdateCompanion<ProductSupplier> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> supplierId;
  const ProductSuppliersCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.supplierId = const Value.absent(),
  });
  ProductSuppliersCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int supplierId,
  })  : productId = Value(productId),
        supplierId = Value(supplierId);
  static Insertable<ProductSupplier> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? supplierId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (supplierId != null) 'supplier_id': supplierId,
    });
  }

  ProductSuppliersCompanion copyWith(
      {Value<int>? id, Value<int>? productId, Value<int>? supplierId}) {
    return ProductSuppliersCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      supplierId: supplierId ?? this.supplierId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductSuppliersCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId')
          ..write(')'))
        .toString();
  }
}

class $QuotationsTable extends Quotations
    with TableInfo<$QuotationsTable, Quotation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _buyerIdMeta =
      const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
      'buyer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES buyers (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _templateMessageMeta =
      const VerificationMeta('templateMessage');
  @override
  late final GeneratedColumn<String> templateMessage = GeneratedColumn<String>(
      'template_message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalEconomyMeta =
      const VerificationMeta('totalEconomy');
  @override
  late final GeneratedColumn<double> totalEconomy = GeneratedColumn<double>(
      'total_economy', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _winnerSupplierIdMeta =
      const VerificationMeta('winnerSupplierId');
  @override
  late final GeneratedColumn<int> winnerSupplierId = GeneratedColumn<int>(
      'winner_supplier_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        buyerId,
        date,
        status,
        templateMessage,
        totalEconomy,
        winnerSupplierId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotations';
  @override
  VerificationContext validateIntegrity(Insertable<Quotation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('template_message')) {
      context.handle(
          _templateMessageMeta,
          templateMessage.isAcceptableOrUnknown(
              data['template_message']!, _templateMessageMeta));
    } else if (isInserting) {
      context.missing(_templateMessageMeta);
    }
    if (data.containsKey('total_economy')) {
      context.handle(
          _totalEconomyMeta,
          totalEconomy.isAcceptableOrUnknown(
              data['total_economy']!, _totalEconomyMeta));
    }
    if (data.containsKey('winner_supplier_id')) {
      context.handle(
          _winnerSupplierIdMeta,
          winnerSupplierId.isAcceptableOrUnknown(
              data['winner_supplier_id']!, _winnerSupplierIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quotation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quotation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      buyerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}buyer_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      templateMessage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}template_message'])!,
      totalEconomy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_economy'])!,
      winnerSupplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}winner_supplier_id']),
    );
  }

  @override
  $QuotationsTable createAlias(String alias) {
    return $QuotationsTable(attachedDatabase, alias);
  }
}

class Quotation extends DataClass implements Insertable<Quotation> {
  final int id;
  final int buyerId;
  final DateTime date;
  final String status;
  final String templateMessage;
  final double totalEconomy;
  final int? winnerSupplierId;
  const Quotation(
      {required this.id,
      required this.buyerId,
      required this.date,
      required this.status,
      required this.templateMessage,
      required this.totalEconomy,
      this.winnerSupplierId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    map['template_message'] = Variable<String>(templateMessage);
    map['total_economy'] = Variable<double>(totalEconomy);
    if (!nullToAbsent || winnerSupplierId != null) {
      map['winner_supplier_id'] = Variable<int>(winnerSupplierId);
    }
    return map;
  }

  QuotationsCompanion toCompanion(bool nullToAbsent) {
    return QuotationsCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      date: Value(date),
      status: Value(status),
      templateMessage: Value(templateMessage),
      totalEconomy: Value(totalEconomy),
      winnerSupplierId: winnerSupplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(winnerSupplierId),
    );
  }

  factory Quotation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quotation(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      templateMessage: serializer.fromJson<String>(json['templateMessage']),
      totalEconomy: serializer.fromJson<double>(json['totalEconomy']),
      winnerSupplierId: serializer.fromJson<int?>(json['winnerSupplierId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'templateMessage': serializer.toJson<String>(templateMessage),
      'totalEconomy': serializer.toJson<double>(totalEconomy),
      'winnerSupplierId': serializer.toJson<int?>(winnerSupplierId),
    };
  }

  Quotation copyWith(
          {int? id,
          int? buyerId,
          DateTime? date,
          String? status,
          String? templateMessage,
          double? totalEconomy,
          Value<int?> winnerSupplierId = const Value.absent()}) =>
      Quotation(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        date: date ?? this.date,
        status: status ?? this.status,
        templateMessage: templateMessage ?? this.templateMessage,
        totalEconomy: totalEconomy ?? this.totalEconomy,
        winnerSupplierId: winnerSupplierId.present
            ? winnerSupplierId.value
            : this.winnerSupplierId,
      );
  Quotation copyWithCompanion(QuotationsCompanion data) {
    return Quotation(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      templateMessage: data.templateMessage.present
          ? data.templateMessage.value
          : this.templateMessage,
      totalEconomy: data.totalEconomy.present
          ? data.totalEconomy.value
          : this.totalEconomy,
      winnerSupplierId: data.winnerSupplierId.present
          ? data.winnerSupplierId.value
          : this.winnerSupplierId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quotation(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('templateMessage: $templateMessage, ')
          ..write('totalEconomy: $totalEconomy, ')
          ..write('winnerSupplierId: $winnerSupplierId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, buyerId, date, status, templateMessage,
      totalEconomy, winnerSupplierId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quotation &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.date == this.date &&
          other.status == this.status &&
          other.templateMessage == this.templateMessage &&
          other.totalEconomy == this.totalEconomy &&
          other.winnerSupplierId == this.winnerSupplierId);
}

class QuotationsCompanion extends UpdateCompanion<Quotation> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<String> templateMessage;
  final Value<double> totalEconomy;
  final Value<int?> winnerSupplierId;
  const QuotationsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.templateMessage = const Value.absent(),
    this.totalEconomy = const Value.absent(),
    this.winnerSupplierId = const Value.absent(),
  });
  QuotationsCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required DateTime date,
    required String status,
    required String templateMessage,
    this.totalEconomy = const Value.absent(),
    this.winnerSupplierId = const Value.absent(),
  })  : buyerId = Value(buyerId),
        date = Value(date),
        status = Value(status),
        templateMessage = Value(templateMessage);
  static Insertable<Quotation> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<String>? templateMessage,
    Expression<double>? totalEconomy,
    Expression<int>? winnerSupplierId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (templateMessage != null) 'template_message': templateMessage,
      if (totalEconomy != null) 'total_economy': totalEconomy,
      if (winnerSupplierId != null) 'winner_supplier_id': winnerSupplierId,
    });
  }

  QuotationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? buyerId,
      Value<DateTime>? date,
      Value<String>? status,
      Value<String>? templateMessage,
      Value<double>? totalEconomy,
      Value<int?>? winnerSupplierId}) {
    return QuotationsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      date: date ?? this.date,
      status: status ?? this.status,
      templateMessage: templateMessage ?? this.templateMessage,
      totalEconomy: totalEconomy ?? this.totalEconomy,
      winnerSupplierId: winnerSupplierId ?? this.winnerSupplierId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (templateMessage.present) {
      map['template_message'] = Variable<String>(templateMessage.value);
    }
    if (totalEconomy.present) {
      map['total_economy'] = Variable<double>(totalEconomy.value);
    }
    if (winnerSupplierId.present) {
      map['winner_supplier_id'] = Variable<int>(winnerSupplierId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotationsCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('templateMessage: $templateMessage, ')
          ..write('totalEconomy: $totalEconomy, ')
          ..write('winnerSupplierId: $winnerSupplierId')
          ..write(')'))
        .toString();
  }
}

class $SupplierResponsesTable extends SupplierResponses
    with TableInfo<$SupplierResponsesTable, SupplierResponse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierResponsesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quotationItemIdMeta =
      const VerificationMeta('quotationItemId');
  @override
  late final GeneratedColumn<int> quotationItemId = GeneratedColumn<int>(
      'quotation_item_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  static const VerificationMeta _receivedMessageMeta =
      const VerificationMeta('receivedMessage');
  @override
  late final GeneratedColumn<String> receivedMessage = GeneratedColumn<String>(
      'received_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pricingExtractedMeta =
      const VerificationMeta('pricingExtracted');
  @override
  late final GeneratedColumn<double> pricingExtracted = GeneratedColumn<double>(
      'pricing_extracted', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _deliveryTimeDaysMeta =
      const VerificationMeta('deliveryTimeDays');
  @override
  late final GeneratedColumn<int> deliveryTimeDays = GeneratedColumn<int>(
      'delivery_time_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _responseDateMeta =
      const VerificationMeta('responseDate');
  @override
  late final GeneratedColumn<DateTime> responseDate = GeneratedColumn<DateTime>(
      'response_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSelectedMeta =
      const VerificationMeta('isSelected');
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
      'is_selected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_selected" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _paymentTermDaysMeta =
      const VerificationMeta('paymentTermDays');
  @override
  late final GeneratedColumn<int> paymentTermDays = GeneratedColumn<int>(
      'payment_term_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentConditionMeta =
      const VerificationMeta('paymentCondition');
  @override
  late final GeneratedColumn<String> paymentCondition = GeneratedColumn<String>(
      'payment_condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _earlyDiscountPercentMeta =
      const VerificationMeta('earlyDiscountPercent');
  @override
  late final GeneratedColumn<double> earlyDiscountPercent =
      GeneratedColumn<double>('early_discount_percent', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _calculatedScoreMeta =
      const VerificationMeta('calculatedScore');
  @override
  late final GeneratedColumn<int> calculatedScore = GeneratedColumn<int>(
      'calculated_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        quotationItemId,
        supplierId,
        receivedMessage,
        pricingExtracted,
        deliveryTimeDays,
        responseDate,
        status,
        isSelected,
        paymentTermDays,
        paymentCondition,
        earlyDiscountPercent,
        calculatedScore
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_responses';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierResponse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quotation_item_id')) {
      context.handle(
          _quotationItemIdMeta,
          quotationItemId.isAcceptableOrUnknown(
              data['quotation_item_id']!, _quotationItemIdMeta));
    } else if (isInserting) {
      context.missing(_quotationItemIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('received_message')) {
      context.handle(
          _receivedMessageMeta,
          receivedMessage.isAcceptableOrUnknown(
              data['received_message']!, _receivedMessageMeta));
    }
    if (data.containsKey('pricing_extracted')) {
      context.handle(
          _pricingExtractedMeta,
          pricingExtracted.isAcceptableOrUnknown(
              data['pricing_extracted']!, _pricingExtractedMeta));
    }
    if (data.containsKey('delivery_time_days')) {
      context.handle(
          _deliveryTimeDaysMeta,
          deliveryTimeDays.isAcceptableOrUnknown(
              data['delivery_time_days']!, _deliveryTimeDaysMeta));
    }
    if (data.containsKey('response_date')) {
      context.handle(
          _responseDateMeta,
          responseDate.isAcceptableOrUnknown(
              data['response_date']!, _responseDateMeta));
    } else if (isInserting) {
      context.missing(_responseDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected']!, _isSelectedMeta));
    }
    if (data.containsKey('payment_term_days')) {
      context.handle(
          _paymentTermDaysMeta,
          paymentTermDays.isAcceptableOrUnknown(
              data['payment_term_days']!, _paymentTermDaysMeta));
    }
    if (data.containsKey('payment_condition')) {
      context.handle(
          _paymentConditionMeta,
          paymentCondition.isAcceptableOrUnknown(
              data['payment_condition']!, _paymentConditionMeta));
    }
    if (data.containsKey('early_discount_percent')) {
      context.handle(
          _earlyDiscountPercentMeta,
          earlyDiscountPercent.isAcceptableOrUnknown(
              data['early_discount_percent']!, _earlyDiscountPercentMeta));
    }
    if (data.containsKey('calculated_score')) {
      context.handle(
          _calculatedScoreMeta,
          calculatedScore.isAcceptableOrUnknown(
              data['calculated_score']!, _calculatedScoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierResponse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierResponse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quotationItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quotation_item_id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      receivedMessage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}received_message']),
      pricingExtracted: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}pricing_extracted']),
      deliveryTimeDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}delivery_time_days']),
      responseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}response_date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isSelected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_selected'])!,
      paymentTermDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_term_days']),
      paymentCondition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_condition']),
      earlyDiscountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}early_discount_percent']),
      calculatedScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calculated_score'])!,
    );
  }

  @override
  $SupplierResponsesTable createAlias(String alias) {
    return $SupplierResponsesTable(attachedDatabase, alias);
  }
}

class SupplierResponse extends DataClass
    implements Insertable<SupplierResponse> {
  final int id;
  final int quotationItemId;
  final int supplierId;
  final String? receivedMessage;
  final double? pricingExtracted;
  final int? deliveryTimeDays;
  final DateTime responseDate;
  final String status;
  final bool isSelected;
  final int? paymentTermDays;
  final String? paymentCondition;
  final double? earlyDiscountPercent;
  final int calculatedScore;
  const SupplierResponse(
      {required this.id,
      required this.quotationItemId,
      required this.supplierId,
      this.receivedMessage,
      this.pricingExtracted,
      this.deliveryTimeDays,
      required this.responseDate,
      required this.status,
      required this.isSelected,
      this.paymentTermDays,
      this.paymentCondition,
      this.earlyDiscountPercent,
      required this.calculatedScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quotation_item_id'] = Variable<int>(quotationItemId);
    map['supplier_id'] = Variable<int>(supplierId);
    if (!nullToAbsent || receivedMessage != null) {
      map['received_message'] = Variable<String>(receivedMessage);
    }
    if (!nullToAbsent || pricingExtracted != null) {
      map['pricing_extracted'] = Variable<double>(pricingExtracted);
    }
    if (!nullToAbsent || deliveryTimeDays != null) {
      map['delivery_time_days'] = Variable<int>(deliveryTimeDays);
    }
    map['response_date'] = Variable<DateTime>(responseDate);
    map['status'] = Variable<String>(status);
    map['is_selected'] = Variable<bool>(isSelected);
    if (!nullToAbsent || paymentTermDays != null) {
      map['payment_term_days'] = Variable<int>(paymentTermDays);
    }
    if (!nullToAbsent || paymentCondition != null) {
      map['payment_condition'] = Variable<String>(paymentCondition);
    }
    if (!nullToAbsent || earlyDiscountPercent != null) {
      map['early_discount_percent'] = Variable<double>(earlyDiscountPercent);
    }
    map['calculated_score'] = Variable<int>(calculatedScore);
    return map;
  }

  SupplierResponsesCompanion toCompanion(bool nullToAbsent) {
    return SupplierResponsesCompanion(
      id: Value(id),
      quotationItemId: Value(quotationItemId),
      supplierId: Value(supplierId),
      receivedMessage: receivedMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedMessage),
      pricingExtracted: pricingExtracted == null && nullToAbsent
          ? const Value.absent()
          : Value(pricingExtracted),
      deliveryTimeDays: deliveryTimeDays == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryTimeDays),
      responseDate: Value(responseDate),
      status: Value(status),
      isSelected: Value(isSelected),
      paymentTermDays: paymentTermDays == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTermDays),
      paymentCondition: paymentCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentCondition),
      earlyDiscountPercent: earlyDiscountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(earlyDiscountPercent),
      calculatedScore: Value(calculatedScore),
    );
  }

  factory SupplierResponse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierResponse(
      id: serializer.fromJson<int>(json['id']),
      quotationItemId: serializer.fromJson<int>(json['quotationItemId']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      receivedMessage: serializer.fromJson<String?>(json['receivedMessage']),
      pricingExtracted: serializer.fromJson<double?>(json['pricingExtracted']),
      deliveryTimeDays: serializer.fromJson<int?>(json['deliveryTimeDays']),
      responseDate: serializer.fromJson<DateTime>(json['responseDate']),
      status: serializer.fromJson<String>(json['status']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      paymentTermDays: serializer.fromJson<int?>(json['paymentTermDays']),
      paymentCondition: serializer.fromJson<String?>(json['paymentCondition']),
      earlyDiscountPercent:
          serializer.fromJson<double?>(json['earlyDiscountPercent']),
      calculatedScore: serializer.fromJson<int>(json['calculatedScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quotationItemId': serializer.toJson<int>(quotationItemId),
      'supplierId': serializer.toJson<int>(supplierId),
      'receivedMessage': serializer.toJson<String?>(receivedMessage),
      'pricingExtracted': serializer.toJson<double?>(pricingExtracted),
      'deliveryTimeDays': serializer.toJson<int?>(deliveryTimeDays),
      'responseDate': serializer.toJson<DateTime>(responseDate),
      'status': serializer.toJson<String>(status),
      'isSelected': serializer.toJson<bool>(isSelected),
      'paymentTermDays': serializer.toJson<int?>(paymentTermDays),
      'paymentCondition': serializer.toJson<String?>(paymentCondition),
      'earlyDiscountPercent': serializer.toJson<double?>(earlyDiscountPercent),
      'calculatedScore': serializer.toJson<int>(calculatedScore),
    };
  }

  SupplierResponse copyWith(
          {int? id,
          int? quotationItemId,
          int? supplierId,
          Value<String?> receivedMessage = const Value.absent(),
          Value<double?> pricingExtracted = const Value.absent(),
          Value<int?> deliveryTimeDays = const Value.absent(),
          DateTime? responseDate,
          String? status,
          bool? isSelected,
          Value<int?> paymentTermDays = const Value.absent(),
          Value<String?> paymentCondition = const Value.absent(),
          Value<double?> earlyDiscountPercent = const Value.absent(),
          int? calculatedScore}) =>
      SupplierResponse(
        id: id ?? this.id,
        quotationItemId: quotationItemId ?? this.quotationItemId,
        supplierId: supplierId ?? this.supplierId,
        receivedMessage: receivedMessage.present
            ? receivedMessage.value
            : this.receivedMessage,
        pricingExtracted: pricingExtracted.present
            ? pricingExtracted.value
            : this.pricingExtracted,
        deliveryTimeDays: deliveryTimeDays.present
            ? deliveryTimeDays.value
            : this.deliveryTimeDays,
        responseDate: responseDate ?? this.responseDate,
        status: status ?? this.status,
        isSelected: isSelected ?? this.isSelected,
        paymentTermDays: paymentTermDays.present
            ? paymentTermDays.value
            : this.paymentTermDays,
        paymentCondition: paymentCondition.present
            ? paymentCondition.value
            : this.paymentCondition,
        earlyDiscountPercent: earlyDiscountPercent.present
            ? earlyDiscountPercent.value
            : this.earlyDiscountPercent,
        calculatedScore: calculatedScore ?? this.calculatedScore,
      );
  SupplierResponse copyWithCompanion(SupplierResponsesCompanion data) {
    return SupplierResponse(
      id: data.id.present ? data.id.value : this.id,
      quotationItemId: data.quotationItemId.present
          ? data.quotationItemId.value
          : this.quotationItemId,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      receivedMessage: data.receivedMessage.present
          ? data.receivedMessage.value
          : this.receivedMessage,
      pricingExtracted: data.pricingExtracted.present
          ? data.pricingExtracted.value
          : this.pricingExtracted,
      deliveryTimeDays: data.deliveryTimeDays.present
          ? data.deliveryTimeDays.value
          : this.deliveryTimeDays,
      responseDate: data.responseDate.present
          ? data.responseDate.value
          : this.responseDate,
      status: data.status.present ? data.status.value : this.status,
      isSelected:
          data.isSelected.present ? data.isSelected.value : this.isSelected,
      paymentTermDays: data.paymentTermDays.present
          ? data.paymentTermDays.value
          : this.paymentTermDays,
      paymentCondition: data.paymentCondition.present
          ? data.paymentCondition.value
          : this.paymentCondition,
      earlyDiscountPercent: data.earlyDiscountPercent.present
          ? data.earlyDiscountPercent.value
          : this.earlyDiscountPercent,
      calculatedScore: data.calculatedScore.present
          ? data.calculatedScore.value
          : this.calculatedScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierResponse(')
          ..write('id: $id, ')
          ..write('quotationItemId: $quotationItemId, ')
          ..write('supplierId: $supplierId, ')
          ..write('receivedMessage: $receivedMessage, ')
          ..write('pricingExtracted: $pricingExtracted, ')
          ..write('deliveryTimeDays: $deliveryTimeDays, ')
          ..write('responseDate: $responseDate, ')
          ..write('status: $status, ')
          ..write('isSelected: $isSelected, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('paymentCondition: $paymentCondition, ')
          ..write('earlyDiscountPercent: $earlyDiscountPercent, ')
          ..write('calculatedScore: $calculatedScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      quotationItemId,
      supplierId,
      receivedMessage,
      pricingExtracted,
      deliveryTimeDays,
      responseDate,
      status,
      isSelected,
      paymentTermDays,
      paymentCondition,
      earlyDiscountPercent,
      calculatedScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierResponse &&
          other.id == this.id &&
          other.quotationItemId == this.quotationItemId &&
          other.supplierId == this.supplierId &&
          other.receivedMessage == this.receivedMessage &&
          other.pricingExtracted == this.pricingExtracted &&
          other.deliveryTimeDays == this.deliveryTimeDays &&
          other.responseDate == this.responseDate &&
          other.status == this.status &&
          other.isSelected == this.isSelected &&
          other.paymentTermDays == this.paymentTermDays &&
          other.paymentCondition == this.paymentCondition &&
          other.earlyDiscountPercent == this.earlyDiscountPercent &&
          other.calculatedScore == this.calculatedScore);
}

class SupplierResponsesCompanion extends UpdateCompanion<SupplierResponse> {
  final Value<int> id;
  final Value<int> quotationItemId;
  final Value<int> supplierId;
  final Value<String?> receivedMessage;
  final Value<double?> pricingExtracted;
  final Value<int?> deliveryTimeDays;
  final Value<DateTime> responseDate;
  final Value<String> status;
  final Value<bool> isSelected;
  final Value<int?> paymentTermDays;
  final Value<String?> paymentCondition;
  final Value<double?> earlyDiscountPercent;
  final Value<int> calculatedScore;
  const SupplierResponsesCompanion({
    this.id = const Value.absent(),
    this.quotationItemId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.receivedMessage = const Value.absent(),
    this.pricingExtracted = const Value.absent(),
    this.deliveryTimeDays = const Value.absent(),
    this.responseDate = const Value.absent(),
    this.status = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.paymentCondition = const Value.absent(),
    this.earlyDiscountPercent = const Value.absent(),
    this.calculatedScore = const Value.absent(),
  });
  SupplierResponsesCompanion.insert({
    this.id = const Value.absent(),
    required int quotationItemId,
    required int supplierId,
    this.receivedMessage = const Value.absent(),
    this.pricingExtracted = const Value.absent(),
    this.deliveryTimeDays = const Value.absent(),
    required DateTime responseDate,
    required String status,
    this.isSelected = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.paymentCondition = const Value.absent(),
    this.earlyDiscountPercent = const Value.absent(),
    this.calculatedScore = const Value.absent(),
  })  : quotationItemId = Value(quotationItemId),
        supplierId = Value(supplierId),
        responseDate = Value(responseDate),
        status = Value(status);
  static Insertable<SupplierResponse> custom({
    Expression<int>? id,
    Expression<int>? quotationItemId,
    Expression<int>? supplierId,
    Expression<String>? receivedMessage,
    Expression<double>? pricingExtracted,
    Expression<int>? deliveryTimeDays,
    Expression<DateTime>? responseDate,
    Expression<String>? status,
    Expression<bool>? isSelected,
    Expression<int>? paymentTermDays,
    Expression<String>? paymentCondition,
    Expression<double>? earlyDiscountPercent,
    Expression<int>? calculatedScore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quotationItemId != null) 'quotation_item_id': quotationItemId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (receivedMessage != null) 'received_message': receivedMessage,
      if (pricingExtracted != null) 'pricing_extracted': pricingExtracted,
      if (deliveryTimeDays != null) 'delivery_time_days': deliveryTimeDays,
      if (responseDate != null) 'response_date': responseDate,
      if (status != null) 'status': status,
      if (isSelected != null) 'is_selected': isSelected,
      if (paymentTermDays != null) 'payment_term_days': paymentTermDays,
      if (paymentCondition != null) 'payment_condition': paymentCondition,
      if (earlyDiscountPercent != null)
        'early_discount_percent': earlyDiscountPercent,
      if (calculatedScore != null) 'calculated_score': calculatedScore,
    });
  }

  SupplierResponsesCompanion copyWith(
      {Value<int>? id,
      Value<int>? quotationItemId,
      Value<int>? supplierId,
      Value<String?>? receivedMessage,
      Value<double?>? pricingExtracted,
      Value<int?>? deliveryTimeDays,
      Value<DateTime>? responseDate,
      Value<String>? status,
      Value<bool>? isSelected,
      Value<int?>? paymentTermDays,
      Value<String?>? paymentCondition,
      Value<double?>? earlyDiscountPercent,
      Value<int>? calculatedScore}) {
    return SupplierResponsesCompanion(
      id: id ?? this.id,
      quotationItemId: quotationItemId ?? this.quotationItemId,
      supplierId: supplierId ?? this.supplierId,
      receivedMessage: receivedMessage ?? this.receivedMessage,
      pricingExtracted: pricingExtracted ?? this.pricingExtracted,
      deliveryTimeDays: deliveryTimeDays ?? this.deliveryTimeDays,
      responseDate: responseDate ?? this.responseDate,
      status: status ?? this.status,
      isSelected: isSelected ?? this.isSelected,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      earlyDiscountPercent: earlyDiscountPercent ?? this.earlyDiscountPercent,
      calculatedScore: calculatedScore ?? this.calculatedScore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quotationItemId.present) {
      map['quotation_item_id'] = Variable<int>(quotationItemId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (receivedMessage.present) {
      map['received_message'] = Variable<String>(receivedMessage.value);
    }
    if (pricingExtracted.present) {
      map['pricing_extracted'] = Variable<double>(pricingExtracted.value);
    }
    if (deliveryTimeDays.present) {
      map['delivery_time_days'] = Variable<int>(deliveryTimeDays.value);
    }
    if (responseDate.present) {
      map['response_date'] = Variable<DateTime>(responseDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (paymentTermDays.present) {
      map['payment_term_days'] = Variable<int>(paymentTermDays.value);
    }
    if (paymentCondition.present) {
      map['payment_condition'] = Variable<String>(paymentCondition.value);
    }
    if (earlyDiscountPercent.present) {
      map['early_discount_percent'] =
          Variable<double>(earlyDiscountPercent.value);
    }
    if (calculatedScore.present) {
      map['calculated_score'] = Variable<int>(calculatedScore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierResponsesCompanion(')
          ..write('id: $id, ')
          ..write('quotationItemId: $quotationItemId, ')
          ..write('supplierId: $supplierId, ')
          ..write('receivedMessage: $receivedMessage, ')
          ..write('pricingExtracted: $pricingExtracted, ')
          ..write('deliveryTimeDays: $deliveryTimeDays, ')
          ..write('responseDate: $responseDate, ')
          ..write('status: $status, ')
          ..write('isSelected: $isSelected, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('paymentCondition: $paymentCondition, ')
          ..write('earlyDiscountPercent: $earlyDiscountPercent, ')
          ..write('calculatedScore: $calculatedScore')
          ..write(')'))
        .toString();
  }
}

class $QuotationItemsTable extends QuotationItems
    with TableInfo<$QuotationItemsTable, QuotationItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotationItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quotationIdMeta =
      const VerificationMeta('quotationId');
  @override
  late final GeneratedColumn<int> quotationId = GeneratedColumn<int>(
      'quotation_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES quotations (id)'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _requestedPriceMeta =
      const VerificationMeta('requestedPrice');
  @override
  late final GeneratedColumn<double> requestedPrice = GeneratedColumn<double>(
      'requested_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _deliveryTypeMeta =
      const VerificationMeta('deliveryType');
  @override
  late final GeneratedColumn<String> deliveryType = GeneratedColumn<String>(
      'delivery_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _desiredLeadTimeMeta =
      const VerificationMeta('desiredLeadTime');
  @override
  late final GeneratedColumn<int> desiredLeadTime = GeneratedColumn<int>(
      'desired_lead_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentTermDaysMeta =
      const VerificationMeta('paymentTermDays');
  @override
  late final GeneratedColumn<int> paymentTermDays = GeneratedColumn<int>(
      'payment_term_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentConditionMeta =
      const VerificationMeta('paymentCondition');
  @override
  late final GeneratedColumn<String> paymentCondition = GeneratedColumn<String>(
      'payment_condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bestResponseIdMeta =
      const VerificationMeta('bestResponseId');
  @override
  late final GeneratedColumn<int> bestResponseId = GeneratedColumn<int>(
      'best_response_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES supplier_responses (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        quotationId,
        productId,
        quantity,
        requestedPrice,
        deliveryType,
        desiredLeadTime,
        paymentTermDays,
        paymentCondition,
        bestResponseId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotation_items';
  @override
  VerificationContext validateIntegrity(Insertable<QuotationItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quotation_id')) {
      context.handle(
          _quotationIdMeta,
          quotationId.isAcceptableOrUnknown(
              data['quotation_id']!, _quotationIdMeta));
    } else if (isInserting) {
      context.missing(_quotationIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('requested_price')) {
      context.handle(
          _requestedPriceMeta,
          requestedPrice.isAcceptableOrUnknown(
              data['requested_price']!, _requestedPriceMeta));
    }
    if (data.containsKey('delivery_type')) {
      context.handle(
          _deliveryTypeMeta,
          deliveryType.isAcceptableOrUnknown(
              data['delivery_type']!, _deliveryTypeMeta));
    }
    if (data.containsKey('desired_lead_time')) {
      context.handle(
          _desiredLeadTimeMeta,
          desiredLeadTime.isAcceptableOrUnknown(
              data['desired_lead_time']!, _desiredLeadTimeMeta));
    }
    if (data.containsKey('payment_term_days')) {
      context.handle(
          _paymentTermDaysMeta,
          paymentTermDays.isAcceptableOrUnknown(
              data['payment_term_days']!, _paymentTermDaysMeta));
    }
    if (data.containsKey('payment_condition')) {
      context.handle(
          _paymentConditionMeta,
          paymentCondition.isAcceptableOrUnknown(
              data['payment_condition']!, _paymentConditionMeta));
    }
    if (data.containsKey('best_response_id')) {
      context.handle(
          _bestResponseIdMeta,
          bestResponseId.isAcceptableOrUnknown(
              data['best_response_id']!, _bestResponseIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuotationItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuotationItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quotationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quotation_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      requestedPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}requested_price']),
      deliveryType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}delivery_type']),
      desiredLeadTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}desired_lead_time']),
      paymentTermDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_term_days']),
      paymentCondition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_condition']),
      bestResponseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_response_id']),
    );
  }

  @override
  $QuotationItemsTable createAlias(String alias) {
    return $QuotationItemsTable(attachedDatabase, alias);
  }
}

class QuotationItem extends DataClass implements Insertable<QuotationItem> {
  final int id;
  final int quotationId;
  final int productId;
  final double quantity;
  final double? requestedPrice;
  final String? deliveryType;
  final int? desiredLeadTime;
  final int? paymentTermDays;
  final String? paymentCondition;
  final int? bestResponseId;
  const QuotationItem(
      {required this.id,
      required this.quotationId,
      required this.productId,
      required this.quantity,
      this.requestedPrice,
      this.deliveryType,
      this.desiredLeadTime,
      this.paymentTermDays,
      this.paymentCondition,
      this.bestResponseId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quotation_id'] = Variable<int>(quotationId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || requestedPrice != null) {
      map['requested_price'] = Variable<double>(requestedPrice);
    }
    if (!nullToAbsent || deliveryType != null) {
      map['delivery_type'] = Variable<String>(deliveryType);
    }
    if (!nullToAbsent || desiredLeadTime != null) {
      map['desired_lead_time'] = Variable<int>(desiredLeadTime);
    }
    if (!nullToAbsent || paymentTermDays != null) {
      map['payment_term_days'] = Variable<int>(paymentTermDays);
    }
    if (!nullToAbsent || paymentCondition != null) {
      map['payment_condition'] = Variable<String>(paymentCondition);
    }
    if (!nullToAbsent || bestResponseId != null) {
      map['best_response_id'] = Variable<int>(bestResponseId);
    }
    return map;
  }

  QuotationItemsCompanion toCompanion(bool nullToAbsent) {
    return QuotationItemsCompanion(
      id: Value(id),
      quotationId: Value(quotationId),
      productId: Value(productId),
      quantity: Value(quantity),
      requestedPrice: requestedPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(requestedPrice),
      deliveryType: deliveryType == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryType),
      desiredLeadTime: desiredLeadTime == null && nullToAbsent
          ? const Value.absent()
          : Value(desiredLeadTime),
      paymentTermDays: paymentTermDays == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTermDays),
      paymentCondition: paymentCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentCondition),
      bestResponseId: bestResponseId == null && nullToAbsent
          ? const Value.absent()
          : Value(bestResponseId),
    );
  }

  factory QuotationItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuotationItem(
      id: serializer.fromJson<int>(json['id']),
      quotationId: serializer.fromJson<int>(json['quotationId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      requestedPrice: serializer.fromJson<double?>(json['requestedPrice']),
      deliveryType: serializer.fromJson<String?>(json['deliveryType']),
      desiredLeadTime: serializer.fromJson<int?>(json['desiredLeadTime']),
      paymentTermDays: serializer.fromJson<int?>(json['paymentTermDays']),
      paymentCondition: serializer.fromJson<String?>(json['paymentCondition']),
      bestResponseId: serializer.fromJson<int?>(json['bestResponseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quotationId': serializer.toJson<int>(quotationId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'requestedPrice': serializer.toJson<double?>(requestedPrice),
      'deliveryType': serializer.toJson<String?>(deliveryType),
      'desiredLeadTime': serializer.toJson<int?>(desiredLeadTime),
      'paymentTermDays': serializer.toJson<int?>(paymentTermDays),
      'paymentCondition': serializer.toJson<String?>(paymentCondition),
      'bestResponseId': serializer.toJson<int?>(bestResponseId),
    };
  }

  QuotationItem copyWith(
          {int? id,
          int? quotationId,
          int? productId,
          double? quantity,
          Value<double?> requestedPrice = const Value.absent(),
          Value<String?> deliveryType = const Value.absent(),
          Value<int?> desiredLeadTime = const Value.absent(),
          Value<int?> paymentTermDays = const Value.absent(),
          Value<String?> paymentCondition = const Value.absent(),
          Value<int?> bestResponseId = const Value.absent()}) =>
      QuotationItem(
        id: id ?? this.id,
        quotationId: quotationId ?? this.quotationId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        requestedPrice:
            requestedPrice.present ? requestedPrice.value : this.requestedPrice,
        deliveryType:
            deliveryType.present ? deliveryType.value : this.deliveryType,
        desiredLeadTime: desiredLeadTime.present
            ? desiredLeadTime.value
            : this.desiredLeadTime,
        paymentTermDays: paymentTermDays.present
            ? paymentTermDays.value
            : this.paymentTermDays,
        paymentCondition: paymentCondition.present
            ? paymentCondition.value
            : this.paymentCondition,
        bestResponseId:
            bestResponseId.present ? bestResponseId.value : this.bestResponseId,
      );
  QuotationItem copyWithCompanion(QuotationItemsCompanion data) {
    return QuotationItem(
      id: data.id.present ? data.id.value : this.id,
      quotationId:
          data.quotationId.present ? data.quotationId.value : this.quotationId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      requestedPrice: data.requestedPrice.present
          ? data.requestedPrice.value
          : this.requestedPrice,
      deliveryType: data.deliveryType.present
          ? data.deliveryType.value
          : this.deliveryType,
      desiredLeadTime: data.desiredLeadTime.present
          ? data.desiredLeadTime.value
          : this.desiredLeadTime,
      paymentTermDays: data.paymentTermDays.present
          ? data.paymentTermDays.value
          : this.paymentTermDays,
      paymentCondition: data.paymentCondition.present
          ? data.paymentCondition.value
          : this.paymentCondition,
      bestResponseId: data.bestResponseId.present
          ? data.bestResponseId.value
          : this.bestResponseId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuotationItem(')
          ..write('id: $id, ')
          ..write('quotationId: $quotationId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('requestedPrice: $requestedPrice, ')
          ..write('deliveryType: $deliveryType, ')
          ..write('desiredLeadTime: $desiredLeadTime, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('paymentCondition: $paymentCondition, ')
          ..write('bestResponseId: $bestResponseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      quotationId,
      productId,
      quantity,
      requestedPrice,
      deliveryType,
      desiredLeadTime,
      paymentTermDays,
      paymentCondition,
      bestResponseId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuotationItem &&
          other.id == this.id &&
          other.quotationId == this.quotationId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.requestedPrice == this.requestedPrice &&
          other.deliveryType == this.deliveryType &&
          other.desiredLeadTime == this.desiredLeadTime &&
          other.paymentTermDays == this.paymentTermDays &&
          other.paymentCondition == this.paymentCondition &&
          other.bestResponseId == this.bestResponseId);
}

class QuotationItemsCompanion extends UpdateCompanion<QuotationItem> {
  final Value<int> id;
  final Value<int> quotationId;
  final Value<int> productId;
  final Value<double> quantity;
  final Value<double?> requestedPrice;
  final Value<String?> deliveryType;
  final Value<int?> desiredLeadTime;
  final Value<int?> paymentTermDays;
  final Value<String?> paymentCondition;
  final Value<int?> bestResponseId;
  const QuotationItemsCompanion({
    this.id = const Value.absent(),
    this.quotationId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.requestedPrice = const Value.absent(),
    this.deliveryType = const Value.absent(),
    this.desiredLeadTime = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.paymentCondition = const Value.absent(),
    this.bestResponseId = const Value.absent(),
  });
  QuotationItemsCompanion.insert({
    this.id = const Value.absent(),
    required int quotationId,
    required int productId,
    required double quantity,
    this.requestedPrice = const Value.absent(),
    this.deliveryType = const Value.absent(),
    this.desiredLeadTime = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.paymentCondition = const Value.absent(),
    this.bestResponseId = const Value.absent(),
  })  : quotationId = Value(quotationId),
        productId = Value(productId),
        quantity = Value(quantity);
  static Insertable<QuotationItem> custom({
    Expression<int>? id,
    Expression<int>? quotationId,
    Expression<int>? productId,
    Expression<double>? quantity,
    Expression<double>? requestedPrice,
    Expression<String>? deliveryType,
    Expression<int>? desiredLeadTime,
    Expression<int>? paymentTermDays,
    Expression<String>? paymentCondition,
    Expression<int>? bestResponseId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quotationId != null) 'quotation_id': quotationId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (requestedPrice != null) 'requested_price': requestedPrice,
      if (deliveryType != null) 'delivery_type': deliveryType,
      if (desiredLeadTime != null) 'desired_lead_time': desiredLeadTime,
      if (paymentTermDays != null) 'payment_term_days': paymentTermDays,
      if (paymentCondition != null) 'payment_condition': paymentCondition,
      if (bestResponseId != null) 'best_response_id': bestResponseId,
    });
  }

  QuotationItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? quotationId,
      Value<int>? productId,
      Value<double>? quantity,
      Value<double?>? requestedPrice,
      Value<String?>? deliveryType,
      Value<int?>? desiredLeadTime,
      Value<int?>? paymentTermDays,
      Value<String?>? paymentCondition,
      Value<int?>? bestResponseId}) {
    return QuotationItemsCompanion(
      id: id ?? this.id,
      quotationId: quotationId ?? this.quotationId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      requestedPrice: requestedPrice ?? this.requestedPrice,
      deliveryType: deliveryType ?? this.deliveryType,
      desiredLeadTime: desiredLeadTime ?? this.desiredLeadTime,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      bestResponseId: bestResponseId ?? this.bestResponseId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quotationId.present) {
      map['quotation_id'] = Variable<int>(quotationId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (requestedPrice.present) {
      map['requested_price'] = Variable<double>(requestedPrice.value);
    }
    if (deliveryType.present) {
      map['delivery_type'] = Variable<String>(deliveryType.value);
    }
    if (desiredLeadTime.present) {
      map['desired_lead_time'] = Variable<int>(desiredLeadTime.value);
    }
    if (paymentTermDays.present) {
      map['payment_term_days'] = Variable<int>(paymentTermDays.value);
    }
    if (paymentCondition.present) {
      map['payment_condition'] = Variable<String>(paymentCondition.value);
    }
    if (bestResponseId.present) {
      map['best_response_id'] = Variable<int>(bestResponseId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotationItemsCompanion(')
          ..write('id: $id, ')
          ..write('quotationId: $quotationId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('requestedPrice: $requestedPrice, ')
          ..write('deliveryType: $deliveryType, ')
          ..write('desiredLeadTime: $desiredLeadTime, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('paymentCondition: $paymentCondition, ')
          ..write('bestResponseId: $bestResponseId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BuyersTable buyers = $BuyersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductSuppliersTable productSuppliers =
      $ProductSuppliersTable(this);
  late final $QuotationsTable quotations = $QuotationsTable(this);
  late final $SupplierResponsesTable supplierResponses =
      $SupplierResponsesTable(this);
  late final $QuotationItemsTable quotationItems = $QuotationItemsTable(this);
  late final BuyersDao buyersDao = BuyersDao(this as AppDatabase);
  late final SuppliersDao suppliersDao = SuppliersDao(this as AppDatabase);
  late final ProductsDao productsDao = ProductsDao(this as AppDatabase);
  late final QuotationsDao quotationsDao = QuotationsDao(this as AppDatabase);
  late final SupplierResponsesDao supplierResponsesDao =
      SupplierResponsesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        buyers,
        suppliers,
        products,
        productSuppliers,
        quotations,
        supplierResponses,
        quotationItems
      ];
}

typedef $$BuyersTableCreateCompanionBuilder = BuyersCompanion Function({
  Value<int> id,
  required String name,
  required String company,
  required String whatsapp,
  Value<String?> email,
  Value<String?> role,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$BuyersTableUpdateCompanionBuilder = BuyersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> company,
  Value<String> whatsapp,
  Value<String?> email,
  Value<String?> role,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$BuyersTableReferences
    extends BaseReferences<_$AppDatabase, $BuyersTable, Buyer> {
  $$BuyersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
      _quotationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.quotations,
          aliasName: $_aliasNameGenerator(db.buyers.id, db.quotations.buyerId));

  $$QuotationsTableProcessedTableManager get quotationsRefs {
    final manager = $$QuotationsTableTableManager($_db, $_db.quotations)
        .filter((f) => f.buyerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BuyersTableFilterComposer
    extends Composer<_$AppDatabase, $BuyersTable> {
  $$BuyersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> quotationsRefs(
      Expression<bool> Function($$QuotationsTableFilterComposer f) f) {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableFilterComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BuyersTableOrderingComposer
    extends Composer<_$AppDatabase, $BuyersTable> {
  $$BuyersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$BuyersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuyersTable> {
  $$BuyersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> quotationsRefs<T extends Object>(
      Expression<T> Function($$QuotationsTableAnnotationComposer a) f) {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BuyersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BuyersTable,
    Buyer,
    $$BuyersTableFilterComposer,
    $$BuyersTableOrderingComposer,
    $$BuyersTableAnnotationComposer,
    $$BuyersTableCreateCompanionBuilder,
    $$BuyersTableUpdateCompanionBuilder,
    (Buyer, $$BuyersTableReferences),
    Buyer,
    PrefetchHooks Function({bool quotationsRefs})> {
  $$BuyersTableTableManager(_$AppDatabase db, $BuyersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuyersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuyersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuyersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> company = const Value.absent(),
            Value<String> whatsapp = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              BuyersCompanion(
            id: id,
            name: name,
            company: company,
            whatsapp: whatsapp,
            email: email,
            role: role,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String company,
            required String whatsapp,
            Value<String?> email = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              BuyersCompanion.insert(
            id: id,
            name: name,
            company: company,
            whatsapp: whatsapp,
            email: email,
            role: role,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BuyersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({quotationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (quotationsRefs) db.quotations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotationsRefs)
                    await $_getPrefetchedData<Buyer, $BuyersTable, Quotation>(
                        currentTable: table,
                        referencedTable:
                            $$BuyersTableReferences._quotationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BuyersTableReferences(db, table, p0)
                                .quotationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.buyerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BuyersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BuyersTable,
    Buyer,
    $$BuyersTableFilterComposer,
    $$BuyersTableOrderingComposer,
    $$BuyersTableAnnotationComposer,
    $$BuyersTableCreateCompanionBuilder,
    $$BuyersTableUpdateCompanionBuilder,
    (Buyer, $$BuyersTableReferences),
    Buyer,
    PrefetchHooks Function({bool quotationsRefs})>;
typedef $$SuppliersTableCreateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  required String tradeName,
  required String whatsapp,
  Value<String?> address,
  Value<String?> observations,
  Value<bool> active,
  Value<bool> isSelfRegistered,
  Value<bool> isRedeCotazap,
  Value<int> priorityScore,
  Value<bool> approved,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$SuppliersTableUpdateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  Value<String> tradeName,
  Value<String> whatsapp,
  Value<String?> address,
  Value<String?> observations,
  Value<bool> active,
  Value<bool> isSelfRegistered,
  Value<bool> isRedeCotazap,
  Value<int> priorityScore,
  Value<bool> approved,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductSuppliersTable, List<ProductSupplier>>
      _productSuppliersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.productSuppliers,
              aliasName: $_aliasNameGenerator(
                  db.suppliers.id, db.productSuppliers.supplierId));

  $$ProductSuppliersTableProcessedTableManager get productSuppliersRefs {
    final manager =
        $$ProductSuppliersTableTableManager($_db, $_db.productSuppliers)
            .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productSuppliersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
      _quotationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.quotations,
              aliasName: $_aliasNameGenerator(
                  db.suppliers.id, db.quotations.winnerSupplierId));

  $$QuotationsTableProcessedTableManager get quotationsRefs {
    final manager = $$QuotationsTableTableManager($_db, $_db.quotations).filter(
        (f) => f.winnerSupplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierResponsesTable, List<SupplierResponse>>
      _supplierResponsesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.supplierResponses,
              aliasName: $_aliasNameGenerator(
                  db.suppliers.id, db.supplierResponses.supplierId));

  $$SupplierResponsesTableProcessedTableManager get supplierResponsesRefs {
    final manager =
        $$SupplierResponsesTableTableManager($_db, $_db.supplierResponses)
            .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_supplierResponsesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tradeName => $composableBuilder(
      column: $table.tradeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observations => $composableBuilder(
      column: $table.observations, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelfRegistered => $composableBuilder(
      column: $table.isSelfRegistered,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get approved => $composableBuilder(
      column: $table.approved, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> productSuppliersRefs(
      Expression<bool> Function($$ProductSuppliersTableFilterComposer f) f) {
    final $$ProductSuppliersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productSuppliers,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductSuppliersTableFilterComposer(
              $db: $db,
              $table: $db.productSuppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> quotationsRefs(
      Expression<bool> Function($$QuotationsTableFilterComposer f) f) {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.winnerSupplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableFilterComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> supplierResponsesRefs(
      Expression<bool> Function($$SupplierResponsesTableFilterComposer f) f) {
    final $$SupplierResponsesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.supplierResponses,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierResponsesTableFilterComposer(
              $db: $db,
              $table: $db.supplierResponses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tradeName => $composableBuilder(
      column: $table.tradeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observations => $composableBuilder(
      column: $table.observations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelfRegistered => $composableBuilder(
      column: $table.isSelfRegistered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get approved => $composableBuilder(
      column: $table.approved, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tradeName =>
      $composableBuilder(column: $table.tradeName, builder: (column) => column);

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get observations => $composableBuilder(
      column: $table.observations, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<bool> get isSelfRegistered => $composableBuilder(
      column: $table.isSelfRegistered, builder: (column) => column);

  GeneratedColumn<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap, builder: (column) => column);

  GeneratedColumn<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore, builder: (column) => column);

  GeneratedColumn<bool> get approved =>
      $composableBuilder(column: $table.approved, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> productSuppliersRefs<T extends Object>(
      Expression<T> Function($$ProductSuppliersTableAnnotationComposer a) f) {
    final $$ProductSuppliersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productSuppliers,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductSuppliersTableAnnotationComposer(
              $db: $db,
              $table: $db.productSuppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> quotationsRefs<T extends Object>(
      Expression<T> Function($$QuotationsTableAnnotationComposer a) f) {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.winnerSupplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> supplierResponsesRefs<T extends Object>(
      Expression<T> Function($$SupplierResponsesTableAnnotationComposer a) f) {
    final $$SupplierResponsesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.supplierResponses,
            getReferencedColumn: (t) => t.supplierId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SupplierResponsesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.supplierResponses,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SuppliersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuppliersTable,
    Supplier,
    $$SuppliersTableFilterComposer,
    $$SuppliersTableOrderingComposer,
    $$SuppliersTableAnnotationComposer,
    $$SuppliersTableCreateCompanionBuilder,
    $$SuppliersTableUpdateCompanionBuilder,
    (Supplier, $$SuppliersTableReferences),
    Supplier,
    PrefetchHooks Function(
        {bool productSuppliersRefs,
        bool quotationsRefs,
        bool supplierResponsesRefs})> {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tradeName = const Value.absent(),
            Value<String> whatsapp = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> observations = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<bool> isSelfRegistered = const Value.absent(),
            Value<bool> isRedeCotazap = const Value.absent(),
            Value<int> priorityScore = const Value.absent(),
            Value<bool> approved = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              SuppliersCompanion(
            id: id,
            tradeName: tradeName,
            whatsapp: whatsapp,
            address: address,
            observations: observations,
            active: active,
            isSelfRegistered: isSelfRegistered,
            isRedeCotazap: isRedeCotazap,
            priorityScore: priorityScore,
            approved: approved,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tradeName,
            required String whatsapp,
            Value<String?> address = const Value.absent(),
            Value<String?> observations = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<bool> isSelfRegistered = const Value.absent(),
            Value<bool> isRedeCotazap = const Value.absent(),
            Value<int> priorityScore = const Value.absent(),
            Value<bool> approved = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              SuppliersCompanion.insert(
            id: id,
            tradeName: tradeName,
            whatsapp: whatsapp,
            address: address,
            observations: observations,
            active: active,
            isSelfRegistered: isSelfRegistered,
            isRedeCotazap: isRedeCotazap,
            priorityScore: priorityScore,
            approved: approved,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SuppliersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productSuppliersRefs = false,
              quotationsRefs = false,
              supplierResponsesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productSuppliersRefs) db.productSuppliers,
                if (quotationsRefs) db.quotations,
                if (supplierResponsesRefs) db.supplierResponses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productSuppliersRefs)
                    await $_getPrefetchedData<Supplier, $SuppliersTable,
                            ProductSupplier>(
                        currentTable: table,
                        referencedTable: $$SuppliersTableReferences
                            ._productSuppliersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SuppliersTableReferences(db, table, p0)
                                .productSuppliersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.supplierId == item.id),
                        typedResults: items),
                  if (quotationsRefs)
                    await $_getPrefetchedData<Supplier, $SuppliersTable,
                            Quotation>(
                        currentTable: table,
                        referencedTable:
                            $$SuppliersTableReferences._quotationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SuppliersTableReferences(db, table, p0)
                                .quotationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.winnerSupplierId == item.id),
                        typedResults: items),
                  if (supplierResponsesRefs)
                    await $_getPrefetchedData<Supplier, $SuppliersTable,
                            SupplierResponse>(
                        currentTable: table,
                        referencedTable: $$SuppliersTableReferences
                            ._supplierResponsesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SuppliersTableReferences(db, table, p0)
                                .supplierResponsesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.supplierId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SuppliersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SuppliersTable,
    Supplier,
    $$SuppliersTableFilterComposer,
    $$SuppliersTableOrderingComposer,
    $$SuppliersTableAnnotationComposer,
    $$SuppliersTableCreateCompanionBuilder,
    $$SuppliersTableUpdateCompanionBuilder,
    (Supplier, $$SuppliersTableReferences),
    Supplier,
    PrefetchHooks Function(
        {bool productSuppliersRefs,
        bool quotationsRefs,
        bool supplierResponsesRefs})>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String?> sku,
  required String description,
  required String unitMeasure,
  required String packagingType,
  required String attributesJson,
  Value<bool> isFromRede,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String?> sku,
  Value<String> description,
  Value<String> unitMeasure,
  Value<String> packagingType,
  Value<String> attributesJson,
  Value<bool> isFromRede,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductSuppliersTable, List<ProductSupplier>>
      _productSuppliersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.productSuppliers,
              aliasName: $_aliasNameGenerator(
                  db.products.id, db.productSuppliers.productId));

  $$ProductSuppliersTableProcessedTableManager get productSuppliersRefs {
    final manager =
        $$ProductSuppliersTableTableManager($_db, $_db.productSuppliers)
            .filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productSuppliersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuotationItemsTable, List<QuotationItem>>
      _quotationItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.quotationItems,
              aliasName: $_aliasNameGenerator(
                  db.products.id, db.quotationItems.productId));

  $$QuotationItemsTableProcessedTableManager get quotationItemsRefs {
    final manager = $$QuotationItemsTableTableManager($_db, $_db.quotationItems)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitMeasure => $composableBuilder(
      column: $table.unitMeasure, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get packagingType => $composableBuilder(
      column: $table.packagingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> productSuppliersRefs(
      Expression<bool> Function($$ProductSuppliersTableFilterComposer f) f) {
    final $$ProductSuppliersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productSuppliers,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductSuppliersTableFilterComposer(
              $db: $db,
              $table: $db.productSuppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> quotationItemsRefs(
      Expression<bool> Function($$QuotationItemsTableFilterComposer f) f) {
    final $$QuotationItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableFilterComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitMeasure => $composableBuilder(
      column: $table.unitMeasure, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get packagingType => $composableBuilder(
      column: $table.packagingType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get unitMeasure => $composableBuilder(
      column: $table.unitMeasure, builder: (column) => column);

  GeneratedColumn<String> get packagingType => $composableBuilder(
      column: $table.packagingType, builder: (column) => column);

  GeneratedColumn<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson, builder: (column) => column);

  GeneratedColumn<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> productSuppliersRefs<T extends Object>(
      Expression<T> Function($$ProductSuppliersTableAnnotationComposer a) f) {
    final $$ProductSuppliersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productSuppliers,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductSuppliersTableAnnotationComposer(
              $db: $db,
              $table: $db.productSuppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> quotationItemsRefs<T extends Object>(
      Expression<T> Function($$QuotationItemsTableAnnotationComposer a) f) {
    final $$QuotationItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function(
        {bool productSuppliersRefs, bool quotationItemsRefs})> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> unitMeasure = const Value.absent(),
            Value<String> packagingType = const Value.absent(),
            Value<String> attributesJson = const Value.absent(),
            Value<bool> isFromRede = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            sku: sku,
            description: description,
            unitMeasure: unitMeasure,
            packagingType: packagingType,
            attributesJson: attributesJson,
            isFromRede: isFromRede,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            required String description,
            required String unitMeasure,
            required String packagingType,
            required String attributesJson,
            Value<bool> isFromRede = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            sku: sku,
            description: description,
            unitMeasure: unitMeasure,
            packagingType: packagingType,
            attributesJson: attributesJson,
            isFromRede: isFromRede,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {productSuppliersRefs = false, quotationItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productSuppliersRefs) db.productSuppliers,
                if (quotationItemsRefs) db.quotationItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productSuppliersRefs)
                    await $_getPrefetchedData<Product, $ProductsTable,
                            ProductSupplier>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences
                            ._productSuppliersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductsTableReferences(db, table, p0)
                                .productSuppliersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items),
                  if (quotationItemsRefs)
                    await $_getPrefetchedData<Product, $ProductsTable,
                            QuotationItem>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences
                            ._quotationItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductsTableReferences(db, table, p0)
                                .quotationItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function(
        {bool productSuppliersRefs, bool quotationItemsRefs})>;
typedef $$ProductSuppliersTableCreateCompanionBuilder
    = ProductSuppliersCompanion Function({
  Value<int> id,
  required int productId,
  required int supplierId,
});
typedef $$ProductSuppliersTableUpdateCompanionBuilder
    = ProductSuppliersCompanion Function({
  Value<int> id,
  Value<int> productId,
  Value<int> supplierId,
});

final class $$ProductSuppliersTableReferences extends BaseReferences<
    _$AppDatabase, $ProductSuppliersTable, ProductSupplier> {
  $$ProductSuppliersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
          $_aliasNameGenerator(db.productSuppliers.productId, db.products.id));

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias($_aliasNameGenerator(
          db.productSuppliers.supplierId, db.suppliers.id));

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductSuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $ProductSuppliersTable> {
  $$ProductSuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableFilterComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductSuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductSuppliersTable> {
  $$ProductSuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableOrderingComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductSuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductSuppliersTable> {
  $$ProductSuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableAnnotationComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductSuppliersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductSuppliersTable,
    ProductSupplier,
    $$ProductSuppliersTableFilterComposer,
    $$ProductSuppliersTableOrderingComposer,
    $$ProductSuppliersTableAnnotationComposer,
    $$ProductSuppliersTableCreateCompanionBuilder,
    $$ProductSuppliersTableUpdateCompanionBuilder,
    (ProductSupplier, $$ProductSuppliersTableReferences),
    ProductSupplier,
    PrefetchHooks Function({bool productId, bool supplierId})> {
  $$ProductSuppliersTableTableManager(
      _$AppDatabase db, $ProductSuppliersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductSuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductSuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductSuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<int> supplierId = const Value.absent(),
          }) =>
              ProductSuppliersCompanion(
            id: id,
            productId: productId,
            supplierId: supplierId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required int supplierId,
          }) =>
              ProductSuppliersCompanion.insert(
            id: id,
            productId: productId,
            supplierId: supplierId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductSuppliersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productId = false, supplierId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable:
                        $$ProductSuppliersTableReferences._productIdTable(db),
                    referencedColumn: $$ProductSuppliersTableReferences
                        ._productIdTable(db)
                        .id,
                  ) as T;
                }
                if (supplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.supplierId,
                    referencedTable:
                        $$ProductSuppliersTableReferences._supplierIdTable(db),
                    referencedColumn: $$ProductSuppliersTableReferences
                        ._supplierIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductSuppliersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductSuppliersTable,
    ProductSupplier,
    $$ProductSuppliersTableFilterComposer,
    $$ProductSuppliersTableOrderingComposer,
    $$ProductSuppliersTableAnnotationComposer,
    $$ProductSuppliersTableCreateCompanionBuilder,
    $$ProductSuppliersTableUpdateCompanionBuilder,
    (ProductSupplier, $$ProductSuppliersTableReferences),
    ProductSupplier,
    PrefetchHooks Function({bool productId, bool supplierId})>;
typedef $$QuotationsTableCreateCompanionBuilder = QuotationsCompanion Function({
  Value<int> id,
  required int buyerId,
  required DateTime date,
  required String status,
  required String templateMessage,
  Value<double> totalEconomy,
  Value<int?> winnerSupplierId,
});
typedef $$QuotationsTableUpdateCompanionBuilder = QuotationsCompanion Function({
  Value<int> id,
  Value<int> buyerId,
  Value<DateTime> date,
  Value<String> status,
  Value<String> templateMessage,
  Value<double> totalEconomy,
  Value<int?> winnerSupplierId,
});

final class $$QuotationsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationsTable, Quotation> {
  $$QuotationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BuyersTable _buyerIdTable(_$AppDatabase db) => db.buyers
      .createAlias($_aliasNameGenerator(db.quotations.buyerId, db.buyers.id));

  $$BuyersTableProcessedTableManager get buyerId {
    final $_column = $_itemColumn<int>('buyer_id')!;

    final manager = $$BuyersTableTableManager($_db, $_db.buyers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buyerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SuppliersTable _winnerSupplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias($_aliasNameGenerator(
          db.quotations.winnerSupplierId, db.suppliers.id));

  $$SuppliersTableProcessedTableManager? get winnerSupplierId {
    final $_column = $_itemColumn<int>('winner_supplier_id');
    if ($_column == null) return null;
    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_winnerSupplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$QuotationItemsTable, List<QuotationItem>>
      _quotationItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.quotationItems,
              aliasName: $_aliasNameGenerator(
                  db.quotations.id, db.quotationItems.quotationId));

  $$QuotationItemsTableProcessedTableManager get quotationItemsRefs {
    final manager = $$QuotationItemsTableTableManager($_db, $_db.quotationItems)
        .filter((f) => f.quotationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuotationsTableFilterComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get templateMessage => $composableBuilder(
      column: $table.templateMessage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalEconomy => $composableBuilder(
      column: $table.totalEconomy, builder: (column) => ColumnFilters(column));

  $$BuyersTableFilterComposer get buyerId {
    final $$BuyersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.buyers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuyersTableFilterComposer(
              $db: $db,
              $table: $db.buyers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableFilterComposer get winnerSupplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableFilterComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> quotationItemsRefs(
      Expression<bool> Function($$QuotationItemsTableFilterComposer f) f) {
    final $$QuotationItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.quotationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableFilterComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get templateMessage => $composableBuilder(
      column: $table.templateMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalEconomy => $composableBuilder(
      column: $table.totalEconomy,
      builder: (column) => ColumnOrderings(column));

  $$BuyersTableOrderingComposer get buyerId {
    final $$BuyersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.buyers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuyersTableOrderingComposer(
              $db: $db,
              $table: $db.buyers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableOrderingComposer get winnerSupplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableOrderingComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get templateMessage => $composableBuilder(
      column: $table.templateMessage, builder: (column) => column);

  GeneratedColumn<double> get totalEconomy => $composableBuilder(
      column: $table.totalEconomy, builder: (column) => column);

  $$BuyersTableAnnotationComposer get buyerId {
    final $$BuyersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.buyers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuyersTableAnnotationComposer(
              $db: $db,
              $table: $db.buyers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SuppliersTableAnnotationComposer get winnerSupplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableAnnotationComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> quotationItemsRefs<T extends Object>(
      Expression<T> Function($$QuotationItemsTableAnnotationComposer a) f) {
    final $$QuotationItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.quotationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuotationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuotationsTable,
    Quotation,
    $$QuotationsTableFilterComposer,
    $$QuotationsTableOrderingComposer,
    $$QuotationsTableAnnotationComposer,
    $$QuotationsTableCreateCompanionBuilder,
    $$QuotationsTableUpdateCompanionBuilder,
    (Quotation, $$QuotationsTableReferences),
    Quotation,
    PrefetchHooks Function(
        {bool buyerId, bool winnerSupplierId, bool quotationItemsRefs})> {
  $$QuotationsTableTableManager(_$AppDatabase db, $QuotationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> buyerId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> templateMessage = const Value.absent(),
            Value<double> totalEconomy = const Value.absent(),
            Value<int?> winnerSupplierId = const Value.absent(),
          }) =>
              QuotationsCompanion(
            id: id,
            buyerId: buyerId,
            date: date,
            status: status,
            templateMessage: templateMessage,
            totalEconomy: totalEconomy,
            winnerSupplierId: winnerSupplierId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int buyerId,
            required DateTime date,
            required String status,
            required String templateMessage,
            Value<double> totalEconomy = const Value.absent(),
            Value<int?> winnerSupplierId = const Value.absent(),
          }) =>
              QuotationsCompanion.insert(
            id: id,
            buyerId: buyerId,
            date: date,
            status: status,
            templateMessage: templateMessage,
            totalEconomy: totalEconomy,
            winnerSupplierId: winnerSupplierId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$QuotationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {buyerId = false,
              winnerSupplierId = false,
              quotationItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (quotationItemsRefs) db.quotationItems
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (buyerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.buyerId,
                    referencedTable:
                        $$QuotationsTableReferences._buyerIdTable(db),
                    referencedColumn:
                        $$QuotationsTableReferences._buyerIdTable(db).id,
                  ) as T;
                }
                if (winnerSupplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.winnerSupplierId,
                    referencedTable:
                        $$QuotationsTableReferences._winnerSupplierIdTable(db),
                    referencedColumn: $$QuotationsTableReferences
                        ._winnerSupplierIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotationItemsRefs)
                    await $_getPrefetchedData<Quotation, $QuotationsTable,
                            QuotationItem>(
                        currentTable: table,
                        referencedTable: $$QuotationsTableReferences
                            ._quotationItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuotationsTableReferences(db, table, p0)
                                .quotationItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.quotationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuotationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuotationsTable,
    Quotation,
    $$QuotationsTableFilterComposer,
    $$QuotationsTableOrderingComposer,
    $$QuotationsTableAnnotationComposer,
    $$QuotationsTableCreateCompanionBuilder,
    $$QuotationsTableUpdateCompanionBuilder,
    (Quotation, $$QuotationsTableReferences),
    Quotation,
    PrefetchHooks Function(
        {bool buyerId, bool winnerSupplierId, bool quotationItemsRefs})>;
typedef $$SupplierResponsesTableCreateCompanionBuilder
    = SupplierResponsesCompanion Function({
  Value<int> id,
  required int quotationItemId,
  required int supplierId,
  Value<String?> receivedMessage,
  Value<double?> pricingExtracted,
  Value<int?> deliveryTimeDays,
  required DateTime responseDate,
  required String status,
  Value<bool> isSelected,
  Value<int?> paymentTermDays,
  Value<String?> paymentCondition,
  Value<double?> earlyDiscountPercent,
  Value<int> calculatedScore,
});
typedef $$SupplierResponsesTableUpdateCompanionBuilder
    = SupplierResponsesCompanion Function({
  Value<int> id,
  Value<int> quotationItemId,
  Value<int> supplierId,
  Value<String?> receivedMessage,
  Value<double?> pricingExtracted,
  Value<int?> deliveryTimeDays,
  Value<DateTime> responseDate,
  Value<String> status,
  Value<bool> isSelected,
  Value<int?> paymentTermDays,
  Value<String?> paymentCondition,
  Value<double?> earlyDiscountPercent,
  Value<int> calculatedScore,
});

final class $$SupplierResponsesTableReferences extends BaseReferences<
    _$AppDatabase, $SupplierResponsesTable, SupplierResponse> {
  $$SupplierResponsesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias($_aliasNameGenerator(
          db.supplierResponses.supplierId, db.suppliers.id));

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$QuotationItemsTable, List<QuotationItem>>
      _quotationItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.quotationItems,
              aliasName: $_aliasNameGenerator(
                  db.supplierResponses.id, db.quotationItems.bestResponseId));

  $$QuotationItemsTableProcessedTableManager get quotationItemsRefs {
    final manager = $$QuotationItemsTableTableManager($_db, $_db.quotationItems)
        .filter((f) => f.bestResponseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SupplierResponsesTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierResponsesTable> {
  $$SupplierResponsesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quotationItemId => $composableBuilder(
      column: $table.quotationItemId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receivedMessage => $composableBuilder(
      column: $table.receivedMessage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get pricingExtracted => $composableBuilder(
      column: $table.pricingExtracted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deliveryTimeDays => $composableBuilder(
      column: $table.deliveryTimeDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get responseDate => $composableBuilder(
      column: $table.responseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get earlyDiscountPercent => $composableBuilder(
      column: $table.earlyDiscountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calculatedScore => $composableBuilder(
      column: $table.calculatedScore,
      builder: (column) => ColumnFilters(column));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableFilterComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> quotationItemsRefs(
      Expression<bool> Function($$QuotationItemsTableFilterComposer f) f) {
    final $$QuotationItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.bestResponseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableFilterComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SupplierResponsesTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierResponsesTable> {
  $$SupplierResponsesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quotationItemId => $composableBuilder(
      column: $table.quotationItemId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receivedMessage => $composableBuilder(
      column: $table.receivedMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get pricingExtracted => $composableBuilder(
      column: $table.pricingExtracted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deliveryTimeDays => $composableBuilder(
      column: $table.deliveryTimeDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get responseDate => $composableBuilder(
      column: $table.responseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get earlyDiscountPercent => $composableBuilder(
      column: $table.earlyDiscountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calculatedScore => $composableBuilder(
      column: $table.calculatedScore,
      builder: (column) => ColumnOrderings(column));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableOrderingComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierResponsesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierResponsesTable> {
  $$SupplierResponsesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quotationItemId => $composableBuilder(
      column: $table.quotationItemId, builder: (column) => column);

  GeneratedColumn<String> get receivedMessage => $composableBuilder(
      column: $table.receivedMessage, builder: (column) => column);

  GeneratedColumn<double> get pricingExtracted => $composableBuilder(
      column: $table.pricingExtracted, builder: (column) => column);

  GeneratedColumn<int> get deliveryTimeDays => $composableBuilder(
      column: $table.deliveryTimeDays, builder: (column) => column);

  GeneratedColumn<DateTime> get responseDate => $composableBuilder(
      column: $table.responseDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => column);

  GeneratedColumn<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays, builder: (column) => column);

  GeneratedColumn<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition, builder: (column) => column);

  GeneratedColumn<double> get earlyDiscountPercent => $composableBuilder(
      column: $table.earlyDiscountPercent, builder: (column) => column);

  GeneratedColumn<int> get calculatedScore => $composableBuilder(
      column: $table.calculatedScore, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuppliersTableAnnotationComposer(
              $db: $db,
              $table: $db.suppliers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> quotationItemsRefs<T extends Object>(
      Expression<T> Function($$QuotationItemsTableAnnotationComposer a) f) {
    final $$QuotationItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotationItems,
        getReferencedColumn: (t) => t.bestResponseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotationItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SupplierResponsesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierResponsesTable,
    SupplierResponse,
    $$SupplierResponsesTableFilterComposer,
    $$SupplierResponsesTableOrderingComposer,
    $$SupplierResponsesTableAnnotationComposer,
    $$SupplierResponsesTableCreateCompanionBuilder,
    $$SupplierResponsesTableUpdateCompanionBuilder,
    (SupplierResponse, $$SupplierResponsesTableReferences),
    SupplierResponse,
    PrefetchHooks Function({bool supplierId, bool quotationItemsRefs})> {
  $$SupplierResponsesTableTableManager(
      _$AppDatabase db, $SupplierResponsesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierResponsesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierResponsesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierResponsesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> quotationItemId = const Value.absent(),
            Value<int> supplierId = const Value.absent(),
            Value<String?> receivedMessage = const Value.absent(),
            Value<double?> pricingExtracted = const Value.absent(),
            Value<int?> deliveryTimeDays = const Value.absent(),
            Value<DateTime> responseDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isSelected = const Value.absent(),
            Value<int?> paymentTermDays = const Value.absent(),
            Value<String?> paymentCondition = const Value.absent(),
            Value<double?> earlyDiscountPercent = const Value.absent(),
            Value<int> calculatedScore = const Value.absent(),
          }) =>
              SupplierResponsesCompanion(
            id: id,
            quotationItemId: quotationItemId,
            supplierId: supplierId,
            receivedMessage: receivedMessage,
            pricingExtracted: pricingExtracted,
            deliveryTimeDays: deliveryTimeDays,
            responseDate: responseDate,
            status: status,
            isSelected: isSelected,
            paymentTermDays: paymentTermDays,
            paymentCondition: paymentCondition,
            earlyDiscountPercent: earlyDiscountPercent,
            calculatedScore: calculatedScore,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int quotationItemId,
            required int supplierId,
            Value<String?> receivedMessage = const Value.absent(),
            Value<double?> pricingExtracted = const Value.absent(),
            Value<int?> deliveryTimeDays = const Value.absent(),
            required DateTime responseDate,
            required String status,
            Value<bool> isSelected = const Value.absent(),
            Value<int?> paymentTermDays = const Value.absent(),
            Value<String?> paymentCondition = const Value.absent(),
            Value<double?> earlyDiscountPercent = const Value.absent(),
            Value<int> calculatedScore = const Value.absent(),
          }) =>
              SupplierResponsesCompanion.insert(
            id: id,
            quotationItemId: quotationItemId,
            supplierId: supplierId,
            receivedMessage: receivedMessage,
            pricingExtracted: pricingExtracted,
            deliveryTimeDays: deliveryTimeDays,
            responseDate: responseDate,
            status: status,
            isSelected: isSelected,
            paymentTermDays: paymentTermDays,
            paymentCondition: paymentCondition,
            earlyDiscountPercent: earlyDiscountPercent,
            calculatedScore: calculatedScore,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SupplierResponsesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {supplierId = false, quotationItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (quotationItemsRefs) db.quotationItems
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (supplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.supplierId,
                    referencedTable:
                        $$SupplierResponsesTableReferences._supplierIdTable(db),
                    referencedColumn: $$SupplierResponsesTableReferences
                        ._supplierIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotationItemsRefs)
                    await $_getPrefetchedData<SupplierResponse,
                            $SupplierResponsesTable, QuotationItem>(
                        currentTable: table,
                        referencedTable: $$SupplierResponsesTableReferences
                            ._quotationItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SupplierResponsesTableReferences(db, table, p0)
                                .quotationItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bestResponseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SupplierResponsesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SupplierResponsesTable,
    SupplierResponse,
    $$SupplierResponsesTableFilterComposer,
    $$SupplierResponsesTableOrderingComposer,
    $$SupplierResponsesTableAnnotationComposer,
    $$SupplierResponsesTableCreateCompanionBuilder,
    $$SupplierResponsesTableUpdateCompanionBuilder,
    (SupplierResponse, $$SupplierResponsesTableReferences),
    SupplierResponse,
    PrefetchHooks Function({bool supplierId, bool quotationItemsRefs})>;
typedef $$QuotationItemsTableCreateCompanionBuilder = QuotationItemsCompanion
    Function({
  Value<int> id,
  required int quotationId,
  required int productId,
  required double quantity,
  Value<double?> requestedPrice,
  Value<String?> deliveryType,
  Value<int?> desiredLeadTime,
  Value<int?> paymentTermDays,
  Value<String?> paymentCondition,
  Value<int?> bestResponseId,
});
typedef $$QuotationItemsTableUpdateCompanionBuilder = QuotationItemsCompanion
    Function({
  Value<int> id,
  Value<int> quotationId,
  Value<int> productId,
  Value<double> quantity,
  Value<double?> requestedPrice,
  Value<String?> deliveryType,
  Value<int?> desiredLeadTime,
  Value<int?> paymentTermDays,
  Value<String?> paymentCondition,
  Value<int?> bestResponseId,
});

final class $$QuotationItemsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationItemsTable, QuotationItem> {
  $$QuotationItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuotationsTable _quotationIdTable(_$AppDatabase db) =>
      db.quotations.createAlias($_aliasNameGenerator(
          db.quotationItems.quotationId, db.quotations.id));

  $$QuotationsTableProcessedTableManager get quotationId {
    final $_column = $_itemColumn<int>('quotation_id')!;

    final manager = $$QuotationsTableTableManager($_db, $_db.quotations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quotationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
          $_aliasNameGenerator(db.quotationItems.productId, db.products.id));

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SupplierResponsesTable _bestResponseIdTable(_$AppDatabase db) =>
      db.supplierResponses.createAlias($_aliasNameGenerator(
          db.quotationItems.bestResponseId, db.supplierResponses.id));

  $$SupplierResponsesTableProcessedTableManager? get bestResponseId {
    final $_column = $_itemColumn<int>('best_response_id');
    if ($_column == null) return null;
    final manager =
        $$SupplierResponsesTableTableManager($_db, $_db.supplierResponses)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bestResponseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuotationItemsTableFilterComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get requestedPrice => $composableBuilder(
      column: $table.requestedPrice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryType => $composableBuilder(
      column: $table.deliveryType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get desiredLeadTime => $composableBuilder(
      column: $table.desiredLeadTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition,
      builder: (column) => ColumnFilters(column));

  $$QuotationsTableFilterComposer get quotationId {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quotationId,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableFilterComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SupplierResponsesTableFilterComposer get bestResponseId {
    final $$SupplierResponsesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bestResponseId,
        referencedTable: $db.supplierResponses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierResponsesTableFilterComposer(
              $db: $db,
              $table: $db.supplierResponses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get requestedPrice => $composableBuilder(
      column: $table.requestedPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryType => $composableBuilder(
      column: $table.deliveryType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get desiredLeadTime => $composableBuilder(
      column: $table.desiredLeadTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition,
      builder: (column) => ColumnOrderings(column));

  $$QuotationsTableOrderingComposer get quotationId {
    final $$QuotationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quotationId,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableOrderingComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SupplierResponsesTableOrderingComposer get bestResponseId {
    final $$SupplierResponsesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bestResponseId,
        referencedTable: $db.supplierResponses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierResponsesTableOrderingComposer(
              $db: $db,
              $table: $db.supplierResponses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get requestedPrice => $composableBuilder(
      column: $table.requestedPrice, builder: (column) => column);

  GeneratedColumn<String> get deliveryType => $composableBuilder(
      column: $table.deliveryType, builder: (column) => column);

  GeneratedColumn<int> get desiredLeadTime => $composableBuilder(
      column: $table.desiredLeadTime, builder: (column) => column);

  GeneratedColumn<int> get paymentTermDays => $composableBuilder(
      column: $table.paymentTermDays, builder: (column) => column);

  GeneratedColumn<String> get paymentCondition => $composableBuilder(
      column: $table.paymentCondition, builder: (column) => column);

  $$QuotationsTableAnnotationComposer get quotationId {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quotationId,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SupplierResponsesTableAnnotationComposer get bestResponseId {
    final $$SupplierResponsesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.bestResponseId,
            referencedTable: $db.supplierResponses,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SupplierResponsesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.supplierResponses,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$QuotationItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuotationItemsTable,
    QuotationItem,
    $$QuotationItemsTableFilterComposer,
    $$QuotationItemsTableOrderingComposer,
    $$QuotationItemsTableAnnotationComposer,
    $$QuotationItemsTableCreateCompanionBuilder,
    $$QuotationItemsTableUpdateCompanionBuilder,
    (QuotationItem, $$QuotationItemsTableReferences),
    QuotationItem,
    PrefetchHooks Function(
        {bool quotationId, bool productId, bool bestResponseId})> {
  $$QuotationItemsTableTableManager(
      _$AppDatabase db, $QuotationItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotationItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotationItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotationItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> quotationId = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double?> requestedPrice = const Value.absent(),
            Value<String?> deliveryType = const Value.absent(),
            Value<int?> desiredLeadTime = const Value.absent(),
            Value<int?> paymentTermDays = const Value.absent(),
            Value<String?> paymentCondition = const Value.absent(),
            Value<int?> bestResponseId = const Value.absent(),
          }) =>
              QuotationItemsCompanion(
            id: id,
            quotationId: quotationId,
            productId: productId,
            quantity: quantity,
            requestedPrice: requestedPrice,
            deliveryType: deliveryType,
            desiredLeadTime: desiredLeadTime,
            paymentTermDays: paymentTermDays,
            paymentCondition: paymentCondition,
            bestResponseId: bestResponseId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int quotationId,
            required int productId,
            required double quantity,
            Value<double?> requestedPrice = const Value.absent(),
            Value<String?> deliveryType = const Value.absent(),
            Value<int?> desiredLeadTime = const Value.absent(),
            Value<int?> paymentTermDays = const Value.absent(),
            Value<String?> paymentCondition = const Value.absent(),
            Value<int?> bestResponseId = const Value.absent(),
          }) =>
              QuotationItemsCompanion.insert(
            id: id,
            quotationId: quotationId,
            productId: productId,
            quantity: quantity,
            requestedPrice: requestedPrice,
            deliveryType: deliveryType,
            desiredLeadTime: desiredLeadTime,
            paymentTermDays: paymentTermDays,
            paymentCondition: paymentCondition,
            bestResponseId: bestResponseId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$QuotationItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {quotationId = false,
              productId = false,
              bestResponseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (quotationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.quotationId,
                    referencedTable:
                        $$QuotationItemsTableReferences._quotationIdTable(db),
                    referencedColumn: $$QuotationItemsTableReferences
                        ._quotationIdTable(db)
                        .id,
                  ) as T;
                }
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable:
                        $$QuotationItemsTableReferences._productIdTable(db),
                    referencedColumn:
                        $$QuotationItemsTableReferences._productIdTable(db).id,
                  ) as T;
                }
                if (bestResponseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bestResponseId,
                    referencedTable: $$QuotationItemsTableReferences
                        ._bestResponseIdTable(db),
                    referencedColumn: $$QuotationItemsTableReferences
                        ._bestResponseIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuotationItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuotationItemsTable,
    QuotationItem,
    $$QuotationItemsTableFilterComposer,
    $$QuotationItemsTableOrderingComposer,
    $$QuotationItemsTableAnnotationComposer,
    $$QuotationItemsTableCreateCompanionBuilder,
    $$QuotationItemsTableUpdateCompanionBuilder,
    (QuotationItem, $$QuotationItemsTableReferences),
    QuotationItem,
    PrefetchHooks Function(
        {bool quotationId, bool productId, bool bestResponseId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BuyersTableTableManager get buyers =>
      $$BuyersTableTableManager(_db, _db.buyers);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductSuppliersTableTableManager get productSuppliers =>
      $$ProductSuppliersTableTableManager(_db, _db.productSuppliers);
  $$QuotationsTableTableManager get quotations =>
      $$QuotationsTableTableManager(_db, _db.quotations);
  $$SupplierResponsesTableTableManager get supplierResponses =>
      $$SupplierResponsesTableTableManager(_db, _db.supplierResponses);
  $$QuotationItemsTableTableManager get quotationItems =>
      $$QuotationItemsTableTableManager(_db, _db.quotationItems);
}

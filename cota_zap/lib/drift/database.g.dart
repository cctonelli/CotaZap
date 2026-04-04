// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AppProfilesTable extends AppProfiles
    with TableInfo<$AppProfilesTable, AppProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planTypeMeta =
      const VerificationMeta('planType');
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
      'plan_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('free'));
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, role, planType, avatarUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<AppProfile> instance,
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
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('plan_type')) {
      context.handle(_planTypeMeta,
          planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      planType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_type'])!,
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
    );
  }

  @override
  $AppProfilesTable createAlias(String alias) {
    return $AppProfilesTable(attachedDatabase, alias);
  }
}

class AppProfile extends DataClass implements Insertable<AppProfile> {
  final String id;
  final String name;
  final String role;
  final String planType;
  final String? avatarUrl;
  const AppProfile(
      {required this.id,
      required this.name,
      required this.role,
      required this.planType,
      this.avatarUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    map['plan_type'] = Variable<String>(planType);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    return map;
  }

  AppProfilesCompanion toCompanion(bool nullToAbsent) {
    return AppProfilesCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      planType: Value(planType),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
    );
  }

  factory AppProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      planType: serializer.fromJson<String>(json['planType']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'planType': serializer.toJson<String>(planType),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
    };
  }

  AppProfile copyWith(
          {String? id,
          String? name,
          String? role,
          String? planType,
          Value<String?> avatarUrl = const Value.absent()}) =>
      AppProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        planType: planType ?? this.planType,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
      );
  AppProfile copyWithCompanion(AppProfilesCompanion data) {
    return AppProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      planType: data.planType.present ? data.planType.value : this.planType,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('planType: $planType, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, role, planType, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.planType == this.planType &&
          other.avatarUrl == this.avatarUrl);
}

class AppProfilesCompanion extends UpdateCompanion<AppProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String> planType;
  final Value<String?> avatarUrl;
  final Value<int> rowid;
  const AppProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.planType = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppProfilesCompanion.insert({
    required String id,
    required String name,
    required String role,
    this.planType = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        role = Value(role);
  static Insertable<AppProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? planType,
    Expression<String>? avatarUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (planType != null) 'plan_type': planType,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? role,
      Value<String>? planType,
      Value<String?>? avatarUrl,
      Value<int>? rowid}) {
    return AppProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      planType: planType ?? this.planType,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('planType: $planType, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppContactsTable extends AppContacts
    with TableInfo<$AppContactsTable, AppContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppContactsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _planTypeMeta =
      const VerificationMeta('planType');
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
      'plan_type', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('free'));
  static const VerificationMeta _productLimitMeta =
      const VerificationMeta('productLimit');
  @override
  late final GeneratedColumn<int> productLimit = GeneratedColumn<int>(
      'product_limit', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(15));
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
  static const VerificationMeta _cnpjCpfMeta =
      const VerificationMeta('cnpjCpf');
  @override
  late final GeneratedColumn<String> cnpjCpf = GeneratedColumn<String>(
      'cnpj_cpf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contactNameMeta =
      const VerificationMeta('contactName');
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
      'contact_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _neighborhoodMeta =
      const VerificationMeta('neighborhood');
  @override
  late final GeneratedColumn<String> neighborhood = GeneratedColumn<String>(
      'neighborhood', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _complementMeta =
      const VerificationMeta('complement');
  @override
  late final GeneratedColumn<String> complement = GeneratedColumn<String>(
      'complement', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isBuyerMeta =
      const VerificationMeta('isBuyer');
  @override
  late final GeneratedColumn<bool> isBuyer = GeneratedColumn<bool>(
      'is_buyer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_buyer" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSupplierMeta =
      const VerificationMeta('isSupplier');
  @override
  late final GeneratedColumn<bool> isSupplier = GeneratedColumn<bool>(
      'is_supplier', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_supplier" IN (0, 1))'),
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
        ownerId,
        planType,
        productLimit,
        isRedeCotazap,
        priorityScore,
        approved,
        cnpjCpf,
        contactName,
        email,
        city,
        state,
        neighborhood,
        zipCode,
        complement,
        isBuyer,
        isSupplier,
        isSynced,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<AppContact> instance,
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
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    }
    if (data.containsKey('plan_type')) {
      context.handle(_planTypeMeta,
          planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta));
    }
    if (data.containsKey('product_limit')) {
      context.handle(
          _productLimitMeta,
          productLimit.isAcceptableOrUnknown(
              data['product_limit']!, _productLimitMeta));
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
    if (data.containsKey('cnpj_cpf')) {
      context.handle(_cnpjCpfMeta,
          cnpjCpf.isAcceptableOrUnknown(data['cnpj_cpf']!, _cnpjCpfMeta));
    }
    if (data.containsKey('contact_name')) {
      context.handle(
          _contactNameMeta,
          contactName.isAcceptableOrUnknown(
              data['contact_name']!, _contactNameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('neighborhood')) {
      context.handle(
          _neighborhoodMeta,
          neighborhood.isAcceptableOrUnknown(
              data['neighborhood']!, _neighborhoodMeta));
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    }
    if (data.containsKey('complement')) {
      context.handle(
          _complementMeta,
          complement.isAcceptableOrUnknown(
              data['complement']!, _complementMeta));
    }
    if (data.containsKey('is_buyer')) {
      context.handle(_isBuyerMeta,
          isBuyer.isAcceptableOrUnknown(data['is_buyer']!, _isBuyerMeta));
    }
    if (data.containsKey('is_supplier')) {
      context.handle(
          _isSupplierMeta,
          isSupplier.isAcceptableOrUnknown(
              data['is_supplier']!, _isSupplierMeta));
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
  AppContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppContact(
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
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id']),
      planType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_type']),
      productLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_limit']),
      isRedeCotazap: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rede_cotazap'])!,
      priorityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority_score'])!,
      approved: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}approved'])!,
      cnpjCpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cnpj_cpf']),
      contactName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_name']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state']),
      neighborhood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neighborhood']),
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code']),
      complement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}complement']),
      isBuyer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_buyer'])!,
      isSupplier: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_supplier'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $AppContactsTable createAlias(String alias) {
    return $AppContactsTable(attachedDatabase, alias);
  }
}

class AppContact extends DataClass implements Insertable<AppContact> {
  final int id;
  final String tradeName;
  final String whatsapp;
  final String? address;
  final String? observations;
  final bool active;
  final String? ownerId;
  final String? planType;
  final int? productLimit;
  final bool isRedeCotazap;
  final int priorityScore;
  final bool approved;
  final String? cnpjCpf;
  final String? contactName;
  final String? email;
  final String? city;
  final String? state;
  final String? neighborhood;
  final String? zipCode;
  final String? complement;
  final bool isBuyer;
  final bool isSupplier;
  final bool isSynced;
  final DateTime lastUpdated;
  const AppContact(
      {required this.id,
      required this.tradeName,
      required this.whatsapp,
      this.address,
      this.observations,
      required this.active,
      this.ownerId,
      this.planType,
      this.productLimit,
      required this.isRedeCotazap,
      required this.priorityScore,
      required this.approved,
      this.cnpjCpf,
      this.contactName,
      this.email,
      this.city,
      this.state,
      this.neighborhood,
      this.zipCode,
      this.complement,
      required this.isBuyer,
      required this.isSupplier,
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
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || planType != null) {
      map['plan_type'] = Variable<String>(planType);
    }
    if (!nullToAbsent || productLimit != null) {
      map['product_limit'] = Variable<int>(productLimit);
    }
    map['is_rede_cotazap'] = Variable<bool>(isRedeCotazap);
    map['priority_score'] = Variable<int>(priorityScore);
    map['approved'] = Variable<bool>(approved);
    if (!nullToAbsent || cnpjCpf != null) {
      map['cnpj_cpf'] = Variable<String>(cnpjCpf);
    }
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || neighborhood != null) {
      map['neighborhood'] = Variable<String>(neighborhood);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    if (!nullToAbsent || complement != null) {
      map['complement'] = Variable<String>(complement);
    }
    map['is_buyer'] = Variable<bool>(isBuyer);
    map['is_supplier'] = Variable<bool>(isSupplier);
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  AppContactsCompanion toCompanion(bool nullToAbsent) {
    return AppContactsCompanion(
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
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      planType: planType == null && nullToAbsent
          ? const Value.absent()
          : Value(planType),
      productLimit: productLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(productLimit),
      isRedeCotazap: Value(isRedeCotazap),
      priorityScore: Value(priorityScore),
      approved: Value(approved),
      cnpjCpf: cnpjCpf == null && nullToAbsent
          ? const Value.absent()
          : Value(cnpjCpf),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      neighborhood: neighborhood == null && nullToAbsent
          ? const Value.absent()
          : Value(neighborhood),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
      complement: complement == null && nullToAbsent
          ? const Value.absent()
          : Value(complement),
      isBuyer: Value(isBuyer),
      isSupplier: Value(isSupplier),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory AppContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppContact(
      id: serializer.fromJson<int>(json['id']),
      tradeName: serializer.fromJson<String>(json['tradeName']),
      whatsapp: serializer.fromJson<String>(json['whatsapp']),
      address: serializer.fromJson<String?>(json['address']),
      observations: serializer.fromJson<String?>(json['observations']),
      active: serializer.fromJson<bool>(json['active']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      planType: serializer.fromJson<String?>(json['planType']),
      productLimit: serializer.fromJson<int?>(json['productLimit']),
      isRedeCotazap: serializer.fromJson<bool>(json['isRedeCotazap']),
      priorityScore: serializer.fromJson<int>(json['priorityScore']),
      approved: serializer.fromJson<bool>(json['approved']),
      cnpjCpf: serializer.fromJson<String?>(json['cnpjCpf']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      email: serializer.fromJson<String?>(json['email']),
      city: serializer.fromJson<String?>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      neighborhood: serializer.fromJson<String?>(json['neighborhood']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
      complement: serializer.fromJson<String?>(json['complement']),
      isBuyer: serializer.fromJson<bool>(json['isBuyer']),
      isSupplier: serializer.fromJson<bool>(json['isSupplier']),
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
      'ownerId': serializer.toJson<String?>(ownerId),
      'planType': serializer.toJson<String?>(planType),
      'productLimit': serializer.toJson<int?>(productLimit),
      'isRedeCotazap': serializer.toJson<bool>(isRedeCotazap),
      'priorityScore': serializer.toJson<int>(priorityScore),
      'approved': serializer.toJson<bool>(approved),
      'cnpjCpf': serializer.toJson<String?>(cnpjCpf),
      'contactName': serializer.toJson<String?>(contactName),
      'email': serializer.toJson<String?>(email),
      'city': serializer.toJson<String?>(city),
      'state': serializer.toJson<String?>(state),
      'neighborhood': serializer.toJson<String?>(neighborhood),
      'zipCode': serializer.toJson<String?>(zipCode),
      'complement': serializer.toJson<String?>(complement),
      'isBuyer': serializer.toJson<bool>(isBuyer),
      'isSupplier': serializer.toJson<bool>(isSupplier),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  AppContact copyWith(
          {int? id,
          String? tradeName,
          String? whatsapp,
          Value<String?> address = const Value.absent(),
          Value<String?> observations = const Value.absent(),
          bool? active,
          Value<String?> ownerId = const Value.absent(),
          Value<String?> planType = const Value.absent(),
          Value<int?> productLimit = const Value.absent(),
          bool? isRedeCotazap,
          int? priorityScore,
          bool? approved,
          Value<String?> cnpjCpf = const Value.absent(),
          Value<String?> contactName = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> state = const Value.absent(),
          Value<String?> neighborhood = const Value.absent(),
          Value<String?> zipCode = const Value.absent(),
          Value<String?> complement = const Value.absent(),
          bool? isBuyer,
          bool? isSupplier,
          bool? isSynced,
          DateTime? lastUpdated}) =>
      AppContact(
        id: id ?? this.id,
        tradeName: tradeName ?? this.tradeName,
        whatsapp: whatsapp ?? this.whatsapp,
        address: address.present ? address.value : this.address,
        observations:
            observations.present ? observations.value : this.observations,
        active: active ?? this.active,
        ownerId: ownerId.present ? ownerId.value : this.ownerId,
        planType: planType.present ? planType.value : this.planType,
        productLimit:
            productLimit.present ? productLimit.value : this.productLimit,
        isRedeCotazap: isRedeCotazap ?? this.isRedeCotazap,
        priorityScore: priorityScore ?? this.priorityScore,
        approved: approved ?? this.approved,
        cnpjCpf: cnpjCpf.present ? cnpjCpf.value : this.cnpjCpf,
        contactName: contactName.present ? contactName.value : this.contactName,
        email: email.present ? email.value : this.email,
        city: city.present ? city.value : this.city,
        state: state.present ? state.value : this.state,
        neighborhood:
            neighborhood.present ? neighborhood.value : this.neighborhood,
        zipCode: zipCode.present ? zipCode.value : this.zipCode,
        complement: complement.present ? complement.value : this.complement,
        isBuyer: isBuyer ?? this.isBuyer,
        isSupplier: isSupplier ?? this.isSupplier,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  AppContact copyWithCompanion(AppContactsCompanion data) {
    return AppContact(
      id: data.id.present ? data.id.value : this.id,
      tradeName: data.tradeName.present ? data.tradeName.value : this.tradeName,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      address: data.address.present ? data.address.value : this.address,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
      active: data.active.present ? data.active.value : this.active,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      planType: data.planType.present ? data.planType.value : this.planType,
      productLimit: data.productLimit.present
          ? data.productLimit.value
          : this.productLimit,
      isRedeCotazap: data.isRedeCotazap.present
          ? data.isRedeCotazap.value
          : this.isRedeCotazap,
      priorityScore: data.priorityScore.present
          ? data.priorityScore.value
          : this.priorityScore,
      approved: data.approved.present ? data.approved.value : this.approved,
      cnpjCpf: data.cnpjCpf.present ? data.cnpjCpf.value : this.cnpjCpf,
      contactName:
          data.contactName.present ? data.contactName.value : this.contactName,
      email: data.email.present ? data.email.value : this.email,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      neighborhood: data.neighborhood.present
          ? data.neighborhood.value
          : this.neighborhood,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
      complement:
          data.complement.present ? data.complement.value : this.complement,
      isBuyer: data.isBuyer.present ? data.isBuyer.value : this.isBuyer,
      isSupplier:
          data.isSupplier.present ? data.isSupplier.value : this.isSupplier,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppContact(')
          ..write('id: $id, ')
          ..write('tradeName: $tradeName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('observations: $observations, ')
          ..write('active: $active, ')
          ..write('ownerId: $ownerId, ')
          ..write('planType: $planType, ')
          ..write('productLimit: $productLimit, ')
          ..write('isRedeCotazap: $isRedeCotazap, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('approved: $approved, ')
          ..write('cnpjCpf: $cnpjCpf, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('zipCode: $zipCode, ')
          ..write('complement: $complement, ')
          ..write('isBuyer: $isBuyer, ')
          ..write('isSupplier: $isSupplier, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        tradeName,
        whatsapp,
        address,
        observations,
        active,
        ownerId,
        planType,
        productLimit,
        isRedeCotazap,
        priorityScore,
        approved,
        cnpjCpf,
        contactName,
        email,
        city,
        state,
        neighborhood,
        zipCode,
        complement,
        isBuyer,
        isSupplier,
        isSynced,
        lastUpdated
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppContact &&
          other.id == this.id &&
          other.tradeName == this.tradeName &&
          other.whatsapp == this.whatsapp &&
          other.address == this.address &&
          other.observations == this.observations &&
          other.active == this.active &&
          other.ownerId == this.ownerId &&
          other.planType == this.planType &&
          other.productLimit == this.productLimit &&
          other.isRedeCotazap == this.isRedeCotazap &&
          other.priorityScore == this.priorityScore &&
          other.approved == this.approved &&
          other.cnpjCpf == this.cnpjCpf &&
          other.contactName == this.contactName &&
          other.email == this.email &&
          other.city == this.city &&
          other.state == this.state &&
          other.neighborhood == this.neighborhood &&
          other.zipCode == this.zipCode &&
          other.complement == this.complement &&
          other.isBuyer == this.isBuyer &&
          other.isSupplier == this.isSupplier &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class AppContactsCompanion extends UpdateCompanion<AppContact> {
  final Value<int> id;
  final Value<String> tradeName;
  final Value<String> whatsapp;
  final Value<String?> address;
  final Value<String?> observations;
  final Value<bool> active;
  final Value<String?> ownerId;
  final Value<String?> planType;
  final Value<int?> productLimit;
  final Value<bool> isRedeCotazap;
  final Value<int> priorityScore;
  final Value<bool> approved;
  final Value<String?> cnpjCpf;
  final Value<String?> contactName;
  final Value<String?> email;
  final Value<String?> city;
  final Value<String?> state;
  final Value<String?> neighborhood;
  final Value<String?> zipCode;
  final Value<String?> complement;
  final Value<bool> isBuyer;
  final Value<bool> isSupplier;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const AppContactsCompanion({
    this.id = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.observations = const Value.absent(),
    this.active = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.planType = const Value.absent(),
    this.productLimit = const Value.absent(),
    this.isRedeCotazap = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.approved = const Value.absent(),
    this.cnpjCpf = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.neighborhood = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.complement = const Value.absent(),
    this.isBuyer = const Value.absent(),
    this.isSupplier = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  AppContactsCompanion.insert({
    this.id = const Value.absent(),
    required String tradeName,
    required String whatsapp,
    this.address = const Value.absent(),
    this.observations = const Value.absent(),
    this.active = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.planType = const Value.absent(),
    this.productLimit = const Value.absent(),
    this.isRedeCotazap = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.approved = const Value.absent(),
    this.cnpjCpf = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.neighborhood = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.complement = const Value.absent(),
    this.isBuyer = const Value.absent(),
    this.isSupplier = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : tradeName = Value(tradeName),
        whatsapp = Value(whatsapp);
  static Insertable<AppContact> custom({
    Expression<int>? id,
    Expression<String>? tradeName,
    Expression<String>? whatsapp,
    Expression<String>? address,
    Expression<String>? observations,
    Expression<bool>? active,
    Expression<String>? ownerId,
    Expression<String>? planType,
    Expression<int>? productLimit,
    Expression<bool>? isRedeCotazap,
    Expression<int>? priorityScore,
    Expression<bool>? approved,
    Expression<String>? cnpjCpf,
    Expression<String>? contactName,
    Expression<String>? email,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? neighborhood,
    Expression<String>? zipCode,
    Expression<String>? complement,
    Expression<bool>? isBuyer,
    Expression<bool>? isSupplier,
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
      if (ownerId != null) 'owner_id': ownerId,
      if (planType != null) 'plan_type': planType,
      if (productLimit != null) 'product_limit': productLimit,
      if (isRedeCotazap != null) 'is_rede_cotazap': isRedeCotazap,
      if (priorityScore != null) 'priority_score': priorityScore,
      if (approved != null) 'approved': approved,
      if (cnpjCpf != null) 'cnpj_cpf': cnpjCpf,
      if (contactName != null) 'contact_name': contactName,
      if (email != null) 'email': email,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (neighborhood != null) 'neighborhood': neighborhood,
      if (zipCode != null) 'zip_code': zipCode,
      if (complement != null) 'complement': complement,
      if (isBuyer != null) 'is_buyer': isBuyer,
      if (isSupplier != null) 'is_supplier': isSupplier,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  AppContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? tradeName,
      Value<String>? whatsapp,
      Value<String?>? address,
      Value<String?>? observations,
      Value<bool>? active,
      Value<String?>? ownerId,
      Value<String?>? planType,
      Value<int?>? productLimit,
      Value<bool>? isRedeCotazap,
      Value<int>? priorityScore,
      Value<bool>? approved,
      Value<String?>? cnpjCpf,
      Value<String?>? contactName,
      Value<String?>? email,
      Value<String?>? city,
      Value<String?>? state,
      Value<String?>? neighborhood,
      Value<String?>? zipCode,
      Value<String?>? complement,
      Value<bool>? isBuyer,
      Value<bool>? isSupplier,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return AppContactsCompanion(
      id: id ?? this.id,
      tradeName: tradeName ?? this.tradeName,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      observations: observations ?? this.observations,
      active: active ?? this.active,
      ownerId: ownerId ?? this.ownerId,
      planType: planType ?? this.planType,
      productLimit: productLimit ?? this.productLimit,
      isRedeCotazap: isRedeCotazap ?? this.isRedeCotazap,
      priorityScore: priorityScore ?? this.priorityScore,
      approved: approved ?? this.approved,
      cnpjCpf: cnpjCpf ?? this.cnpjCpf,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      city: city ?? this.city,
      state: state ?? this.state,
      neighborhood: neighborhood ?? this.neighborhood,
      zipCode: zipCode ?? this.zipCode,
      complement: complement ?? this.complement,
      isBuyer: isBuyer ?? this.isBuyer,
      isSupplier: isSupplier ?? this.isSupplier,
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
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (productLimit.present) {
      map['product_limit'] = Variable<int>(productLimit.value);
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
    if (cnpjCpf.present) {
      map['cnpj_cpf'] = Variable<String>(cnpjCpf.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (neighborhood.present) {
      map['neighborhood'] = Variable<String>(neighborhood.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (complement.present) {
      map['complement'] = Variable<String>(complement.value);
    }
    if (isBuyer.present) {
      map['is_buyer'] = Variable<bool>(isBuyer.value);
    }
    if (isSupplier.present) {
      map['is_supplier'] = Variable<bool>(isSupplier.value);
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
    return (StringBuffer('AppContactsCompanion(')
          ..write('id: $id, ')
          ..write('tradeName: $tradeName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('observations: $observations, ')
          ..write('active: $active, ')
          ..write('ownerId: $ownerId, ')
          ..write('planType: $planType, ')
          ..write('productLimit: $productLimit, ')
          ..write('isRedeCotazap: $isRedeCotazap, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('approved: $approved, ')
          ..write('cnpjCpf: $cnpjCpf, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('zipCode: $zipCode, ')
          ..write('complement: $complement, ')
          ..write('isBuyer: $isBuyer, ')
          ..write('isSupplier: $isSupplier, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoriesTable extends ProductCategories
    with TableInfo<$ProductCategoriesTable, ProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoriesTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, true,
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
      [id, name, description, iconName, isSynced, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_categories';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCategory> instance,
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
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
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final int id;
  final String name;
  final String? description;
  final String? iconName;
  final bool isSynced;
  final DateTime lastUpdated;
  const ProductCategory(
      {required this.id,
      required this.name,
      this.description,
      this.iconName,
      required this.isSynced,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      iconName: serializer.fromJson<String?>(json['iconName']),
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
      'description': serializer.toJson<String?>(description),
      'iconName': serializer.toJson<String?>(iconName),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ProductCategory copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> iconName = const Value.absent(),
          bool? isSynced,
          DateTime? lastUpdated}) =>
      ProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        iconName: iconName.present ? iconName.value : this.iconName,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  ProductCategory copyWithCompanion(ProductCategoriesCompanion data) {
    return ProductCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, iconName, isSynced, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconName == this.iconName &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> iconName;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const ProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProductCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? iconName,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconName != null) 'icon_name': iconName,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ProductCategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? iconName,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return ProductCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
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
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
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
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_categories (id)'));
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        categoryId,
        ownerId,
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
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
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
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id']),
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
  final int? categoryId;
  final String? ownerId;
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
      this.categoryId,
      this.ownerId,
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
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
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
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
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
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
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
      'categoryId': serializer.toJson<int?>(categoryId),
      'ownerId': serializer.toJson<String?>(ownerId),
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
          Value<int?> categoryId = const Value.absent(),
          Value<String?> ownerId = const Value.absent(),
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
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        ownerId: ownerId.present ? ownerId.value : this.ownerId,
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
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
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
          ..write('categoryId: $categoryId, ')
          ..write('ownerId: $ownerId, ')
          ..write('isFromRede: $isFromRede, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sku,
      description,
      unitMeasure,
      packagingType,
      attributesJson,
      categoryId,
      ownerId,
      isFromRede,
      isSynced,
      lastUpdated);
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
          other.categoryId == this.categoryId &&
          other.ownerId == this.ownerId &&
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
  final Value<int?> categoryId;
  final Value<String?> ownerId;
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
    this.categoryId = const Value.absent(),
    this.ownerId = const Value.absent(),
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
    this.categoryId = const Value.absent(),
    this.ownerId = const Value.absent(),
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
    Expression<int>? categoryId,
    Expression<String>? ownerId,
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
      if (categoryId != null) 'category_id': categoryId,
      if (ownerId != null) 'owner_id': ownerId,
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
      Value<int?>? categoryId,
      Value<String?>? ownerId,
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
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
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
          ..write('categoryId: $categoryId, ')
          ..write('ownerId: $ownerId, ')
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
          GeneratedColumn.constraintIsAlways('REFERENCES app_contacts (id)'));
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

class $SupplierCategoriesTable extends SupplierCategories
    with TableInfo<$SupplierCategoriesTable, SupplierCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES app_contacts (id)'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_categories (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, supplierId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_categories';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $SupplierCategoriesTable createAlias(String alias) {
    return $SupplierCategoriesTable(attachedDatabase, alias);
  }
}

class SupplierCategory extends DataClass
    implements Insertable<SupplierCategory> {
  final int id;
  final int supplierId;
  final int categoryId;
  const SupplierCategory(
      {required this.id, required this.supplierId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  SupplierCategoriesCompanion toCompanion(bool nullToAbsent) {
    return SupplierCategoriesCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      categoryId: Value(categoryId),
    );
  }

  factory SupplierCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierCategory(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  SupplierCategory copyWith({int? id, int? supplierId, int? categoryId}) =>
      SupplierCategory(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        categoryId: categoryId ?? this.categoryId,
      );
  SupplierCategory copyWithCompanion(SupplierCategoriesCompanion data) {
    return SupplierCategory(
      id: data.id.present ? data.id.value : this.id,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierCategory(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierCategory &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.categoryId == this.categoryId);
}

class SupplierCategoriesCompanion extends UpdateCompanion<SupplierCategory> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<int> categoryId;
  const SupplierCategoriesCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  SupplierCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    required int categoryId,
  })  : supplierId = Value(supplierId),
        categoryId = Value(categoryId);
  static Insertable<SupplierCategory> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  SupplierCategoriesCompanion copyWith(
      {Value<int>? id, Value<int>? supplierId, Value<int>? categoryId}) {
    return SupplierCategoriesCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $SupplierInteractionsTable extends SupplierInteractions
    with TableInfo<$SupplierInteractionsTable, SupplierInteraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierInteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _buyerOwnerIdMeta =
      const VerificationMeta('buyerOwnerId');
  @override
  late final GeneratedColumn<String> buyerOwnerId = GeneratedColumn<String>(
      'buyer_owner_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES app_contacts (id)'));
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
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
      [id, buyerOwnerId, supplierId, rating, comment, isFavorite, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_interactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<SupplierInteraction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_owner_id')) {
      context.handle(
          _buyerOwnerIdMeta,
          buyerOwnerId.isAcceptableOrUnknown(
              data['buyer_owner_id']!, _buyerOwnerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerOwnerIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
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
  SupplierInteraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierInteraction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      buyerOwnerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer_owner_id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating'])!,
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $SupplierInteractionsTable createAlias(String alias) {
    return $SupplierInteractionsTable(attachedDatabase, alias);
  }
}

class SupplierInteraction extends DataClass
    implements Insertable<SupplierInteraction> {
  final int id;
  final String buyerOwnerId;
  final int supplierId;
  final int rating;
  final String? comment;
  final bool isFavorite;
  final DateTime lastUpdated;
  const SupplierInteraction(
      {required this.id,
      required this.buyerOwnerId,
      required this.supplierId,
      required this.rating,
      this.comment,
      required this.isFavorite,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_owner_id'] = Variable<String>(buyerOwnerId);
    map['supplier_id'] = Variable<int>(supplierId);
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  SupplierInteractionsCompanion toCompanion(bool nullToAbsent) {
    return SupplierInteractionsCompanion(
      id: Value(id),
      buyerOwnerId: Value(buyerOwnerId),
      supplierId: Value(supplierId),
      rating: Value(rating),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      isFavorite: Value(isFavorite),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory SupplierInteraction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierInteraction(
      id: serializer.fromJson<int>(json['id']),
      buyerOwnerId: serializer.fromJson<String>(json['buyerOwnerId']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      rating: serializer.fromJson<int>(json['rating']),
      comment: serializer.fromJson<String?>(json['comment']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerOwnerId': serializer.toJson<String>(buyerOwnerId),
      'supplierId': serializer.toJson<int>(supplierId),
      'rating': serializer.toJson<int>(rating),
      'comment': serializer.toJson<String?>(comment),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  SupplierInteraction copyWith(
          {int? id,
          String? buyerOwnerId,
          int? supplierId,
          int? rating,
          Value<String?> comment = const Value.absent(),
          bool? isFavorite,
          DateTime? lastUpdated}) =>
      SupplierInteraction(
        id: id ?? this.id,
        buyerOwnerId: buyerOwnerId ?? this.buyerOwnerId,
        supplierId: supplierId ?? this.supplierId,
        rating: rating ?? this.rating,
        comment: comment.present ? comment.value : this.comment,
        isFavorite: isFavorite ?? this.isFavorite,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  SupplierInteraction copyWithCompanion(SupplierInteractionsCompanion data) {
    return SupplierInteraction(
      id: data.id.present ? data.id.value : this.id,
      buyerOwnerId: data.buyerOwnerId.present
          ? data.buyerOwnerId.value
          : this.buyerOwnerId,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      rating: data.rating.present ? data.rating.value : this.rating,
      comment: data.comment.present ? data.comment.value : this.comment,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierInteraction(')
          ..write('id: $id, ')
          ..write('buyerOwnerId: $buyerOwnerId, ')
          ..write('supplierId: $supplierId, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, buyerOwnerId, supplierId, rating, comment, isFavorite, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierInteraction &&
          other.id == this.id &&
          other.buyerOwnerId == this.buyerOwnerId &&
          other.supplierId == this.supplierId &&
          other.rating == this.rating &&
          other.comment == this.comment &&
          other.isFavorite == this.isFavorite &&
          other.lastUpdated == this.lastUpdated);
}

class SupplierInteractionsCompanion
    extends UpdateCompanion<SupplierInteraction> {
  final Value<int> id;
  final Value<String> buyerOwnerId;
  final Value<int> supplierId;
  final Value<int> rating;
  final Value<String?> comment;
  final Value<bool> isFavorite;
  final Value<DateTime> lastUpdated;
  const SupplierInteractionsCompanion({
    this.id = const Value.absent(),
    this.buyerOwnerId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  SupplierInteractionsCompanion.insert({
    this.id = const Value.absent(),
    required String buyerOwnerId,
    required int supplierId,
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : buyerOwnerId = Value(buyerOwnerId),
        supplierId = Value(supplierId);
  static Insertable<SupplierInteraction> custom({
    Expression<int>? id,
    Expression<String>? buyerOwnerId,
    Expression<int>? supplierId,
    Expression<int>? rating,
    Expression<String>? comment,
    Expression<bool>? isFavorite,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerOwnerId != null) 'buyer_owner_id': buyerOwnerId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (rating != null) 'rating': rating,
      if (comment != null) 'comment': comment,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  SupplierInteractionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? buyerOwnerId,
      Value<int>? supplierId,
      Value<int>? rating,
      Value<String?>? comment,
      Value<bool>? isFavorite,
      Value<DateTime>? lastUpdated}) {
    return SupplierInteractionsCompanion(
      id: id ?? this.id,
      buyerOwnerId: buyerOwnerId ?? this.buyerOwnerId,
      supplierId: supplierId ?? this.supplierId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerOwnerId.present) {
      map['buyer_owner_id'] = Variable<String>(buyerOwnerId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierInteractionsCompanion(')
          ..write('id: $id, ')
          ..write('buyerOwnerId: $buyerOwnerId, ')
          ..write('supplierId: $supplierId, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUpdated: $lastUpdated')
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
  late final GeneratedColumn<String> buyerId = GeneratedColumn<String>(
      'buyer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES app_profiles (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES app_contacts (id)'));
  static const VerificationMeta _defaultPaymentTermDaysMeta =
      const VerificationMeta('defaultPaymentTermDays');
  @override
  late final GeneratedColumn<int> defaultPaymentTermDays = GeneratedColumn<int>(
      'default_payment_term_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _defaultPaymentConditionMeta =
      const VerificationMeta('defaultPaymentCondition');
  @override
  late final GeneratedColumn<String> defaultPaymentCondition =
      GeneratedColumn<String>('default_payment_condition', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _defaultLeadTimeDaysMeta =
      const VerificationMeta('defaultLeadTimeDays');
  @override
  late final GeneratedColumn<int> defaultLeadTimeDays = GeneratedColumn<int>(
      'default_lead_time_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _defaultDeliveryTypeMeta =
      const VerificationMeta('defaultDeliveryType');
  @override
  late final GeneratedColumn<String> defaultDeliveryType =
      GeneratedColumn<String>('default_delivery_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        buyerId,
        date,
        status,
        templateMessage,
        totalEconomy,
        winnerSupplierId,
        defaultPaymentTermDays,
        defaultPaymentCondition,
        defaultLeadTimeDays,
        defaultDeliveryType
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
    if (data.containsKey('default_payment_term_days')) {
      context.handle(
          _defaultPaymentTermDaysMeta,
          defaultPaymentTermDays.isAcceptableOrUnknown(
              data['default_payment_term_days']!, _defaultPaymentTermDaysMeta));
    }
    if (data.containsKey('default_payment_condition')) {
      context.handle(
          _defaultPaymentConditionMeta,
          defaultPaymentCondition.isAcceptableOrUnknown(
              data['default_payment_condition']!,
              _defaultPaymentConditionMeta));
    }
    if (data.containsKey('default_lead_time_days')) {
      context.handle(
          _defaultLeadTimeDaysMeta,
          defaultLeadTimeDays.isAcceptableOrUnknown(
              data['default_lead_time_days']!, _defaultLeadTimeDaysMeta));
    }
    if (data.containsKey('default_delivery_type')) {
      context.handle(
          _defaultDeliveryTypeMeta,
          defaultDeliveryType.isAcceptableOrUnknown(
              data['default_delivery_type']!, _defaultDeliveryTypeMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}buyer_id'])!,
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
      defaultPaymentTermDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}default_payment_term_days']),
      defaultPaymentCondition: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_payment_condition']),
      defaultLeadTimeDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_lead_time_days']),
      defaultDeliveryType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}default_delivery_type']),
    );
  }

  @override
  $QuotationsTable createAlias(String alias) {
    return $QuotationsTable(attachedDatabase, alias);
  }
}

class Quotation extends DataClass implements Insertable<Quotation> {
  final int id;
  final String buyerId;
  final DateTime date;
  final String status;
  final String templateMessage;
  final double totalEconomy;
  final int? winnerSupplierId;
  final int? defaultPaymentTermDays;
  final String? defaultPaymentCondition;
  final int? defaultLeadTimeDays;
  final String? defaultDeliveryType;
  const Quotation(
      {required this.id,
      required this.buyerId,
      required this.date,
      required this.status,
      required this.templateMessage,
      required this.totalEconomy,
      this.winnerSupplierId,
      this.defaultPaymentTermDays,
      this.defaultPaymentCondition,
      this.defaultLeadTimeDays,
      this.defaultDeliveryType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<String>(buyerId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    map['template_message'] = Variable<String>(templateMessage);
    map['total_economy'] = Variable<double>(totalEconomy);
    if (!nullToAbsent || winnerSupplierId != null) {
      map['winner_supplier_id'] = Variable<int>(winnerSupplierId);
    }
    if (!nullToAbsent || defaultPaymentTermDays != null) {
      map['default_payment_term_days'] = Variable<int>(defaultPaymentTermDays);
    }
    if (!nullToAbsent || defaultPaymentCondition != null) {
      map['default_payment_condition'] =
          Variable<String>(defaultPaymentCondition);
    }
    if (!nullToAbsent || defaultLeadTimeDays != null) {
      map['default_lead_time_days'] = Variable<int>(defaultLeadTimeDays);
    }
    if (!nullToAbsent || defaultDeliveryType != null) {
      map['default_delivery_type'] = Variable<String>(defaultDeliveryType);
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
      defaultPaymentTermDays: defaultPaymentTermDays == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPaymentTermDays),
      defaultPaymentCondition: defaultPaymentCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPaymentCondition),
      defaultLeadTimeDays: defaultLeadTimeDays == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultLeadTimeDays),
      defaultDeliveryType: defaultDeliveryType == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDeliveryType),
    );
  }

  factory Quotation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quotation(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<String>(json['buyerId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      templateMessage: serializer.fromJson<String>(json['templateMessage']),
      totalEconomy: serializer.fromJson<double>(json['totalEconomy']),
      winnerSupplierId: serializer.fromJson<int?>(json['winnerSupplierId']),
      defaultPaymentTermDays:
          serializer.fromJson<int?>(json['defaultPaymentTermDays']),
      defaultPaymentCondition:
          serializer.fromJson<String?>(json['defaultPaymentCondition']),
      defaultLeadTimeDays:
          serializer.fromJson<int?>(json['defaultLeadTimeDays']),
      defaultDeliveryType:
          serializer.fromJson<String?>(json['defaultDeliveryType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<String>(buyerId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'templateMessage': serializer.toJson<String>(templateMessage),
      'totalEconomy': serializer.toJson<double>(totalEconomy),
      'winnerSupplierId': serializer.toJson<int?>(winnerSupplierId),
      'defaultPaymentTermDays': serializer.toJson<int?>(defaultPaymentTermDays),
      'defaultPaymentCondition':
          serializer.toJson<String?>(defaultPaymentCondition),
      'defaultLeadTimeDays': serializer.toJson<int?>(defaultLeadTimeDays),
      'defaultDeliveryType': serializer.toJson<String?>(defaultDeliveryType),
    };
  }

  Quotation copyWith(
          {int? id,
          String? buyerId,
          DateTime? date,
          String? status,
          String? templateMessage,
          double? totalEconomy,
          Value<int?> winnerSupplierId = const Value.absent(),
          Value<int?> defaultPaymentTermDays = const Value.absent(),
          Value<String?> defaultPaymentCondition = const Value.absent(),
          Value<int?> defaultLeadTimeDays = const Value.absent(),
          Value<String?> defaultDeliveryType = const Value.absent()}) =>
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
        defaultPaymentTermDays: defaultPaymentTermDays.present
            ? defaultPaymentTermDays.value
            : this.defaultPaymentTermDays,
        defaultPaymentCondition: defaultPaymentCondition.present
            ? defaultPaymentCondition.value
            : this.defaultPaymentCondition,
        defaultLeadTimeDays: defaultLeadTimeDays.present
            ? defaultLeadTimeDays.value
            : this.defaultLeadTimeDays,
        defaultDeliveryType: defaultDeliveryType.present
            ? defaultDeliveryType.value
            : this.defaultDeliveryType,
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
      defaultPaymentTermDays: data.defaultPaymentTermDays.present
          ? data.defaultPaymentTermDays.value
          : this.defaultPaymentTermDays,
      defaultPaymentCondition: data.defaultPaymentCondition.present
          ? data.defaultPaymentCondition.value
          : this.defaultPaymentCondition,
      defaultLeadTimeDays: data.defaultLeadTimeDays.present
          ? data.defaultLeadTimeDays.value
          : this.defaultLeadTimeDays,
      defaultDeliveryType: data.defaultDeliveryType.present
          ? data.defaultDeliveryType.value
          : this.defaultDeliveryType,
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
          ..write('winnerSupplierId: $winnerSupplierId, ')
          ..write('defaultPaymentTermDays: $defaultPaymentTermDays, ')
          ..write('defaultPaymentCondition: $defaultPaymentCondition, ')
          ..write('defaultLeadTimeDays: $defaultLeadTimeDays, ')
          ..write('defaultDeliveryType: $defaultDeliveryType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      buyerId,
      date,
      status,
      templateMessage,
      totalEconomy,
      winnerSupplierId,
      defaultPaymentTermDays,
      defaultPaymentCondition,
      defaultLeadTimeDays,
      defaultDeliveryType);
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
          other.winnerSupplierId == this.winnerSupplierId &&
          other.defaultPaymentTermDays == this.defaultPaymentTermDays &&
          other.defaultPaymentCondition == this.defaultPaymentCondition &&
          other.defaultLeadTimeDays == this.defaultLeadTimeDays &&
          other.defaultDeliveryType == this.defaultDeliveryType);
}

class QuotationsCompanion extends UpdateCompanion<Quotation> {
  final Value<int> id;
  final Value<String> buyerId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<String> templateMessage;
  final Value<double> totalEconomy;
  final Value<int?> winnerSupplierId;
  final Value<int?> defaultPaymentTermDays;
  final Value<String?> defaultPaymentCondition;
  final Value<int?> defaultLeadTimeDays;
  final Value<String?> defaultDeliveryType;
  const QuotationsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.templateMessage = const Value.absent(),
    this.totalEconomy = const Value.absent(),
    this.winnerSupplierId = const Value.absent(),
    this.defaultPaymentTermDays = const Value.absent(),
    this.defaultPaymentCondition = const Value.absent(),
    this.defaultLeadTimeDays = const Value.absent(),
    this.defaultDeliveryType = const Value.absent(),
  });
  QuotationsCompanion.insert({
    this.id = const Value.absent(),
    required String buyerId,
    required DateTime date,
    required String status,
    required String templateMessage,
    this.totalEconomy = const Value.absent(),
    this.winnerSupplierId = const Value.absent(),
    this.defaultPaymentTermDays = const Value.absent(),
    this.defaultPaymentCondition = const Value.absent(),
    this.defaultLeadTimeDays = const Value.absent(),
    this.defaultDeliveryType = const Value.absent(),
  })  : buyerId = Value(buyerId),
        date = Value(date),
        status = Value(status),
        templateMessage = Value(templateMessage);
  static Insertable<Quotation> custom({
    Expression<int>? id,
    Expression<String>? buyerId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<String>? templateMessage,
    Expression<double>? totalEconomy,
    Expression<int>? winnerSupplierId,
    Expression<int>? defaultPaymentTermDays,
    Expression<String>? defaultPaymentCondition,
    Expression<int>? defaultLeadTimeDays,
    Expression<String>? defaultDeliveryType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (templateMessage != null) 'template_message': templateMessage,
      if (totalEconomy != null) 'total_economy': totalEconomy,
      if (winnerSupplierId != null) 'winner_supplier_id': winnerSupplierId,
      if (defaultPaymentTermDays != null)
        'default_payment_term_days': defaultPaymentTermDays,
      if (defaultPaymentCondition != null)
        'default_payment_condition': defaultPaymentCondition,
      if (defaultLeadTimeDays != null)
        'default_lead_time_days': defaultLeadTimeDays,
      if (defaultDeliveryType != null)
        'default_delivery_type': defaultDeliveryType,
    });
  }

  QuotationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? buyerId,
      Value<DateTime>? date,
      Value<String>? status,
      Value<String>? templateMessage,
      Value<double>? totalEconomy,
      Value<int?>? winnerSupplierId,
      Value<int?>? defaultPaymentTermDays,
      Value<String?>? defaultPaymentCondition,
      Value<int?>? defaultLeadTimeDays,
      Value<String?>? defaultDeliveryType}) {
    return QuotationsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      date: date ?? this.date,
      status: status ?? this.status,
      templateMessage: templateMessage ?? this.templateMessage,
      totalEconomy: totalEconomy ?? this.totalEconomy,
      winnerSupplierId: winnerSupplierId ?? this.winnerSupplierId,
      defaultPaymentTermDays:
          defaultPaymentTermDays ?? this.defaultPaymentTermDays,
      defaultPaymentCondition:
          defaultPaymentCondition ?? this.defaultPaymentCondition,
      defaultLeadTimeDays: defaultLeadTimeDays ?? this.defaultLeadTimeDays,
      defaultDeliveryType: defaultDeliveryType ?? this.defaultDeliveryType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<String>(buyerId.value);
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
    if (defaultPaymentTermDays.present) {
      map['default_payment_term_days'] =
          Variable<int>(defaultPaymentTermDays.value);
    }
    if (defaultPaymentCondition.present) {
      map['default_payment_condition'] =
          Variable<String>(defaultPaymentCondition.value);
    }
    if (defaultLeadTimeDays.present) {
      map['default_lead_time_days'] = Variable<int>(defaultLeadTimeDays.value);
    }
    if (defaultDeliveryType.present) {
      map['default_delivery_type'] =
          Variable<String>(defaultDeliveryType.value);
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
          ..write('winnerSupplierId: $winnerSupplierId, ')
          ..write('defaultPaymentTermDays: $defaultPaymentTermDays, ')
          ..write('defaultPaymentCondition: $defaultPaymentCondition, ')
          ..write('defaultLeadTimeDays: $defaultLeadTimeDays, ')
          ..write('defaultDeliveryType: $defaultDeliveryType')
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
          GeneratedColumn.constraintIsAlways('REFERENCES app_contacts (id)'));
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

class $UsageQuotasTable extends UsageQuotas
    with TableInfo<$UsageQuotasTable, UsageQuota> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageQuotasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quotaTypeMeta =
      const VerificationMeta('quotaType');
  @override
  late final GeneratedColumn<String> quotaType = GeneratedColumn<String>(
      'quota_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usedCountMeta =
      const VerificationMeta('usedCount');
  @override
  late final GeneratedColumn<int> usedCount = GeneratedColumn<int>(
      'used_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _limitCountMeta =
      const VerificationMeta('limitCount');
  @override
  late final GeneratedColumn<int> limitCount = GeneratedColumn<int>(
      'limit_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastResetAtMeta =
      const VerificationMeta('lastResetAt');
  @override
  late final GeneratedColumn<DateTime> lastResetAt = GeneratedColumn<DateTime>(
      'last_reset_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ownerId, quotaType, usedCount, limitCount, lastResetAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_quotas';
  @override
  VerificationContext validateIntegrity(Insertable<UsageQuota> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('quota_type')) {
      context.handle(_quotaTypeMeta,
          quotaType.isAcceptableOrUnknown(data['quota_type']!, _quotaTypeMeta));
    } else if (isInserting) {
      context.missing(_quotaTypeMeta);
    }
    if (data.containsKey('used_count')) {
      context.handle(_usedCountMeta,
          usedCount.isAcceptableOrUnknown(data['used_count']!, _usedCountMeta));
    }
    if (data.containsKey('limit_count')) {
      context.handle(
          _limitCountMeta,
          limitCount.isAcceptableOrUnknown(
              data['limit_count']!, _limitCountMeta));
    } else if (isInserting) {
      context.missing(_limitCountMeta);
    }
    if (data.containsKey('last_reset_at')) {
      context.handle(
          _lastResetAtMeta,
          lastResetAt.isAcceptableOrUnknown(
              data['last_reset_at']!, _lastResetAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageQuota map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageQuota(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      quotaType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quota_type'])!,
      usedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}used_count'])!,
      limitCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}limit_count'])!,
      lastResetAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_reset_at'])!,
    );
  }

  @override
  $UsageQuotasTable createAlias(String alias) {
    return $UsageQuotasTable(attachedDatabase, alias);
  }
}

class UsageQuota extends DataClass implements Insertable<UsageQuota> {
  final int id;
  final String ownerId;
  final String quotaType;
  final int usedCount;
  final int limitCount;
  final DateTime lastResetAt;
  const UsageQuota(
      {required this.id,
      required this.ownerId,
      required this.quotaType,
      required this.usedCount,
      required this.limitCount,
      required this.lastResetAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['quota_type'] = Variable<String>(quotaType);
    map['used_count'] = Variable<int>(usedCount);
    map['limit_count'] = Variable<int>(limitCount);
    map['last_reset_at'] = Variable<DateTime>(lastResetAt);
    return map;
  }

  UsageQuotasCompanion toCompanion(bool nullToAbsent) {
    return UsageQuotasCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      quotaType: Value(quotaType),
      usedCount: Value(usedCount),
      limitCount: Value(limitCount),
      lastResetAt: Value(lastResetAt),
    );
  }

  factory UsageQuota.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageQuota(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      quotaType: serializer.fromJson<String>(json['quotaType']),
      usedCount: serializer.fromJson<int>(json['usedCount']),
      limitCount: serializer.fromJson<int>(json['limitCount']),
      lastResetAt: serializer.fromJson<DateTime>(json['lastResetAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'quotaType': serializer.toJson<String>(quotaType),
      'usedCount': serializer.toJson<int>(usedCount),
      'limitCount': serializer.toJson<int>(limitCount),
      'lastResetAt': serializer.toJson<DateTime>(lastResetAt),
    };
  }

  UsageQuota copyWith(
          {int? id,
          String? ownerId,
          String? quotaType,
          int? usedCount,
          int? limitCount,
          DateTime? lastResetAt}) =>
      UsageQuota(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        quotaType: quotaType ?? this.quotaType,
        usedCount: usedCount ?? this.usedCount,
        limitCount: limitCount ?? this.limitCount,
        lastResetAt: lastResetAt ?? this.lastResetAt,
      );
  UsageQuota copyWithCompanion(UsageQuotasCompanion data) {
    return UsageQuota(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      quotaType: data.quotaType.present ? data.quotaType.value : this.quotaType,
      usedCount: data.usedCount.present ? data.usedCount.value : this.usedCount,
      limitCount:
          data.limitCount.present ? data.limitCount.value : this.limitCount,
      lastResetAt:
          data.lastResetAt.present ? data.lastResetAt.value : this.lastResetAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageQuota(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('quotaType: $quotaType, ')
          ..write('usedCount: $usedCount, ')
          ..write('limitCount: $limitCount, ')
          ..write('lastResetAt: $lastResetAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ownerId, quotaType, usedCount, limitCount, lastResetAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageQuota &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.quotaType == this.quotaType &&
          other.usedCount == this.usedCount &&
          other.limitCount == this.limitCount &&
          other.lastResetAt == this.lastResetAt);
}

class UsageQuotasCompanion extends UpdateCompanion<UsageQuota> {
  final Value<int> id;
  final Value<String> ownerId;
  final Value<String> quotaType;
  final Value<int> usedCount;
  final Value<int> limitCount;
  final Value<DateTime> lastResetAt;
  const UsageQuotasCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.quotaType = const Value.absent(),
    this.usedCount = const Value.absent(),
    this.limitCount = const Value.absent(),
    this.lastResetAt = const Value.absent(),
  });
  UsageQuotasCompanion.insert({
    this.id = const Value.absent(),
    required String ownerId,
    required String quotaType,
    this.usedCount = const Value.absent(),
    required int limitCount,
    this.lastResetAt = const Value.absent(),
  })  : ownerId = Value(ownerId),
        quotaType = Value(quotaType),
        limitCount = Value(limitCount);
  static Insertable<UsageQuota> custom({
    Expression<int>? id,
    Expression<String>? ownerId,
    Expression<String>? quotaType,
    Expression<int>? usedCount,
    Expression<int>? limitCount,
    Expression<DateTime>? lastResetAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (quotaType != null) 'quota_type': quotaType,
      if (usedCount != null) 'used_count': usedCount,
      if (limitCount != null) 'limit_count': limitCount,
      if (lastResetAt != null) 'last_reset_at': lastResetAt,
    });
  }

  UsageQuotasCompanion copyWith(
      {Value<int>? id,
      Value<String>? ownerId,
      Value<String>? quotaType,
      Value<int>? usedCount,
      Value<int>? limitCount,
      Value<DateTime>? lastResetAt}) {
    return UsageQuotasCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      quotaType: quotaType ?? this.quotaType,
      usedCount: usedCount ?? this.usedCount,
      limitCount: limitCount ?? this.limitCount,
      lastResetAt: lastResetAt ?? this.lastResetAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (quotaType.present) {
      map['quota_type'] = Variable<String>(quotaType.value);
    }
    if (usedCount.present) {
      map['used_count'] = Variable<int>(usedCount.value);
    }
    if (limitCount.present) {
      map['limit_count'] = Variable<int>(limitCount.value);
    }
    if (lastResetAt.present) {
      map['last_reset_at'] = Variable<DateTime>(lastResetAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageQuotasCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('quotaType: $quotaType, ')
          ..write('usedCount: $usedCount, ')
          ..write('limitCount: $limitCount, ')
          ..write('lastResetAt: $lastResetAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryRequestsTable extends CategoryRequests
    with TableInfo<$CategoryRequestsTable, CategoryRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryRequestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requesterIdMeta =
      const VerificationMeta('requesterId');
  @override
  late final GeneratedColumn<String> requesterId = GeneratedColumn<String>(
      'requester_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, requesterId, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_requests';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryRequest> instance,
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('requester_id')) {
      context.handle(
          _requesterIdMeta,
          requesterId.isAcceptableOrUnknown(
              data['requester_id']!, _requesterIdMeta));
    } else if (isInserting) {
      context.missing(_requesterIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      requesterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}requester_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CategoryRequestsTable createAlias(String alias) {
    return $CategoryRequestsTable(attachedDatabase, alias);
  }
}

class CategoryRequest extends DataClass implements Insertable<CategoryRequest> {
  final int id;
  final String name;
  final String? description;
  final String requesterId;
  final String status;
  final DateTime createdAt;
  const CategoryRequest(
      {required this.id,
      required this.name,
      this.description,
      required this.requesterId,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['requester_id'] = Variable<String>(requesterId);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoryRequestsCompanion toCompanion(bool nullToAbsent) {
    return CategoryRequestsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      requesterId: Value(requesterId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory CategoryRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRequest(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      requesterId: serializer.fromJson<String>(json['requesterId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'requesterId': serializer.toJson<String>(requesterId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CategoryRequest copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? requesterId,
          String? status,
          DateTime? createdAt}) =>
      CategoryRequest(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        requesterId: requesterId ?? this.requesterId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  CategoryRequest copyWithCompanion(CategoryRequestsCompanion data) {
    return CategoryRequest(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      requesterId:
          data.requesterId.present ? data.requesterId.value : this.requesterId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRequest(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('requesterId: $requesterId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, requesterId, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRequest &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.requesterId == this.requesterId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class CategoryRequestsCompanion extends UpdateCompanion<CategoryRequest> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> requesterId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const CategoryRequestsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.requesterId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoryRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String requesterId,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        requesterId = Value(requesterId);
  static Insertable<CategoryRequest> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? requesterId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (requesterId != null) 'requester_id': requesterId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoryRequestsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? requesterId,
      Value<String>? status,
      Value<DateTime>? createdAt}) {
    return CategoryRequestsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      requesterId: requesterId ?? this.requesterId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (requesterId.present) {
      map['requester_id'] = Variable<String>(requesterId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRequestsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('requesterId: $requesterId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UnitsOfMeasureTable extends UnitsOfMeasure
    with TableInfo<$UnitsOfMeasureTable, UnitsOfMeasureData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsOfMeasureTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
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
  List<GeneratedColumn> get $columns =>
      [id, code, name, description, category, isActive, isSynced, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units_of_measure';
  @override
  VerificationContext validateIntegrity(Insertable<UnitsOfMeasureData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
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
  UnitsOfMeasureData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitsOfMeasureData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $UnitsOfMeasureTable createAlias(String alias) {
    return $UnitsOfMeasureTable(attachedDatabase, alias);
  }
}

class UnitsOfMeasureData extends DataClass
    implements Insertable<UnitsOfMeasureData> {
  final int id;
  final String code;
  final String name;
  final String? description;
  final String? category;
  final bool isActive;
  final bool isSynced;
  final DateTime lastUpdated;
  const UnitsOfMeasureData(
      {required this.id,
      required this.code,
      required this.name,
      this.description,
      this.category,
      required this.isActive,
      required this.isSynced,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_synced'] = Variable<bool>(isSynced);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  UnitsOfMeasureCompanion toCompanion(bool nullToAbsent) {
    return UnitsOfMeasureCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isActive: Value(isActive),
      isSynced: Value(isSynced),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory UnitsOfMeasureData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitsOfMeasureData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String?>(category),
      'isActive': serializer.toJson<bool>(isActive),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  UnitsOfMeasureData copyWith(
          {int? id,
          String? code,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> category = const Value.absent(),
          bool? isActive,
          bool? isSynced,
          DateTime? lastUpdated}) =>
      UnitsOfMeasureData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        category: category.present ? category.value : this.category,
        isActive: isActive ?? this.isActive,
        isSynced: isSynced ?? this.isSynced,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  UnitsOfMeasureData copyWithCompanion(UnitsOfMeasureCompanion data) {
    return UnitsOfMeasureData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitsOfMeasureData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, code, name, description, category, isActive, isSynced, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitsOfMeasureData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.isActive == this.isActive &&
          other.isSynced == this.isSynced &&
          other.lastUpdated == this.lastUpdated);
}

class UnitsOfMeasureCompanion extends UpdateCompanion<UnitsOfMeasureData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> category;
  final Value<bool> isActive;
  final Value<bool> isSynced;
  final Value<DateTime> lastUpdated;
  const UnitsOfMeasureCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  UnitsOfMeasureCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<UnitsOfMeasureData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<bool>? isActive,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (isActive != null) 'is_active': isActive,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  UnitsOfMeasureCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? category,
      Value<bool>? isActive,
      Value<bool>? isSynced,
      Value<DateTime>? lastUpdated}) {
    return UnitsOfMeasureCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('UnitsOfMeasureCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppProfilesTable appProfiles = $AppProfilesTable(this);
  late final $AppContactsTable appContacts = $AppContactsTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductSuppliersTable productSuppliers =
      $ProductSuppliersTable(this);
  late final $SupplierCategoriesTable supplierCategories =
      $SupplierCategoriesTable(this);
  late final $SupplierInteractionsTable supplierInteractions =
      $SupplierInteractionsTable(this);
  late final $QuotationsTable quotations = $QuotationsTable(this);
  late final $SupplierResponsesTable supplierResponses =
      $SupplierResponsesTable(this);
  late final $QuotationItemsTable quotationItems = $QuotationItemsTable(this);
  late final $UsageQuotasTable usageQuotas = $UsageQuotasTable(this);
  late final $CategoryRequestsTable categoryRequests =
      $CategoryRequestsTable(this);
  late final $UnitsOfMeasureTable unitsOfMeasure = $UnitsOfMeasureTable(this);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ProductsDao productsDao = ProductsDao(this as AppDatabase);
  late final QuotationsDao quotationsDao = QuotationsDao(this as AppDatabase);
  late final SupplierResponsesDao supplierResponsesDao =
      SupplierResponsesDao(this as AppDatabase);
  late final UsageQuotasDao usageQuotasDao =
      UsageQuotasDao(this as AppDatabase);
  late final CategoryRequestsDao categoryRequestsDao =
      CategoryRequestsDao(this as AppDatabase);
  late final UnitsOfMeasureDao unitsOfMeasureDao =
      UnitsOfMeasureDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appProfiles,
        appContacts,
        productCategories,
        products,
        productSuppliers,
        supplierCategories,
        supplierInteractions,
        quotations,
        supplierResponses,
        quotationItems,
        usageQuotas,
        categoryRequests,
        unitsOfMeasure
      ];
}

typedef $$AppProfilesTableCreateCompanionBuilder = AppProfilesCompanion
    Function({
  required String id,
  required String name,
  required String role,
  Value<String> planType,
  Value<String?> avatarUrl,
  Value<int> rowid,
});
typedef $$AppProfilesTableUpdateCompanionBuilder = AppProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> role,
  Value<String> planType,
  Value<String?> avatarUrl,
  Value<int> rowid,
});

final class $$AppProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $AppProfilesTable, AppProfile> {
  $$AppProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
      _quotationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.quotations,
          aliasName:
              $_aliasNameGenerator(db.appProfiles.id, db.quotations.buyerId));

  $$QuotationsTableProcessedTableManager get quotationsRefs {
    final manager = $$QuotationsTableTableManager($_db, $_db.quotations)
        .filter((f) => f.buyerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AppProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $AppProfilesTable> {
  $$AppProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planType => $composableBuilder(
      column: $table.planType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

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

class $$AppProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppProfilesTable> {
  $$AppProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planType => $composableBuilder(
      column: $table.planType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));
}

class $$AppProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppProfilesTable> {
  $$AppProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

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

class $$AppProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppProfilesTable,
    AppProfile,
    $$AppProfilesTableFilterComposer,
    $$AppProfilesTableOrderingComposer,
    $$AppProfilesTableAnnotationComposer,
    $$AppProfilesTableCreateCompanionBuilder,
    $$AppProfilesTableUpdateCompanionBuilder,
    (AppProfile, $$AppProfilesTableReferences),
    AppProfile,
    PrefetchHooks Function({bool quotationsRefs})> {
  $$AppProfilesTableTableManager(_$AppDatabase db, $AppProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> planType = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppProfilesCompanion(
            id: id,
            name: name,
            role: role,
            planType: planType,
            avatarUrl: avatarUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String role,
            Value<String> planType = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppProfilesCompanion.insert(
            id: id,
            name: name,
            role: role,
            planType: planType,
            avatarUrl: avatarUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AppProfilesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({quotationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (quotationsRefs) db.quotations],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotationsRefs)
                    await $_getPrefetchedData<AppProfile, $AppProfilesTable,
                            Quotation>(
                        currentTable: table,
                        referencedTable: $$AppProfilesTableReferences
                            ._quotationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppProfilesTableReferences(db, table, p0)
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

typedef $$AppProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppProfilesTable,
    AppProfile,
    $$AppProfilesTableFilterComposer,
    $$AppProfilesTableOrderingComposer,
    $$AppProfilesTableAnnotationComposer,
    $$AppProfilesTableCreateCompanionBuilder,
    $$AppProfilesTableUpdateCompanionBuilder,
    (AppProfile, $$AppProfilesTableReferences),
    AppProfile,
    PrefetchHooks Function({bool quotationsRefs})>;
typedef $$AppContactsTableCreateCompanionBuilder = AppContactsCompanion
    Function({
  Value<int> id,
  required String tradeName,
  required String whatsapp,
  Value<String?> address,
  Value<String?> observations,
  Value<bool> active,
  Value<String?> ownerId,
  Value<String?> planType,
  Value<int?> productLimit,
  Value<bool> isRedeCotazap,
  Value<int> priorityScore,
  Value<bool> approved,
  Value<String?> cnpjCpf,
  Value<String?> contactName,
  Value<String?> email,
  Value<String?> city,
  Value<String?> state,
  Value<String?> neighborhood,
  Value<String?> zipCode,
  Value<String?> complement,
  Value<bool> isBuyer,
  Value<bool> isSupplier,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$AppContactsTableUpdateCompanionBuilder = AppContactsCompanion
    Function({
  Value<int> id,
  Value<String> tradeName,
  Value<String> whatsapp,
  Value<String?> address,
  Value<String?> observations,
  Value<bool> active,
  Value<String?> ownerId,
  Value<String?> planType,
  Value<int?> productLimit,
  Value<bool> isRedeCotazap,
  Value<int> priorityScore,
  Value<bool> approved,
  Value<String?> cnpjCpf,
  Value<String?> contactName,
  Value<String?> email,
  Value<String?> city,
  Value<String?> state,
  Value<String?> neighborhood,
  Value<String?> zipCode,
  Value<String?> complement,
  Value<bool> isBuyer,
  Value<bool> isSupplier,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$AppContactsTableReferences
    extends BaseReferences<_$AppDatabase, $AppContactsTable, AppContact> {
  $$AppContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductSuppliersTable, List<ProductSupplier>>
      _productSuppliersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.productSuppliers,
              aliasName: $_aliasNameGenerator(
                  db.appContacts.id, db.productSuppliers.supplierId));

  $$ProductSuppliersTableProcessedTableManager get productSuppliersRefs {
    final manager =
        $$ProductSuppliersTableTableManager($_db, $_db.productSuppliers)
            .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productSuppliersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierCategoriesTable, List<SupplierCategory>>
      _supplierCategoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.supplierCategories,
              aliasName: $_aliasNameGenerator(
                  db.appContacts.id, db.supplierCategories.supplierId));

  $$SupplierCategoriesTableProcessedTableManager get supplierCategoriesRefs {
    final manager =
        $$SupplierCategoriesTableTableManager($_db, $_db.supplierCategories)
            .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_supplierCategoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierInteractionsTable,
      List<SupplierInteraction>> _supplierInteractionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.supplierInteractions,
          aliasName: $_aliasNameGenerator(
              db.appContacts.id, db.supplierInteractions.supplierId));

  $$SupplierInteractionsTableProcessedTableManager
      get supplierInteractionsRefs {
    final manager =
        $$SupplierInteractionsTableTableManager($_db, $_db.supplierInteractions)
            .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_supplierInteractionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
      _quotationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.quotations,
              aliasName: $_aliasNameGenerator(
                  db.appContacts.id, db.quotations.winnerSupplierId));

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
                  db.appContacts.id, db.supplierResponses.supplierId));

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

class $$AppContactsTableFilterComposer
    extends Composer<_$AppDatabase, $AppContactsTable> {
  $$AppContactsTableFilterComposer({
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

  ColumnFilters<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planType => $composableBuilder(
      column: $table.planType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get productLimit => $composableBuilder(
      column: $table.productLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get approved => $composableBuilder(
      column: $table.approved, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cnpjCpf => $composableBuilder(
      column: $table.cnpjCpf, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactName => $composableBuilder(
      column: $table.contactName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get complement => $composableBuilder(
      column: $table.complement, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBuyer => $composableBuilder(
      column: $table.isBuyer, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSupplier => $composableBuilder(
      column: $table.isSupplier, builder: (column) => ColumnFilters(column));

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

  Expression<bool> supplierCategoriesRefs(
      Expression<bool> Function($$SupplierCategoriesTableFilterComposer f) f) {
    final $$SupplierCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.supplierCategories,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.supplierCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> supplierInteractionsRefs(
      Expression<bool> Function($$SupplierInteractionsTableFilterComposer f)
          f) {
    final $$SupplierInteractionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.supplierInteractions,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierInteractionsTableFilterComposer(
              $db: $db,
              $table: $db.supplierInteractions,
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

class $$AppContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppContactsTable> {
  $$AppContactsTableOrderingComposer({
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

  ColumnOrderings<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planType => $composableBuilder(
      column: $table.planType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get productLimit => $composableBuilder(
      column: $table.productLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get approved => $composableBuilder(
      column: $table.approved, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cnpjCpf => $composableBuilder(
      column: $table.cnpjCpf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactName => $composableBuilder(
      column: $table.contactName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get complement => $composableBuilder(
      column: $table.complement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBuyer => $composableBuilder(
      column: $table.isBuyer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSupplier => $composableBuilder(
      column: $table.isSupplier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$AppContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppContactsTable> {
  $$AppContactsTableAnnotationComposer({
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

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<int> get productLimit => $composableBuilder(
      column: $table.productLimit, builder: (column) => column);

  GeneratedColumn<bool> get isRedeCotazap => $composableBuilder(
      column: $table.isRedeCotazap, builder: (column) => column);

  GeneratedColumn<int> get priorityScore => $composableBuilder(
      column: $table.priorityScore, builder: (column) => column);

  GeneratedColumn<bool> get approved =>
      $composableBuilder(column: $table.approved, builder: (column) => column);

  GeneratedColumn<String> get cnpjCpf =>
      $composableBuilder(column: $table.cnpjCpf, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
      column: $table.contactName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get neighborhood => $composableBuilder(
      column: $table.neighborhood, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);

  GeneratedColumn<String> get complement => $composableBuilder(
      column: $table.complement, builder: (column) => column);

  GeneratedColumn<bool> get isBuyer =>
      $composableBuilder(column: $table.isBuyer, builder: (column) => column);

  GeneratedColumn<bool> get isSupplier => $composableBuilder(
      column: $table.isSupplier, builder: (column) => column);

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

  Expression<T> supplierCategoriesRefs<T extends Object>(
      Expression<T> Function($$SupplierCategoriesTableAnnotationComposer a) f) {
    final $$SupplierCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.supplierCategories,
            getReferencedColumn: (t) => t.supplierId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SupplierCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.supplierCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> supplierInteractionsRefs<T extends Object>(
      Expression<T> Function($$SupplierInteractionsTableAnnotationComposer a)
          f) {
    final $$SupplierInteractionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.supplierInteractions,
            getReferencedColumn: (t) => t.supplierId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SupplierInteractionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.supplierInteractions,
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

class $$AppContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppContactsTable,
    AppContact,
    $$AppContactsTableFilterComposer,
    $$AppContactsTableOrderingComposer,
    $$AppContactsTableAnnotationComposer,
    $$AppContactsTableCreateCompanionBuilder,
    $$AppContactsTableUpdateCompanionBuilder,
    (AppContact, $$AppContactsTableReferences),
    AppContact,
    PrefetchHooks Function(
        {bool productSuppliersRefs,
        bool supplierCategoriesRefs,
        bool supplierInteractionsRefs,
        bool quotationsRefs,
        bool supplierResponsesRefs})> {
  $$AppContactsTableTableManager(_$AppDatabase db, $AppContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tradeName = const Value.absent(),
            Value<String> whatsapp = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> observations = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<String?> ownerId = const Value.absent(),
            Value<String?> planType = const Value.absent(),
            Value<int?> productLimit = const Value.absent(),
            Value<bool> isRedeCotazap = const Value.absent(),
            Value<int> priorityScore = const Value.absent(),
            Value<bool> approved = const Value.absent(),
            Value<String?> cnpjCpf = const Value.absent(),
            Value<String?> contactName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> neighborhood = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<String?> complement = const Value.absent(),
            Value<bool> isBuyer = const Value.absent(),
            Value<bool> isSupplier = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              AppContactsCompanion(
            id: id,
            tradeName: tradeName,
            whatsapp: whatsapp,
            address: address,
            observations: observations,
            active: active,
            ownerId: ownerId,
            planType: planType,
            productLimit: productLimit,
            isRedeCotazap: isRedeCotazap,
            priorityScore: priorityScore,
            approved: approved,
            cnpjCpf: cnpjCpf,
            contactName: contactName,
            email: email,
            city: city,
            state: state,
            neighborhood: neighborhood,
            zipCode: zipCode,
            complement: complement,
            isBuyer: isBuyer,
            isSupplier: isSupplier,
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
            Value<String?> ownerId = const Value.absent(),
            Value<String?> planType = const Value.absent(),
            Value<int?> productLimit = const Value.absent(),
            Value<bool> isRedeCotazap = const Value.absent(),
            Value<int> priorityScore = const Value.absent(),
            Value<bool> approved = const Value.absent(),
            Value<String?> cnpjCpf = const Value.absent(),
            Value<String?> contactName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> neighborhood = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
            Value<String?> complement = const Value.absent(),
            Value<bool> isBuyer = const Value.absent(),
            Value<bool> isSupplier = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              AppContactsCompanion.insert(
            id: id,
            tradeName: tradeName,
            whatsapp: whatsapp,
            address: address,
            observations: observations,
            active: active,
            ownerId: ownerId,
            planType: planType,
            productLimit: productLimit,
            isRedeCotazap: isRedeCotazap,
            priorityScore: priorityScore,
            approved: approved,
            cnpjCpf: cnpjCpf,
            contactName: contactName,
            email: email,
            city: city,
            state: state,
            neighborhood: neighborhood,
            zipCode: zipCode,
            complement: complement,
            isBuyer: isBuyer,
            isSupplier: isSupplier,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AppContactsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productSuppliersRefs = false,
              supplierCategoriesRefs = false,
              supplierInteractionsRefs = false,
              quotationsRefs = false,
              supplierResponsesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productSuppliersRefs) db.productSuppliers,
                if (supplierCategoriesRefs) db.supplierCategories,
                if (supplierInteractionsRefs) db.supplierInteractions,
                if (quotationsRefs) db.quotations,
                if (supplierResponsesRefs) db.supplierResponses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productSuppliersRefs)
                    await $_getPrefetchedData<AppContact, $AppContactsTable,
                            ProductSupplier>(
                        currentTable: table,
                        referencedTable: $$AppContactsTableReferences
                            ._productSuppliersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppContactsTableReferences(db, table, p0)
                                .productSuppliersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.supplierId == item.id),
                        typedResults: items),
                  if (supplierCategoriesRefs)
                    await $_getPrefetchedData<AppContact, $AppContactsTable,
                            SupplierCategory>(
                        currentTable: table,
                        referencedTable: $$AppContactsTableReferences
                            ._supplierCategoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppContactsTableReferences(db, table, p0)
                                .supplierCategoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.supplierId == item.id),
                        typedResults: items),
                  if (supplierInteractionsRefs)
                    await $_getPrefetchedData<AppContact, $AppContactsTable,
                            SupplierInteraction>(
                        currentTable: table,
                        referencedTable: $$AppContactsTableReferences
                            ._supplierInteractionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppContactsTableReferences(db, table, p0)
                                .supplierInteractionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.supplierId == item.id),
                        typedResults: items),
                  if (quotationsRefs)
                    await $_getPrefetchedData<AppContact, $AppContactsTable,
                            Quotation>(
                        currentTable: table,
                        referencedTable: $$AppContactsTableReferences
                            ._quotationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppContactsTableReferences(db, table, p0)
                                .quotationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.winnerSupplierId == item.id),
                        typedResults: items),
                  if (supplierResponsesRefs)
                    await $_getPrefetchedData<AppContact, $AppContactsTable,
                            SupplierResponse>(
                        currentTable: table,
                        referencedTable: $$AppContactsTableReferences
                            ._supplierResponsesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppContactsTableReferences(db, table, p0)
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

typedef $$AppContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppContactsTable,
    AppContact,
    $$AppContactsTableFilterComposer,
    $$AppContactsTableOrderingComposer,
    $$AppContactsTableAnnotationComposer,
    $$AppContactsTableCreateCompanionBuilder,
    $$AppContactsTableUpdateCompanionBuilder,
    (AppContact, $$AppContactsTableReferences),
    AppContact,
    PrefetchHooks Function(
        {bool productSuppliersRefs,
        bool supplierCategoriesRefs,
        bool supplierInteractionsRefs,
        bool quotationsRefs,
        bool supplierResponsesRefs})>;
typedef $$ProductCategoriesTableCreateCompanionBuilder
    = ProductCategoriesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<String?> iconName,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$ProductCategoriesTableUpdateCompanionBuilder
    = ProductCategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> iconName,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$ProductCategoriesTableReferences extends BaseReferences<
    _$AppDatabase, $ProductCategoriesTable, ProductCategory> {
  $$ProductCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.products,
          aliasName: $_aliasNameGenerator(
              db.productCategories.id, db.products.categoryId));

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierCategoriesTable, List<SupplierCategory>>
      _supplierCategoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.supplierCategories,
              aliasName: $_aliasNameGenerator(
                  db.productCategories.id, db.supplierCategories.categoryId));

  $$SupplierCategoriesTableProcessedTableManager get supplierCategoriesRefs {
    final manager =
        $$SupplierCategoriesTableTableManager($_db, $_db.supplierCategories)
            .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_supplierCategoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> productsRefs(
      Expression<bool> Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.categoryId,
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
    return f(composer);
  }

  Expression<bool> supplierCategoriesRefs(
      Expression<bool> Function($$SupplierCategoriesTableFilterComposer f) f) {
    final $$SupplierCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.supplierCategories,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SupplierCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.supplierCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$ProductCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
      Expression<T> Function($$ProductsTableAnnotationComposer a) f) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.categoryId,
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
    return f(composer);
  }

  Expression<T> supplierCategoriesRefs<T extends Object>(
      Expression<T> Function($$SupplierCategoriesTableAnnotationComposer a) f) {
    final $$SupplierCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.supplierCategories,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SupplierCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.supplierCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ProductCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductCategoriesTable,
    ProductCategory,
    $$ProductCategoriesTableFilterComposer,
    $$ProductCategoriesTableOrderingComposer,
    $$ProductCategoriesTableAnnotationComposer,
    $$ProductCategoriesTableCreateCompanionBuilder,
    $$ProductCategoriesTableUpdateCompanionBuilder,
    (ProductCategory, $$ProductCategoriesTableReferences),
    ProductCategory,
    PrefetchHooks Function({bool productsRefs, bool supplierCategoriesRefs})> {
  $$ProductCategoriesTableTableManager(
      _$AppDatabase db, $ProductCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              ProductCategoriesCompanion(
            id: id,
            name: name,
            description: description,
            iconName: iconName,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              ProductCategoriesCompanion.insert(
            id: id,
            name: name,
            description: description,
            iconName: iconName,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productsRefs = false, supplierCategoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productsRefs) db.products,
                if (supplierCategoriesRefs) db.supplierCategories
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<ProductCategory, $ProductCategoriesTable,
                            Product>(
                        currentTable: table,
                        referencedTable: $$ProductCategoriesTableReferences
                            ._productsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductCategoriesTableReferences(db, table, p0)
                                .productsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items),
                  if (supplierCategoriesRefs)
                    await $_getPrefetchedData<ProductCategory,
                            $ProductCategoriesTable, SupplierCategory>(
                        currentTable: table,
                        referencedTable: $$ProductCategoriesTableReferences
                            ._supplierCategoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductCategoriesTableReferences(db, table, p0)
                                .supplierCategoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductCategoriesTable,
    ProductCategory,
    $$ProductCategoriesTableFilterComposer,
    $$ProductCategoriesTableOrderingComposer,
    $$ProductCategoriesTableAnnotationComposer,
    $$ProductCategoriesTableCreateCompanionBuilder,
    $$ProductCategoriesTableUpdateCompanionBuilder,
    (ProductCategory, $$ProductCategoriesTableReferences),
    ProductCategory,
    PrefetchHooks Function({bool productsRefs, bool supplierCategoriesRefs})>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String?> sku,
  required String description,
  required String unitMeasure,
  required String packagingType,
  required String attributesJson,
  Value<int?> categoryId,
  Value<String?> ownerId,
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
  Value<int?> categoryId,
  Value<String?> ownerId,
  Value<bool> isFromRede,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.productCategories.createAlias($_aliasNameGenerator(
          db.products.categoryId, db.productCategories.id));

  $$ProductCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager =
        $$ProductCategoriesTableTableManager($_db, $_db.productCategories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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

  ColumnFilters<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  $$ProductCategoriesTableFilterComposer get categoryId {
    final $$ProductCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.productCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.productCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  ColumnOrderings<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  $$ProductCategoriesTableOrderingComposer get categoryId {
    final $$ProductCategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.productCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductCategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.productCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<bool> get isFromRede => $composableBuilder(
      column: $table.isFromRede, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  $$ProductCategoriesTableAnnotationComposer get categoryId {
    final $$ProductCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.productCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProductCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.productCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

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
        {bool categoryId,
        bool productSuppliersRefs,
        bool quotationItemsRefs})> {
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
            Value<int?> categoryId = const Value.absent(),
            Value<String?> ownerId = const Value.absent(),
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
            categoryId: categoryId,
            ownerId: ownerId,
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
            Value<int?> categoryId = const Value.absent(),
            Value<String?> ownerId = const Value.absent(),
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
            categoryId: categoryId,
            ownerId: ownerId,
            isFromRede: isFromRede,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {categoryId = false,
              productSuppliersRefs = false,
              quotationItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productSuppliersRefs) db.productSuppliers,
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
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$ProductsTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$ProductsTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
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
        {bool categoryId, bool productSuppliersRefs, bool quotationItemsRefs})>;
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

  static $AppContactsTable _supplierIdTable(_$AppDatabase db) =>
      db.appContacts.createAlias($_aliasNameGenerator(
          db.productSuppliers.supplierId, db.appContacts.id));

  $$AppContactsTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$AppContactsTableTableManager($_db, $_db.appContacts)
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

  $$AppContactsTableFilterComposer get supplierId {
    final $$AppContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableFilterComposer(
              $db: $db,
              $table: $db.appContacts,
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

  $$AppContactsTableOrderingComposer get supplierId {
    final $$AppContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableOrderingComposer(
              $db: $db,
              $table: $db.appContacts,
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

  $$AppContactsTableAnnotationComposer get supplierId {
    final $$AppContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.appContacts,
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
typedef $$SupplierCategoriesTableCreateCompanionBuilder
    = SupplierCategoriesCompanion Function({
  Value<int> id,
  required int supplierId,
  required int categoryId,
});
typedef $$SupplierCategoriesTableUpdateCompanionBuilder
    = SupplierCategoriesCompanion Function({
  Value<int> id,
  Value<int> supplierId,
  Value<int> categoryId,
});

final class $$SupplierCategoriesTableReferences extends BaseReferences<
    _$AppDatabase, $SupplierCategoriesTable, SupplierCategory> {
  $$SupplierCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AppContactsTable _supplierIdTable(_$AppDatabase db) =>
      db.appContacts.createAlias($_aliasNameGenerator(
          db.supplierCategories.supplierId, db.appContacts.id));

  $$AppContactsTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$AppContactsTableTableManager($_db, $_db.appContacts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.productCategories.createAlias($_aliasNameGenerator(
          db.supplierCategories.categoryId, db.productCategories.id));

  $$ProductCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager =
        $$ProductCategoriesTableTableManager($_db, $_db.productCategories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SupplierCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierCategoriesTable> {
  $$SupplierCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$AppContactsTableFilterComposer get supplierId {
    final $$AppContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableFilterComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductCategoriesTableFilterComposer get categoryId {
    final $$ProductCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.productCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.productCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierCategoriesTable> {
  $$SupplierCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$AppContactsTableOrderingComposer get supplierId {
    final $$AppContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableOrderingComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductCategoriesTableOrderingComposer get categoryId {
    final $$ProductCategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.productCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductCategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.productCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierCategoriesTable> {
  $$SupplierCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$AppContactsTableAnnotationComposer get supplierId {
    final $$AppContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductCategoriesTableAnnotationComposer get categoryId {
    final $$ProductCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.productCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProductCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.productCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$SupplierCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierCategoriesTable,
    SupplierCategory,
    $$SupplierCategoriesTableFilterComposer,
    $$SupplierCategoriesTableOrderingComposer,
    $$SupplierCategoriesTableAnnotationComposer,
    $$SupplierCategoriesTableCreateCompanionBuilder,
    $$SupplierCategoriesTableUpdateCompanionBuilder,
    (SupplierCategory, $$SupplierCategoriesTableReferences),
    SupplierCategory,
    PrefetchHooks Function({bool supplierId, bool categoryId})> {
  $$SupplierCategoriesTableTableManager(
      _$AppDatabase db, $SupplierCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> supplierId = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
          }) =>
              SupplierCategoriesCompanion(
            id: id,
            supplierId: supplierId,
            categoryId: categoryId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int supplierId,
            required int categoryId,
          }) =>
              SupplierCategoriesCompanion.insert(
            id: id,
            supplierId: supplierId,
            categoryId: categoryId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SupplierCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({supplierId = false, categoryId = false}) {
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
                if (supplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.supplierId,
                    referencedTable: $$SupplierCategoriesTableReferences
                        ._supplierIdTable(db),
                    referencedColumn: $$SupplierCategoriesTableReferences
                        ._supplierIdTable(db)
                        .id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$SupplierCategoriesTableReferences
                        ._categoryIdTable(db),
                    referencedColumn: $$SupplierCategoriesTableReferences
                        ._categoryIdTable(db)
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

typedef $$SupplierCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SupplierCategoriesTable,
    SupplierCategory,
    $$SupplierCategoriesTableFilterComposer,
    $$SupplierCategoriesTableOrderingComposer,
    $$SupplierCategoriesTableAnnotationComposer,
    $$SupplierCategoriesTableCreateCompanionBuilder,
    $$SupplierCategoriesTableUpdateCompanionBuilder,
    (SupplierCategory, $$SupplierCategoriesTableReferences),
    SupplierCategory,
    PrefetchHooks Function({bool supplierId, bool categoryId})>;
typedef $$SupplierInteractionsTableCreateCompanionBuilder
    = SupplierInteractionsCompanion Function({
  Value<int> id,
  required String buyerOwnerId,
  required int supplierId,
  Value<int> rating,
  Value<String?> comment,
  Value<bool> isFavorite,
  Value<DateTime> lastUpdated,
});
typedef $$SupplierInteractionsTableUpdateCompanionBuilder
    = SupplierInteractionsCompanion Function({
  Value<int> id,
  Value<String> buyerOwnerId,
  Value<int> supplierId,
  Value<int> rating,
  Value<String?> comment,
  Value<bool> isFavorite,
  Value<DateTime> lastUpdated,
});

final class $$SupplierInteractionsTableReferences extends BaseReferences<
    _$AppDatabase, $SupplierInteractionsTable, SupplierInteraction> {
  $$SupplierInteractionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AppContactsTable _supplierIdTable(_$AppDatabase db) =>
      db.appContacts.createAlias($_aliasNameGenerator(
          db.supplierInteractions.supplierId, db.appContacts.id));

  $$AppContactsTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$AppContactsTableTableManager($_db, $_db.appContacts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SupplierInteractionsTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierInteractionsTable> {
  $$SupplierInteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get buyerOwnerId => $composableBuilder(
      column: $table.buyerOwnerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  $$AppContactsTableFilterComposer get supplierId {
    final $$AppContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableFilterComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierInteractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierInteractionsTable> {
  $$SupplierInteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get buyerOwnerId => $composableBuilder(
      column: $table.buyerOwnerId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  $$AppContactsTableOrderingComposer get supplierId {
    final $$AppContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableOrderingComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierInteractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierInteractionsTable> {
  $$SupplierInteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get buyerOwnerId => $composableBuilder(
      column: $table.buyerOwnerId, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  $$AppContactsTableAnnotationComposer get supplierId {
    final $$AppContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.appContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SupplierInteractionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierInteractionsTable,
    SupplierInteraction,
    $$SupplierInteractionsTableFilterComposer,
    $$SupplierInteractionsTableOrderingComposer,
    $$SupplierInteractionsTableAnnotationComposer,
    $$SupplierInteractionsTableCreateCompanionBuilder,
    $$SupplierInteractionsTableUpdateCompanionBuilder,
    (SupplierInteraction, $$SupplierInteractionsTableReferences),
    SupplierInteraction,
    PrefetchHooks Function({bool supplierId})> {
  $$SupplierInteractionsTableTableManager(
      _$AppDatabase db, $SupplierInteractionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierInteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierInteractionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierInteractionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> buyerOwnerId = const Value.absent(),
            Value<int> supplierId = const Value.absent(),
            Value<int> rating = const Value.absent(),
            Value<String?> comment = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              SupplierInteractionsCompanion(
            id: id,
            buyerOwnerId: buyerOwnerId,
            supplierId: supplierId,
            rating: rating,
            comment: comment,
            isFavorite: isFavorite,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String buyerOwnerId,
            required int supplierId,
            Value<int> rating = const Value.absent(),
            Value<String?> comment = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              SupplierInteractionsCompanion.insert(
            id: id,
            buyerOwnerId: buyerOwnerId,
            supplierId: supplierId,
            rating: rating,
            comment: comment,
            isFavorite: isFavorite,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SupplierInteractionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({supplierId = false}) {
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
                if (supplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.supplierId,
                    referencedTable: $$SupplierInteractionsTableReferences
                        ._supplierIdTable(db),
                    referencedColumn: $$SupplierInteractionsTableReferences
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

typedef $$SupplierInteractionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SupplierInteractionsTable,
        SupplierInteraction,
        $$SupplierInteractionsTableFilterComposer,
        $$SupplierInteractionsTableOrderingComposer,
        $$SupplierInteractionsTableAnnotationComposer,
        $$SupplierInteractionsTableCreateCompanionBuilder,
        $$SupplierInteractionsTableUpdateCompanionBuilder,
        (SupplierInteraction, $$SupplierInteractionsTableReferences),
        SupplierInteraction,
        PrefetchHooks Function({bool supplierId})>;
typedef $$QuotationsTableCreateCompanionBuilder = QuotationsCompanion Function({
  Value<int> id,
  required String buyerId,
  required DateTime date,
  required String status,
  required String templateMessage,
  Value<double> totalEconomy,
  Value<int?> winnerSupplierId,
  Value<int?> defaultPaymentTermDays,
  Value<String?> defaultPaymentCondition,
  Value<int?> defaultLeadTimeDays,
  Value<String?> defaultDeliveryType,
});
typedef $$QuotationsTableUpdateCompanionBuilder = QuotationsCompanion Function({
  Value<int> id,
  Value<String> buyerId,
  Value<DateTime> date,
  Value<String> status,
  Value<String> templateMessage,
  Value<double> totalEconomy,
  Value<int?> winnerSupplierId,
  Value<int?> defaultPaymentTermDays,
  Value<String?> defaultPaymentCondition,
  Value<int?> defaultLeadTimeDays,
  Value<String?> defaultDeliveryType,
});

final class $$QuotationsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationsTable, Quotation> {
  $$QuotationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AppProfilesTable _buyerIdTable(_$AppDatabase db) =>
      db.appProfiles.createAlias(
          $_aliasNameGenerator(db.quotations.buyerId, db.appProfiles.id));

  $$AppProfilesTableProcessedTableManager get buyerId {
    final $_column = $_itemColumn<String>('buyer_id')!;

    final manager = $$AppProfilesTableTableManager($_db, $_db.appProfiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buyerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AppContactsTable _winnerSupplierIdTable(_$AppDatabase db) =>
      db.appContacts.createAlias($_aliasNameGenerator(
          db.quotations.winnerSupplierId, db.appContacts.id));

  $$AppContactsTableProcessedTableManager? get winnerSupplierId {
    final $_column = $_itemColumn<int>('winner_supplier_id');
    if ($_column == null) return null;
    final manager = $$AppContactsTableTableManager($_db, $_db.appContacts)
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

  ColumnFilters<int> get defaultPaymentTermDays => $composableBuilder(
      column: $table.defaultPaymentTermDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get defaultPaymentCondition => $composableBuilder(
      column: $table.defaultPaymentCondition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultLeadTimeDays => $composableBuilder(
      column: $table.defaultLeadTimeDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get defaultDeliveryType => $composableBuilder(
      column: $table.defaultDeliveryType,
      builder: (column) => ColumnFilters(column));

  $$AppProfilesTableFilterComposer get buyerId {
    final $$AppProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.appProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppProfilesTableFilterComposer(
              $db: $db,
              $table: $db.appProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppContactsTableFilterComposer get winnerSupplierId {
    final $$AppContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableFilterComposer(
              $db: $db,
              $table: $db.appContacts,
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

  ColumnOrderings<int> get defaultPaymentTermDays => $composableBuilder(
      column: $table.defaultPaymentTermDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultPaymentCondition => $composableBuilder(
      column: $table.defaultPaymentCondition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultLeadTimeDays => $composableBuilder(
      column: $table.defaultLeadTimeDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultDeliveryType => $composableBuilder(
      column: $table.defaultDeliveryType,
      builder: (column) => ColumnOrderings(column));

  $$AppProfilesTableOrderingComposer get buyerId {
    final $$AppProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.appProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.appProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppContactsTableOrderingComposer get winnerSupplierId {
    final $$AppContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableOrderingComposer(
              $db: $db,
              $table: $db.appContacts,
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

  GeneratedColumn<int> get defaultPaymentTermDays => $composableBuilder(
      column: $table.defaultPaymentTermDays, builder: (column) => column);

  GeneratedColumn<String> get defaultPaymentCondition => $composableBuilder(
      column: $table.defaultPaymentCondition, builder: (column) => column);

  GeneratedColumn<int> get defaultLeadTimeDays => $composableBuilder(
      column: $table.defaultLeadTimeDays, builder: (column) => column);

  GeneratedColumn<String> get defaultDeliveryType => $composableBuilder(
      column: $table.defaultDeliveryType, builder: (column) => column);

  $$AppProfilesTableAnnotationComposer get buyerId {
    final $$AppProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.appProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.appProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppContactsTableAnnotationComposer get winnerSupplierId {
    final $$AppContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.winnerSupplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.appContacts,
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
            Value<String> buyerId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> templateMessage = const Value.absent(),
            Value<double> totalEconomy = const Value.absent(),
            Value<int?> winnerSupplierId = const Value.absent(),
            Value<int?> defaultPaymentTermDays = const Value.absent(),
            Value<String?> defaultPaymentCondition = const Value.absent(),
            Value<int?> defaultLeadTimeDays = const Value.absent(),
            Value<String?> defaultDeliveryType = const Value.absent(),
          }) =>
              QuotationsCompanion(
            id: id,
            buyerId: buyerId,
            date: date,
            status: status,
            templateMessage: templateMessage,
            totalEconomy: totalEconomy,
            winnerSupplierId: winnerSupplierId,
            defaultPaymentTermDays: defaultPaymentTermDays,
            defaultPaymentCondition: defaultPaymentCondition,
            defaultLeadTimeDays: defaultLeadTimeDays,
            defaultDeliveryType: defaultDeliveryType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String buyerId,
            required DateTime date,
            required String status,
            required String templateMessage,
            Value<double> totalEconomy = const Value.absent(),
            Value<int?> winnerSupplierId = const Value.absent(),
            Value<int?> defaultPaymentTermDays = const Value.absent(),
            Value<String?> defaultPaymentCondition = const Value.absent(),
            Value<int?> defaultLeadTimeDays = const Value.absent(),
            Value<String?> defaultDeliveryType = const Value.absent(),
          }) =>
              QuotationsCompanion.insert(
            id: id,
            buyerId: buyerId,
            date: date,
            status: status,
            templateMessage: templateMessage,
            totalEconomy: totalEconomy,
            winnerSupplierId: winnerSupplierId,
            defaultPaymentTermDays: defaultPaymentTermDays,
            defaultPaymentCondition: defaultPaymentCondition,
            defaultLeadTimeDays: defaultLeadTimeDays,
            defaultDeliveryType: defaultDeliveryType,
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

  static $AppContactsTable _supplierIdTable(_$AppDatabase db) =>
      db.appContacts.createAlias($_aliasNameGenerator(
          db.supplierResponses.supplierId, db.appContacts.id));

  $$AppContactsTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$AppContactsTableTableManager($_db, $_db.appContacts)
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

  $$AppContactsTableFilterComposer get supplierId {
    final $$AppContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableFilterComposer(
              $db: $db,
              $table: $db.appContacts,
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

  $$AppContactsTableOrderingComposer get supplierId {
    final $$AppContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableOrderingComposer(
              $db: $db,
              $table: $db.appContacts,
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

  $$AppContactsTableAnnotationComposer get supplierId {
    final $$AppContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.appContacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.appContacts,
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
typedef $$UsageQuotasTableCreateCompanionBuilder = UsageQuotasCompanion
    Function({
  Value<int> id,
  required String ownerId,
  required String quotaType,
  Value<int> usedCount,
  required int limitCount,
  Value<DateTime> lastResetAt,
});
typedef $$UsageQuotasTableUpdateCompanionBuilder = UsageQuotasCompanion
    Function({
  Value<int> id,
  Value<String> ownerId,
  Value<String> quotaType,
  Value<int> usedCount,
  Value<int> limitCount,
  Value<DateTime> lastResetAt,
});

class $$UsageQuotasTableFilterComposer
    extends Composer<_$AppDatabase, $UsageQuotasTable> {
  $$UsageQuotasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quotaType => $composableBuilder(
      column: $table.quotaType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usedCount => $composableBuilder(
      column: $table.usedCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get limitCount => $composableBuilder(
      column: $table.limitCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastResetAt => $composableBuilder(
      column: $table.lastResetAt, builder: (column) => ColumnFilters(column));
}

class $$UsageQuotasTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageQuotasTable> {
  $$UsageQuotasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quotaType => $composableBuilder(
      column: $table.quotaType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usedCount => $composableBuilder(
      column: $table.usedCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get limitCount => $composableBuilder(
      column: $table.limitCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastResetAt => $composableBuilder(
      column: $table.lastResetAt, builder: (column) => ColumnOrderings(column));
}

class $$UsageQuotasTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageQuotasTable> {
  $$UsageQuotasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get quotaType =>
      $composableBuilder(column: $table.quotaType, builder: (column) => column);

  GeneratedColumn<int> get usedCount =>
      $composableBuilder(column: $table.usedCount, builder: (column) => column);

  GeneratedColumn<int> get limitCount => $composableBuilder(
      column: $table.limitCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastResetAt => $composableBuilder(
      column: $table.lastResetAt, builder: (column) => column);
}

class $$UsageQuotasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsageQuotasTable,
    UsageQuota,
    $$UsageQuotasTableFilterComposer,
    $$UsageQuotasTableOrderingComposer,
    $$UsageQuotasTableAnnotationComposer,
    $$UsageQuotasTableCreateCompanionBuilder,
    $$UsageQuotasTableUpdateCompanionBuilder,
    (UsageQuota, BaseReferences<_$AppDatabase, $UsageQuotasTable, UsageQuota>),
    UsageQuota,
    PrefetchHooks Function()> {
  $$UsageQuotasTableTableManager(_$AppDatabase db, $UsageQuotasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageQuotasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageQuotasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageQuotasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> ownerId = const Value.absent(),
            Value<String> quotaType = const Value.absent(),
            Value<int> usedCount = const Value.absent(),
            Value<int> limitCount = const Value.absent(),
            Value<DateTime> lastResetAt = const Value.absent(),
          }) =>
              UsageQuotasCompanion(
            id: id,
            ownerId: ownerId,
            quotaType: quotaType,
            usedCount: usedCount,
            limitCount: limitCount,
            lastResetAt: lastResetAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String ownerId,
            required String quotaType,
            Value<int> usedCount = const Value.absent(),
            required int limitCount,
            Value<DateTime> lastResetAt = const Value.absent(),
          }) =>
              UsageQuotasCompanion.insert(
            id: id,
            ownerId: ownerId,
            quotaType: quotaType,
            usedCount: usedCount,
            limitCount: limitCount,
            lastResetAt: lastResetAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsageQuotasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsageQuotasTable,
    UsageQuota,
    $$UsageQuotasTableFilterComposer,
    $$UsageQuotasTableOrderingComposer,
    $$UsageQuotasTableAnnotationComposer,
    $$UsageQuotasTableCreateCompanionBuilder,
    $$UsageQuotasTableUpdateCompanionBuilder,
    (UsageQuota, BaseReferences<_$AppDatabase, $UsageQuotasTable, UsageQuota>),
    UsageQuota,
    PrefetchHooks Function()>;
typedef $$CategoryRequestsTableCreateCompanionBuilder
    = CategoryRequestsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required String requesterId,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$CategoryRequestsTableUpdateCompanionBuilder
    = CategoryRequestsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String> requesterId,
  Value<String> status,
  Value<DateTime> createdAt,
});

class $$CategoryRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryRequestsTable> {
  $$CategoryRequestsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get requesterId => $composableBuilder(
      column: $table.requesterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$CategoryRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryRequestsTable> {
  $$CategoryRequestsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requesterId => $composableBuilder(
      column: $table.requesterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoryRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryRequestsTable> {
  $$CategoryRequestsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get requesterId => $composableBuilder(
      column: $table.requesterId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoryRequestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryRequestsTable,
    CategoryRequest,
    $$CategoryRequestsTableFilterComposer,
    $$CategoryRequestsTableOrderingComposer,
    $$CategoryRequestsTableAnnotationComposer,
    $$CategoryRequestsTableCreateCompanionBuilder,
    $$CategoryRequestsTableUpdateCompanionBuilder,
    (
      CategoryRequest,
      BaseReferences<_$AppDatabase, $CategoryRequestsTable, CategoryRequest>
    ),
    CategoryRequest,
    PrefetchHooks Function()> {
  $$CategoryRequestsTableTableManager(
      _$AppDatabase db, $CategoryRequestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> requesterId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CategoryRequestsCompanion(
            id: id,
            name: name,
            description: description,
            requesterId: requesterId,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required String requesterId,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CategoryRequestsCompanion.insert(
            id: id,
            name: name,
            description: description,
            requesterId: requesterId,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryRequestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryRequestsTable,
    CategoryRequest,
    $$CategoryRequestsTableFilterComposer,
    $$CategoryRequestsTableOrderingComposer,
    $$CategoryRequestsTableAnnotationComposer,
    $$CategoryRequestsTableCreateCompanionBuilder,
    $$CategoryRequestsTableUpdateCompanionBuilder,
    (
      CategoryRequest,
      BaseReferences<_$AppDatabase, $CategoryRequestsTable, CategoryRequest>
    ),
    CategoryRequest,
    PrefetchHooks Function()>;
typedef $$UnitsOfMeasureTableCreateCompanionBuilder = UnitsOfMeasureCompanion
    Function({
  Value<int> id,
  required String code,
  required String name,
  Value<String?> description,
  Value<String?> category,
  Value<bool> isActive,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});
typedef $$UnitsOfMeasureTableUpdateCompanionBuilder = UnitsOfMeasureCompanion
    Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<String?> description,
  Value<String?> category,
  Value<bool> isActive,
  Value<bool> isSynced,
  Value<DateTime> lastUpdated,
});

class $$UnitsOfMeasureTableFilterComposer
    extends Composer<_$AppDatabase, $UnitsOfMeasureTable> {
  $$UnitsOfMeasureTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));
}

class $$UnitsOfMeasureTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsOfMeasureTable> {
  $$UnitsOfMeasureTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$UnitsOfMeasureTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsOfMeasureTable> {
  $$UnitsOfMeasureTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);
}

class $$UnitsOfMeasureTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UnitsOfMeasureTable,
    UnitsOfMeasureData,
    $$UnitsOfMeasureTableFilterComposer,
    $$UnitsOfMeasureTableOrderingComposer,
    $$UnitsOfMeasureTableAnnotationComposer,
    $$UnitsOfMeasureTableCreateCompanionBuilder,
    $$UnitsOfMeasureTableUpdateCompanionBuilder,
    (
      UnitsOfMeasureData,
      BaseReferences<_$AppDatabase, $UnitsOfMeasureTable, UnitsOfMeasureData>
    ),
    UnitsOfMeasureData,
    PrefetchHooks Function()> {
  $$UnitsOfMeasureTableTableManager(
      _$AppDatabase db, $UnitsOfMeasureTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsOfMeasureTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsOfMeasureTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsOfMeasureTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              UnitsOfMeasureCompanion(
            id: id,
            code: code,
            name: name,
            description: description,
            category: category,
            isActive: isActive,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              UnitsOfMeasureCompanion.insert(
            id: id,
            code: code,
            name: name,
            description: description,
            category: category,
            isActive: isActive,
            isSynced: isSynced,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UnitsOfMeasureTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UnitsOfMeasureTable,
    UnitsOfMeasureData,
    $$UnitsOfMeasureTableFilterComposer,
    $$UnitsOfMeasureTableOrderingComposer,
    $$UnitsOfMeasureTableAnnotationComposer,
    $$UnitsOfMeasureTableCreateCompanionBuilder,
    $$UnitsOfMeasureTableUpdateCompanionBuilder,
    (
      UnitsOfMeasureData,
      BaseReferences<_$AppDatabase, $UnitsOfMeasureTable, UnitsOfMeasureData>
    ),
    UnitsOfMeasureData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppProfilesTableTableManager get appProfiles =>
      $$AppProfilesTableTableManager(_db, _db.appProfiles);
  $$AppContactsTableTableManager get appContacts =>
      $$AppContactsTableTableManager(_db, _db.appContacts);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(_db, _db.productCategories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductSuppliersTableTableManager get productSuppliers =>
      $$ProductSuppliersTableTableManager(_db, _db.productSuppliers);
  $$SupplierCategoriesTableTableManager get supplierCategories =>
      $$SupplierCategoriesTableTableManager(_db, _db.supplierCategories);
  $$SupplierInteractionsTableTableManager get supplierInteractions =>
      $$SupplierInteractionsTableTableManager(_db, _db.supplierInteractions);
  $$QuotationsTableTableManager get quotations =>
      $$QuotationsTableTableManager(_db, _db.quotations);
  $$SupplierResponsesTableTableManager get supplierResponses =>
      $$SupplierResponsesTableTableManager(_db, _db.supplierResponses);
  $$QuotationItemsTableTableManager get quotationItems =>
      $$QuotationItemsTableTableManager(_db, _db.quotationItems);
  $$UsageQuotasTableTableManager get usageQuotas =>
      $$UsageQuotasTableTableManager(_db, _db.usageQuotas);
  $$CategoryRequestsTableTableManager get categoryRequests =>
      $$CategoryRequestsTableTableManager(_db, _db.categoryRequests);
  $$UnitsOfMeasureTableTableManager get unitsOfMeasure =>
      $$UnitsOfMeasureTableTableManager(_db, _db.unitsOfMeasure);
}

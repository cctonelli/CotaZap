import 'package:drift/drift.dart';

// Tabelas principais para o Drift (Offline-first)

class ProductCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
  TextColumn get iconName => text().nullable()();
  
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class AppProfiles extends Table {
  TextColumn get id => text()(); // UUID do Supabase
  TextColumn get name => text()();
  TextColumn get role => text()(); // 'buyer', 'supplier', 'admin'
  TextColumn get planType => text().withDefault(const Constant('free'))();
  TextColumn get avatarUrl => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

// Removida tabela Buyers para unificação na tabela AppContacts

class AppContacts extends Table {
  @override
  String get tableName => 'app_contacts';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tradeName => text()();
  TextColumn get whatsapp => text()();
  TextColumn get address => text().nullable()();
  TextColumn get observations => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  
  // v1.5: Planos e Limites
  TextColumn get ownerId => text().nullable()(); // Se for um fornecedor privado do comprador
  TextColumn get planType => text().nullable().withDefault(const Constant('free'))();
  IntColumn get productLimit => integer().nullable().withDefault(const Constant(15))();
  
  BoolColumn get isRedeCotazap => boolean().withDefault(const Constant(false))();
  IntColumn get priorityScore => integer().withDefault(const Constant(0))();
  BoolColumn get approved => boolean().withDefault(const Constant(true))();

  TextColumn get cnpjCpf => text().nullable()();
  TextColumn get contactName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get neighborhood => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  TextColumn get complement => text().nullable()();

  // Flags de Unificação v1.5
  BoolColumn get isBuyer => boolean().withDefault(const Constant(false))();
  BoolColumn get isSupplier => boolean().withDefault(const Constant(true))();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class SupplierInteractions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get buyerOwnerId => text()(); // UUID do Comprador logado
  IntColumn get supplierId => integer().references(AppContacts, #id)();
  IntColumn get rating => integer().withDefault(const Constant(0))(); // 1-5
  TextColumn get comment => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().nullable()();
  TextColumn get description => text()();
  TextColumn get unitMeasure => text()();
  TextColumn get packagingType => text()();
  TextColumn get attributesJson => text()(); // JSON para campos flexíveis
  
  IntColumn get categoryId => integer().nullable().references(ProductCategories, #id)();
  TextColumn get ownerId => text().nullable()(); // UUID de quem cadastrou
  BoolColumn get isFromRede => boolean().withDefault(const Constant(false))();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class ProductSuppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get supplierId => integer().references(AppContacts, #id)();
}

class SupplierCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().references(AppContacts, #id)();
  IntColumn get categoryId => integer().references(ProductCategories, #id)();
}

class Quotations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get buyerId => text().references(AppProfiles, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()(); // 'draft', 'sent', 'analyzing', 'finished'
  TextColumn get templateMessage => text()();
  
  // Campos de BI
  RealColumn get totalEconomy => real().withDefault(const Constant(0.0))();
  IntColumn get winnerSupplierId => integer().nullable().references(AppContacts, #id)();

  // Novos campos v1.4 (Padrões da Cotação)
  IntColumn get defaultPaymentTermDays => integer().nullable()(); // prazo_pagamento_dias (Padrão)
  TextColumn get defaultPaymentCondition => text().nullable()(); // condicao_pagamento (Padrão)
  IntColumn get defaultLeadTimeDays => integer().nullable()(); // prazo_entrega_dias (Padrão)
  TextColumn get defaultDeliveryType => text().nullable()(); // CIF/FOB (Padrão)
}

class QuotationItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quotationId => integer().references(Quotations, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  RealColumn get quantity => real()();
  RealColumn get requestedPrice => real().nullable()();
  TextColumn get deliveryType => text().nullable()();
  IntColumn get desiredLeadTime => integer().nullable()(); // prazo_desejado em dias
  
  // Novos campos v1.4
  IntColumn get paymentTermDays => integer().nullable()(); // prazo_pagamento_dias (0 = à vista)
  TextColumn get paymentCondition => text().nullable()(); // condicao_pagamento
  
  // Vínculo com a melhor resposta
  IntColumn get bestResponseId => integer().nullable().references(SupplierResponses, #id)();
}

class SupplierResponses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quotationItemId => integer().references(QuotationItems, #id)();
  IntColumn get supplierId => integer().references(AppContacts, #id)();
  TextColumn get receivedMessage => text().nullable()();
  RealColumn get pricingExtracted => real().nullable()();
  IntColumn get deliveryTimeDays => integer().nullable()(); // Prazo real prometido
  DateTimeColumn get responseDate => dateTime()();
  TextColumn get status => text()(); // 'replied', 'processing', 'ignored'
  BoolColumn get isSelected => boolean().withDefault(const Constant(false))();
  
  // Novos campos v1.4
  IntColumn get paymentTermDays => integer().nullable()(); // prazo_pagamento_dias
  TextColumn get paymentCondition => text().nullable()(); // condicao_pagamento
  RealColumn get earlyDiscountPercent => real().nullable()(); // desconto_antecipado_percent

  // Score calculado (0-100)
  IntColumn get calculatedScore => integer().withDefault(const Constant(0))();
}

class UsageQuotas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ownerId => text()();
  TextColumn get quotaType => text()(); // 'whatsapp_messages', 'quotations', 'products'
  IntColumn get usedCount => integer().withDefault(const Constant(0))();
  IntColumn get limitCount => integer()();
  DateTimeColumn get lastResetAt => dateTime().withDefault(currentDateAndTime)();
}

class CategoryRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get requesterId => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, approved, rejected
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UnitsOfMeasure extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();           // ex: "kg", "un"
  TextColumn get name => text()();                    // ex: "Quilograma", "Unidade"
  TextColumn get description => text().nullable()();
  TextColumn get category => text().nullable()();     // weight, count, volume, etc.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}


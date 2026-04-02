import 'package:drift/drift.dart';

// Tabelas principais para o Drift (Offline-first)

class Buyers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get company => text()();
  TextColumn get whatsapp => text()();
  TextColumn get email => text().nullable()();
  TextColumn get role => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tradeName => text()(); // nome_fantasia
  TextColumn get whatsapp => text()();
  TextColumn get address => text().nullable()();
  TextColumn get observations => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  
  // Novos campos Rede CotaZap
  BoolColumn get isSelfRegistered => boolean().withDefault(const Constant(false))();
  BoolColumn get isRedeCotazap => boolean().withDefault(const Constant(false))();
  IntColumn get priorityScore => integer().withDefault(const Constant(0))();
  BoolColumn get approved => boolean().withDefault(const Constant(true))();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().nullable()();
  TextColumn get description => text()();
  TextColumn get unitMeasure => text()(); // unidade_medida
  TextColumn get packagingType => text()(); // tipo_embalagem
  TextColumn get attributesJson => text()(); // JSON string for flex fields
  
  // Novo campo Rede CotaZap
  BoolColumn get isFromRede => boolean().withDefault(const Constant(false))();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}

class ProductSuppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
}

class Quotations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer().references(Buyers, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()(); // 'draft', 'sent', 'analyzing', 'finished'
  TextColumn get templateMessage => text()();
  
  // Campos de BI
  RealColumn get totalEconomy => real().withDefault(const Constant(0.0))();
  IntColumn get winnerSupplierId => integer().nullable().references(Suppliers, #id)();
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
  IntColumn get supplierId => integer().references(Suppliers, #id)();
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

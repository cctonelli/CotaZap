class WhatsAppHelpers {
  /// Substitui placeholders na mensagem pelo conteúdo real
  static String formatQuotationMessage({
    required String template,
    required String buyerName,
    required String company,
    required String supplierName,
    required String productList,
    required String deliveryType,
    required int leadTime,
    required int paymentTermDays,
    required String paymentCondition,
  }) {
    return template
        .replaceAll('{nome_comprador}', buyerName)
        .replaceAll('{empresa}', company)
        .replaceAll('{nome_fornecedor}', supplierName)
        .replaceAll('{lista_produtos}', productList)
        .replaceAll('{tipo_entrega}', deliveryType)
        .replaceAll('{frete}', deliveryType)
        .replaceAll('{prazo}', leadTime.toString())
        .replaceAll('{prazo_entrega}', leadTime.toString())
        .replaceAll('{prazo_pagamento}', paymentTermDays.toString())
        .replaceAll('{condicao_pagamento}', paymentCondition);
  }

  /// Formata a quantidade para remover .0 desnecessário
  static String formatQuantity(double quantity) {
    if (quantity == quantity.toInt()) {
      return quantity.toInt().toString();
    }
    return quantity.toString();
  }

  /// Gera um delay aleatório para mensagens (em milissegundos) entre 800 e 2500ms
  static int getMessageDelay() {
    return 800 + (DateTime.now().millisecond % 1700);
  }
}

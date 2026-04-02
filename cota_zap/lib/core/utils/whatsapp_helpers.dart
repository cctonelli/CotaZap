class WhatsAppHelpers {
  /// Substitui placeholders na mensagem pelo conteúdo real
  static String formatQuotationMessage({
    required String template,
    required String buyerName,
    required String company,
    required String supplierName,
    required String productDesc,
    required double qty,
    required String unit,
    required String packaging,
    required String attributes,
    required String deliveryType,
    required int leadTime,
  }) {
    return template
        .replaceAll('{nome_comprador}', buyerName)
        .replaceAll('{empresa}', company)
        .replaceAll('{nome_fornecedor}', supplierName)
        .replaceAll('{descricao_produto}', productDesc)
        .replaceAll('{quantidade}', qty.toString())
        .replaceAll('{unidade}', unit)
        .replaceAll('{tipo_embalagem}', packaging)
        .replaceAll('{atributos}', attributes)
        .replaceAll('{tipo_entrega}', deliveryType)
        .replaceAll('{prazo}', leadTime.toString());
  }

  /// Gera um delay aleatório para mensagens (em milissegundos) entre 800 e 2500ms
  static int getMessageDelay() {
    return 800 + (DateTime.now().millisecond % 1700);
  }
}

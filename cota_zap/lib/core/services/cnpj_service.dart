import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

class CnpjData {
  final String? tradeName; // nome_fantasia
  final String? legalName; // razao_social
  final String? email;
  final String? phone; // ddd + telefone
  final String? address; // logradouro + numero
  final String? neighborhood; // bairro
  final String? cep; // cep
  final String? complement; // complemento
  final String? city;
  final String? state;

  CnpjData({
    this.tradeName,
    this.legalName,
    this.email,
    this.phone,
    this.address,
    this.neighborhood,
    this.cep,
    this.complement,
    this.city,
    this.state,
  });

  factory CnpjData.fromBrasilApi(Map<String, dynamic> json) {
    final String logradouro = json['logradouro'] ?? '';
    final String numero = json['numero'] ?? '';
    final String bairro = json['bairro'] ?? '';
    final String municipio = json['municipio'] ?? '';
    final String uf = json['uf'] ?? '';
    final String cep = json['cep'] ?? '';
    final String? complement = json['complemento'];
    
    return CnpjData(
      tradeName: (json['nome_fantasia'] != null && json['nome_fantasia'].toString().isNotEmpty) 
          ? json['nome_fantasia'] 
          : json['razao_social'],
      legalName: json['razao_social'],
      email: json['email'],
      phone: (json['ddd_telefone_1'] != null && json['ddd_telefone_1'].toString().isNotEmpty) 
          ? '+55 ${json['ddd_telefone_1']}' 
          : null,
      address: logradouro.isNotEmpty ? '$logradouro, $numero' : '',
      neighborhood: bairro,
      cep: cep,
      complement: complement,
      city: municipio,
      state: uf,
    );
  }
}

final cnpjServiceProvider = Provider<CnpjService>((ref) {
  return CnpjService(ref.read(dioProvider));
});

class CnpjService {
  final Dio _dio;

  CnpjService(this._dio);

  /// Busca dados de uma empresa via BrasilAPI pelo CNPJ.
  Future<CnpjData?> fetchCnpjData(String cnpj) async {
    final String cleanCnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanCnpj.length != 14) {
      AppLogger.warning('CNPJ inválido enviado para busca: $cleanCnpj', tag: 'CNPJ');
      return null;
    }

    try {
      AppLogger.info('Buscando CNPJ: $cleanCnpj na BrasilAPI...', tag: 'CNPJ');
      
      // Tenta v1 primeiro
      final response = await _dio.get('https://brasilapi.com.br/api/cnpj/v1/$cleanCnpj');
      
      if (response.statusCode == 200) {
        return CnpjData.fromBrasilApi(response.data);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
         AppLogger.warning('CNPJ não encontrado na BrasilAPI: $cleanCnpj', tag: 'CNPJ');
      } else {
         AppLogger.error('Erro de rede ao buscar CNPJ: $cleanCnpj', error: e, tag: 'CNPJ');
      }
      return null;
    } catch (e) {
      AppLogger.error('Erro inesperado ao buscar dados do CNPJ: $cleanCnpj', error: e, tag: 'CNPJ');
      return null;
    }
  }
}

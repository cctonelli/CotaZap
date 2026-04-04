class Validators {
  static bool isValidCpf(String cpf) {
    String cleanCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCpf.length != 11) return false;
    if (RegExp(r'^(\d)\1+$').hasMatch(cleanCpf)) return false;

    List<int> digits = cleanCpf.split('').map(int.parse).toList();

    // 1º dígito
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += digits[i] * (10 - i);
    }
    int result = sum % 11;
    int d1 = result < 2 ? 0 : 11 - result;
    if (d1 != digits[9]) return false;

    // 2º dígito
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += digits[i] * (11 - i);
    }
    result = sum % 11;
    int d2 = result < 2 ? 0 : 11 - result;
    if (d2 != digits[10]) return false;

    return true;
  }

  static bool isValidCnpj(String cnpj) {
    String cleanCnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCnpj.length != 14) return false;
    if (RegExp(r'^(\d)\1+$').hasMatch(cleanCnpj)) return false;

    List<int> digits = cleanCnpj.split('').map(int.parse).toList();

    // 1º dígito
    int sum = 0;
    List<int> prod1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (int i = 0; i < 12; i++) {
      sum += digits[i] * prod1[i];
    }
    int result = sum % 11;
    int d1 = result < 2 ? 0 : 11 - result;
    if (d1 != digits[12]) return false;

    // 2º dígito
    sum = 0;
    List<int> prod2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (int i = 0; i < 13; i++) {
      sum += digits[i] * prod2[i];
    }
    result = sum % 11;
    int d2 = result < 2 ? 0 : 11 - result;
    if (d2 != digits[13]) return false;

    return true;
  }

  static bool isValidCpfCnpj(String value) {
    String clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.length == 11) return isValidCpf(clean);
    if (clean.length == 14) return isValidCnpj(clean);
    return false;
  }
}

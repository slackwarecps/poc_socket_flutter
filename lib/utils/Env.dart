class Env {
  static final Map<String, String> _keys = {
    'API_URL': const String.fromEnvironment('API_URL'),
    'SABOR': const String.fromEnvironment('SABOR')
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';

    // if (value.isEmpty) {
    //   throw Exception('Variável de ambiente não encontrada');
    // }

    return value;
  }

  static String get apiUrl => _getKey('API_URL');
  static String get sabor => _getKey('SABOR');
}

// ${Env.metodo}

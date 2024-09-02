import 'dart:io';

import 'parser_extention.dart';

class EnvManager {
  static Map<String, String> _map = {};

  static Future<Type> get<Type>({required String key}) async {
    if (_map.isEmpty) {
      await _load();
    }
    return _map[key]!.toType(Type);
  }

  static Future<void> _load() async {
    List<String> linhas = (await _readfile()).split("\n");
    _map = {for (var l in linhas) l.split("=")[0]: l.split("=")[1]};
  }

  static Future<String> _readfile() async {
    return await File('.env').readAsString();
  }
}
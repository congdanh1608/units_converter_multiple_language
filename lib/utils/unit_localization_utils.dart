import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

class UnitLocalizationUtils {
  static Map<String, dynamic> _data = {};
  static String currentLang = "en"; // default

  static bool _isLoaded = false;

  static Future<void> load(String langCode) async {
    currentLang = langCode;

    try {
      final jsonStr = await rootBundle.loadString(
          'packages/units_converter/assets/language/$langCode.json');
      _data = jsonDecode(jsonStr);
    } catch (e) {
      // fallback to en
      final jsonStr = await rootBundle
          .loadString('packages/units_converter/assets/language/en.json');
      _data = jsonDecode(jsonStr);
    }

    _isLoaded = true;
  }

  /// Auto-load default 'en' when used for the first time
  static Future<void> _ensureLoaded() async {
    if (_isLoaded) return;

    await load(currentLang);
  }

  static Future<String> getPropertyNameAsync(String key) async {
    await _ensureLoaded();
    return _data["propertynames"]?[key.toLowerCase()] ?? key;
  }

  static Future<String> getUnitNameAsync(String propertyKey, String unitKey) async {
    await _ensureLoaded();
    return _data["unitnames"]?[propertyKey.toLowerCase()]
    ?[unitKey.toLowerCase()] ??
        unitKey;
  }

  /// Optional sync version (will return key if not loaded yet)
  static String getPropertyName(String propertyName) {
    final propertyKey = propertyName
        .toLowerCase()
        .split(".")
        .lastOrNull;
    return _data["propertynames"]?[propertyKey] ?? propertyKey;
  }

  static String getUnitName(String propertyName, Unit unit) {
    final propertyKey = propertyName
        .toLowerCase()
        .split(".")
        .lastOrNull;
    final unitKey = unit.name
        .toString()
        .toLowerCase()
        .split(".")
        .lastOrNull;
    return _data["unitnames"]?[propertyKey]?[unitKey] ?? unitKey;
  }
}

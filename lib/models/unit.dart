import 'package:units_converter/utils/unit_localization_utils.dart';

class Unit {
  /// The value of the unit of measurement.
  double? value;

  /// The String representation of [value]. It could be changed according to
  /// other parameters of the property (e.g. `significantFigures`,
  /// `removeTrailingZeros` and `useScientificNotation`).
  String? stringValue;

  /// The name of the unit (e.g. LENGTH.meters, VOLUME.liters).
  // ignore: prefer_typing_uninitialized_variables
  dynamic name;

  /// The symbols that represent the unit (e.g. "m" stands for meters, "l"
  /// stands for liter).
  String? symbol;

  final String propertyKey;

  String? _displayNameCache;
  String get displayName {
    _displayNameCache ??= UnitLocalizationUtils.getUnitName(
      propertyKey,
      this,
    );
    return _displayNameCache!;
  }

  /// The class that defines a unit of measurement object.
  Unit(this.name, {
    this.symbol,
    this.value,
    this.stringValue,
    required this.propertyKey,
  });
}

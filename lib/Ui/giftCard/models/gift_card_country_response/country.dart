import 'dart:convert';

import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String? countryCode;
  final String? countryName;
  final String? countryFlag;

  const Country({this.countryCode, this.countryName, this.countryFlag});

  factory Country.fromMap(Map<String, dynamic> data) => Country(
        countryCode: data['country_code'] as String?,
        countryName: data['country_name'] as String?,
        countryFlag: data['country_flag'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'country_code': countryCode,
        'country_name': countryName,
        'country_flag': countryFlag,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Country].
  factory Country.fromJson(String data) {
    return Country.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Country] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [countryCode, countryName, countryFlag];
}

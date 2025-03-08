import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'country.dart';

class GiftCardCountryResponse extends Equatable {
  final bool? result;
  final List<Country>? countries;

  const GiftCardCountryResponse({this.result, this.countries});

  factory GiftCardCountryResponse.fromMap(Map<String, dynamic> data) {
    return GiftCardCountryResponse(
      result: data['result'] as bool?,
      countries: (data['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'result': result,
        'countries': countries?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GiftCardCountryResponse].
  factory GiftCardCountryResponse.fromJson(String data) {
    return GiftCardCountryResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GiftCardCountryResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [result, countries];
}

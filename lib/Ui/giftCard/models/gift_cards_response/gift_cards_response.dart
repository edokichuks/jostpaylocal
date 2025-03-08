import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'gift_card.dart';

class GiftCardsResponse extends Equatable {
  final bool? result;
  final List<GiftCard>? giftCards;

  const GiftCardsResponse({this.result, this.giftCards});

  factory GiftCardsResponse.fromMap(Map<String, dynamic> data) {
    return GiftCardsResponse(
      result: data['result'] as bool?,
      giftCards: (data['gift_cards'] as List<dynamic>?)
          ?.map((e) => GiftCard.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'result': result,
        'gift_cards': giftCards?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GiftCardsResponse].
  factory GiftCardsResponse.fromJson(String data) {
    return GiftCardsResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GiftCardsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  GiftCardsResponse copyWith({
    bool? result,
    List<GiftCard>? giftCards,
  }) {
    return GiftCardsResponse(
      result: result ?? this.result,
      giftCards: giftCards ?? this.giftCards,
    );
  }

  @override
  List<Object?> get props => [result, giftCards];
}

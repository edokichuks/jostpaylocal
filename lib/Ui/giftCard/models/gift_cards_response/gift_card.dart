import 'dart:convert';

import 'package:equatable/equatable.dart';

class GiftCard extends Equatable {
  final int? id;
  final String? name;
  final List<String>? image;

  const GiftCard({this.id, this.name, this.image});

  factory GiftCard.fromMap(Map<String, dynamic> data) => GiftCard(
        id: data['id'] as int?,
        name: data['name'] as String?,
        image: data['image'] as List<String>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GiftCard].
  factory GiftCard.fromJson(String data) {
    return GiftCard.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GiftCard] to a JSON string.
  String toJson() => json.encode(toMap());

  GiftCard copyWith({
    int? id,
    String? name,
    List<String>? image,
  }) {
    return GiftCard(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, name, image];
}

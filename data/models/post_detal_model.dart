import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../http_vars/uris.dart';

class PostDetalModel {
  final int id;
  final String title;
  final String phone;
  final List<String> pictures;

  PostDetalModel({
    required this.id,
    required this.title,
    required this.phone,
    required this.pictures,
  });

  PostDetalModel copyWith({
    int? id,
    String? title,
    String? phone,
    List<String>? pictures,
  }) {
    return PostDetalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      phone: phone ?? this.phone,
      pictures: pictures ?? this.pictures,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'phone': phone,
      'pictures': pictures,
    };
  }

  factory PostDetalModel.fromMap(Map<String, dynamic> map) {
    final List<String> imgs =
        map['images'].map((e) => "https://${Urls.domain}/${e["url"]}").toList().cast<String>();
    return PostDetalModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      phone: map['phone'] ?? '',
      // pictures: List<String>.from(map['images']["url"]),
      pictures: imgs,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDetalModel.fromJson(String source) =>
      PostDetalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostDetalModel(id: $id, title: $title, phone: $phone, pictures: $pictures)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostDetalModel &&
        other.id == id &&
        other.title == title &&
        other.phone == phone &&
        listEquals(other.pictures, pictures);
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ phone.hashCode ^ pictures.hashCode;
  }
}

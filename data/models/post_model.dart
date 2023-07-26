import 'dart:convert';

import '../source.dart/post_data.dart';

class PostModel {
  final int id;
  final String title;
  final String img;

  PostModel({
    required this.id,
    required this.title,
    required this.img,
  });

  PostModel copyWith({
    int? id,
    String? title,
    String? img,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'img': img,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      img: map['image'] != null
          ? "https://${Uris.domain}/${map['image']}"
          : '',
    );
  }

  String toJson() => json.encode(toMap());
  static List<PostModel> fromList(List list) =>
      list.map((e) => PostModel.fromMap(e)).toList();

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() => 'PostModel(id: $id, title: $title, img: $img)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.title == title &&
        other.img == img;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ img.hashCode;
}

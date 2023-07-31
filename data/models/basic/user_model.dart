import 'dart:convert';

class UserModel {
  final String name;
  final String pass;
  final String phone;

  UserModel({
    this.name = "",
    required this.pass,
    this.phone = "",
  });

  UserModel copyWith({
    String? name,
    String? pass,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      pass: pass ?? this.pass,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': pass,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      pass: map['pass'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, pass: $pass, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.pass == pass &&
        other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ pass.hashCode ^ phone.hashCode;
}

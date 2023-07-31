import 'dart:convert';

class ResponseModel {
  final bool status;
  final String message;
  final String? token;
  ResponseModel({
    required this.status,
    required this.message,
    this.token,
  });

  ResponseModel copyWith({
    bool? status,
    String? message,
    String? token,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'token': token,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      token: map["data"]!=null?map['data']["token"] :null ,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseModel(status: $status, message: $message, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResponseModel &&
      other.status == status &&
      other.message == message &&
      other.token == token;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ token.hashCode;
}

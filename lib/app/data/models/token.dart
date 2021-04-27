import 'package:flutter_architecture/app/data/models/assets.dart';

class Token extends Entity {
  DateTime? expiresAt;
  String? token;

  int get expirationSeconds =>
      (expiresAt ?? DateTime.now()).difference(DateTime.now()).inSeconds;

  static DateTime expirationDate(int seconds) =>
      DateTime.now().add(Duration(seconds: seconds));

  Token({this.expiresAt, this.token});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...addIfNotNull('expiresAt', expirationSeconds),
      ...addIfNotNull('token', token),
    };
  }

  @override
  Token fromJson(dynamic json) {
    if (json != null) {
      parametersExist(json, ['expiresAt', 'token']);
      final expired = convertToInt(json['expiresAt']) ?? 0;

      return Token(
        expiresAt: expirationDate(expired),
        token: json['token'],
      );
    }
    return Token();
  }

  @override
  createMock() => Token(
        expiresAt: DateTime.parse('2021-09-24T03:57:08.568Z'),
        token:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
      );

  @override
  List<Token> fromArray(json) => [];
}

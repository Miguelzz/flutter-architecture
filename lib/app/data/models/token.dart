import 'package:flutter_architecture/app/data/models/assets.dart';

class Token extends Entity {
  final DateTime? expiresAt;
  final String? token;

  Token({this.expiresAt, this.token});

  @override
  Map<String, dynamic> toJson() {
    final seconds =
        (expiresAt ?? DateTime.now()).difference(DateTime.now()).inSeconds;

    return {
      ...addIfNotNull('expiresAt', seconds),
      ...addIfNotNull('token', token),
    };
  }

  @override
  Token? fromJson(dynamic json) {
    if (json != null) {
      parametersExist(json, ['token', 'expiresAt']);
      DateTime now = new DateTime.now();
      final expired = convertToInt(json['expiresAt']) ?? 0;

      return Token(
        expiresAt: now.add(Duration(seconds: expired)),
        token: json['token'],
      );
    }
    return null;
  }

  @override
  createMock() => Token(
        expiresAt: DateTime.parse('2021-09-24T03:57:08.568Z'),
        token:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
      );
}
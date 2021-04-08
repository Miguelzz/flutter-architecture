import 'package:group/app/data/models/assets.dart';

class RequestToken extends Entity {
  final DateTime? expiresAt;
  final String? token;

  RequestToken({this.expiresAt, this.token});

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('expiresAt', expiresAt),
        ...addIfNotNull('token', token),
      };
  @override
  RequestToken? fromJson(dynamic json) {
    if (json != null) {
      try {
        final valid = json['expiresAt'] ?? json['requestToken'];
        if (valid == null) throw '';
        return RequestToken(
          expiresAt: DateTime.parse(json['expiresAt']),
          token: json['token'],
        );
      } catch (e) {
        print('ERROR VALIDATING JSON');
      }
    }
    return null;
  }

  @override
  createMock() => RequestToken(
        expiresAt: DateTime.parse('2021-09-24T03:57:08.568Z'),
        token:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
      );
}

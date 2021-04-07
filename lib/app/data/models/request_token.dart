import 'package:group/app/data/models/assets.dart';

class RequestToken extends Entity {
  final bool? success;
  final DateTime? expiresAt;
  final String? requestToken;

  RequestToken({this.success, this.expiresAt, this.requestToken});

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('success', success),
        ...addIfNotNull('expiresAt', expiresAt),
        ...addIfNotNull('requestToken', requestToken),
      };
  @override
  RequestToken? fromJson(dynamic json) {
    if (json != null) {
      try {
        final valid =
            json['success'] ?? json['expiresAt'] ?? json['requestToken'];
        if (valid == null) throw '';
        return RequestToken(
          success: json['success'],
          expiresAt: DateTime.parse(json['expiresAt']),
          requestToken: json['requestToken'],
        );
      } catch (e) {
        print('ERROR VALIDATING JSON');
      }
    }
    return null;
  }
}

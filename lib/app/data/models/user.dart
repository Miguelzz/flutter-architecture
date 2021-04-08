import 'package:group/app/data/models/assets.dart';

class User extends Entity {
  //final num? age;
  final String? id, token, prefix, phone;

  User({this.id, this.token, this.prefix, this.phone});

  @override
  User createMock() => User(id: '15', prefix: '57', phone: '3016992677');

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('token', token),
        ...addIfNotNull('prefix', prefix),
        ...addIfNotNull('phone', phone),
      };
  @override
  User? fromJson(dynamic json) {
    if (json != null) {
      try {
        final valid =
            json['id'] ?? json['token'] ?? json['prefix'] ?? json['phone'];
        if (valid == null) throw '';
        return User(
          id: json['id'],
          token: json['token'],
          prefix: json['prefix'],
          phone: json['phone'],
        );
      } catch (e) {
        print('ERROR VALIDATING JSON');
      }
    }
    return null;
  }
}

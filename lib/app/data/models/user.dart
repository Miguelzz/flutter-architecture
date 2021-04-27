import 'package:flutter_architecture/app/data/models/assets.dart';

class User extends Entity {
  String? id, prefix, phone, names, surnames, email, address, photo;
  DateTime? birthday;

  User(
      {this.id,
      this.prefix,
      this.phone,
      this.names,
      this.surnames,
      this.email,
      this.address,
      this.photo,
      this.birthday});

  @override
  User createMock() => User(
      id: '15',
      prefix: '57',
      phone: '3016992677',
      names: '',
      surnames: '',
      email: '',
      address: '',
      photo: '',
      birthday: DateTime.now());

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('prefix', prefix),
        ...addIfNotNull('phone', phone),
        ...addIfNotNull('names', names),
        ...addIfNotNull('surnames', surnames),
        ...addIfNotNull('email', email),
        ...addIfNotNull('address', address),
        ...addIfNotNull('photo', photo),
        ...addIfNotNull('birthday', birthday.toString()),
      };
  @override
  User fromJson(dynamic json) {
    if (json != null) {
      parametersExist(json, [
        'id',
        'prefix',
        'phone',
        'names',
        'surnames',
        'email',
        'address',
        'photo',
        'birthday'
      ]);

      return User(
        id: json['id'],
        prefix: json['prefix'],
        phone: json['phone'],
        names: json['names'],
        surnames: json['surnames'],
        email: json['email'],
        address: json['address'],
        photo: json['photo'],
        birthday: convertToDate(json['birthday']),
      );
    }
    return User();
  }

  @override
  List<User> fromArray(json) => [];
}

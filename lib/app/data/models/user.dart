import 'package:group/app/data/models/assets.dart';

class User extends Entity {
  final num? age, id;
  final String? name;
  final bool? completed;

  User({this.age, this.name, this.completed, this.id});

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('userId', age),
        ...addIfNotNull('name', name),
        ...addIfNotNull('completed', completed),
      };
  @override
  User? fromJson(dynamic json) {
    if (json != null) {
      try {
        final valid =
            json['id'] ?? json['age'] ?? json['name'] ?? json['completed'];
        if (valid == null) throw '';
        return User(
          id: json['id'],
          age: json['age'],
          name: json['name'],
          completed: json['completed'],
        );
      } catch (e) {
        print('ERROR VALIDATING JSON');
      }
    }
    return null;
  }
}

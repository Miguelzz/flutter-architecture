import 'package:myArchitecture/models/assets.dart';

class User extends Validator implements Mapper {
  final int? age, id;
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
  User fromJson(dynamic json) => User(
        id: json['id'],
        age: json['age'],
        name: json['name'],
        completed: json['completed'],
      );
}

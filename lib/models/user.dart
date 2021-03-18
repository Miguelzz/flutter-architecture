import 'package:myArchitecture/models/validator.dart';

class User extends Validator {
  final int? userId, id;
  final String? title;
  final bool? completed;

  User({this.userId, this.title, this.completed, this.id});

  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('userId', userId),
        ...addIfNotNull('title', title),
        ...addIfNotNull('completed', completed),
      };

  static User fromJson(dynamic json) => User(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );
}

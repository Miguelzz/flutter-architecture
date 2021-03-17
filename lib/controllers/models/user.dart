class User {
  final int? userId, id;
  final String? title;
  final bool? completed;

  User({this.userId, this.title, this.completed, this.id});

  Map<String, dynamic> toJson() => {
        ...(id != null ? {'id': id} : {}),
        ...(userId != null ? {'userId': userId} : {}),
        ...(title != null ? {'title': title} : {}),
        ...(completed != null ? {'completed': completed} : {})
      };

  static User fromJson(dynamic json) => User(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );
}

import 'package:flutter_architecture/app/data/models/assets.dart';

class Demo extends Entity {
  String? id, title, image;

  Demo({this.id, this.title, this.image});

  @override
  Demo createMock() => Demo(
        id: '15',
        title: '57',
        image: '3016992677',
      );

  List<Demo> fromArray(dynamic array) =>
      array.map<Demo>((x) => fromJson(x)).toList();

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('title', title),
        ...addIfNotNull('image', image),
      };
  @override
  Demo fromJson(dynamic json) {
    if (json != null) {
      parametersExist(json, [
        'id',
        'title',
        'image',
      ]);

      return Demo(
        id: json['id'],
        title: json['title'],
        image: json['image'],
      );
    }
    return Demo();
  }
}

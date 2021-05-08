import 'package:flutter_architecture/app/data/models/assets.dart';
import 'package:flutter_architecture/app/data/models/paginate.dart';

class Image extends Entity<Image> {
  String? publicId, url;
  Image({this.publicId, this.url});

  @override
  Image createMock() {
    return Image();
  }

  @override
  Image fromJson(json) => Image(
        publicId: json["public_id"],
        url: json["secure_url"],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('public_id', publicId),
        ...addIfNotNull('secure_url', url)
      };
}

class Demo extends Entity<Demo> {
  String? id, title, description;
  List<Image>? images;

  Demo({
    this.id,
    this.title,
    this.images,
    this.description,
  });

  @override
  Demo createMock() => Demo(
        id: '15',
        title: 'titulo',
        images: [],
      );

  List<Demo> fromArray(dynamic array) =>
      array.map<Demo>((x) => fromJson(x)).toList();

  @override
  Map<String, dynamic> toJson() => {
        ...addIfNotNull('id', id),
        ...addIfNotNull('title', title),
        ...addIfNotNull('images', images?.map((e) => e.toJson())),
        ...addIfNotNull('description', description),
      };

  @override
  Demo fromJson(dynamic json) {
    if (json != null) {
      parametersExist(json, [
        'id',
        'title',
        'image',
        'description',
      ]);

      return Demo(
        id: json['id'],
        title: json['title'],
        images: json['image']?.map<Image>((x) => Image().fromJson(x)).toList(),
        description: json['description'],
      );
    }
    return Demo();
  }
}

class DemoPaginate extends Paginate<Demo> {}

// final DemoPaginate asd = DemoPaginate();

// final mmm = asd.docs?.map((x) => x.title);

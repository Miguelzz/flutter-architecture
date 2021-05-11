import 'package:flutter_architecture/app/data/models/assets.dart';
import 'package:flutter_architecture/app/data/models/paginate.dart';

class ImageCloudinary extends Entity<ImageCloudinary> {
  String? publicId, url;
  ImageCloudinary({this.publicId, this.url});

  @override
  ImageCloudinary createMock() {
    return ImageCloudinary();
  }

  @override
  ImageCloudinary fromJson(json) => ImageCloudinary(
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
  List<ImageCloudinary>? images;

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
        'images',
        'description',
      ]);

      return Demo(
        id: json['id'],
        title: json['title'],
        images: json['images']
            ?.map<ImageCloudinary>((x) => ImageCloudinary().fromJson(x))
            .toList(),
        description: json['description'],
      );
    }
    return Demo();
  }
}

class DemoPaginate extends Paginate<Demo> {}

// final DemoPaginate asd = DemoPaginate();

// final mmm = asd.docs?.map((x) => x.title);

import 'package:group/models/user.dart';

class UrlCache<T> {
  final String url;
  final String base;
  final String? cache;
  final T? mock;

  UrlCache({required this.url, required this.base, this.cache, this.mock});

  String urlFull() => '$base$url';
}

class ListServices {
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  // static final _baseDomain2 = '';
  // static final _baseDomain3 = '';

  static final urlUser = (String url) => UrlCache<User>(
        base: jsonplaceholder,
        url: url,
        cache: 'user',
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      );
}

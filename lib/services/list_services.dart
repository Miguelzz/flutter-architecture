import 'package:group/models/user.dart';

class UrlCache<T> {
  final String url;
  final String base;
  final String? cache;
  final T? mock;

  UrlCache({required this.url, required this.base, this.cache, this.mock});
}

class ListServices {
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static final local = 'http://172.30.240.1:4000';
  // static final _baseDomain3 = '';

  static final urlUser = (String url) => UrlCache<User>(
        base: jsonplaceholder,
        url: url,
        cache: 'user',
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      );

  static final login = (String url) => UrlCache<User>(
        base: jsonplaceholder,
        url: url,
        cache: 'user',
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      );
}

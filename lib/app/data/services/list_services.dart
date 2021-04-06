import 'package:group/app/data/models/user.dart';

enum TypeCache { PERSISTENT, TEMPORARY, INTERNET }

class UrlCache<T> {
  final String url;
  final String base;
  final TypeCache cache;
  final T? mock;

  UrlCache(
      {required this.url, required this.base, required this.cache, this.mock});
}

class ListServices {
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static final local = 'http://172.30.240.1:4000';
  // static final _baseDomain3 = '';

  static final urlUser = (String url) => UrlCache<User>(
        base: jsonplaceholder,
        url: url,
        cache: TypeCache.TEMPORARY,
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      );

  static final login = (String url) => UrlCache<String>(
        base: jsonplaceholder,
        url: url,
        cache: TypeCache.INTERNET,
        mock:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
      );
}

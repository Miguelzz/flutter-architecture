abstract class MethodsApp {
  T? methodMapType<T>(dynamic value) {
    try {
      // print(T.toString());
      if (T.toString() == 'int' || T.toString() == 'int?') {
        if (value is String) return int.parse(value) as T;
        if (value is int) return value as T;
      } else if (T.toString() == 'bool' || T.toString() == 'bool?') {
        if (value is String) return (value.toLowerCase() == 'true') as T;
        if (value is bool) return value as T;
      } else if (T.toString() == 'num' || T.toString() == 'num?') {
        if (value is String) return num.parse(value) as T;
        if (value is num) return value as T;
      } else if (T.toString() == 'double' || T.toString() == 'double?') {
        if (value is String) return double.parse(value) as T;
        if (value is double) return value as T;
      } else if (T.toString() == 'String' || T.toString() == 'String?') {
        if (value is String) return value as T;
      } else if (T.toString() == 'DateTime' || T.toString() == 'DateTime?') {
        if (value is String) return DateTime.parse(value) as T;
        if (value is DateTime) return value as T;
      }
      return null;
    } catch (e) {
      throw '${T.toString()} no mappable!';
    }
  }

  void parametersExist(dynamic json, List<String> params) {
    try {
      if (json.keys.length == 0) return;
    } catch (e) {
      final isExist = params.any((x) {
        try {
          return json[x] != null;
        } catch (e) {
          return false;
        }
      });

      if (!isExist) throw 'ERROR VALIDATING JSON';
    }
  }

  Map<String, dynamic> addIfNotNull(String key, dynamic? variable) {
    if (variable != null && variable != '') {
      return {'$key': variable};
    } else {
      return {};
    }
  }
}

abstract class Entity<T> extends MethodsApp {
  T? mapType<T>(dynamic value) => methodMapType<T?>(value);

  T createMock();
  Map<String, dynamic> toJson();
  T fromJson(dynamic json);
}

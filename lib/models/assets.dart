abstract class Entity<T> {
  bool ok<T>(T obj) => obj != null;
  bool nul<T>(T obj) => obj == null;

  Map<String, dynamic> addIfNotNull(String key, dynamic? variable) {
    if (variable != null) {
      return {'$key': variable};
    } else {
      return {};
    }
  }

  num? convertToNumber(String? value) {
    try {
      if (value == null) {
        throw 'number null';
      }
      return num.parse(value);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson();
  T? fromJson(dynamic json);
}

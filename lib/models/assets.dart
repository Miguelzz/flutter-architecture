abstract class Validator {
  Map<String, dynamic> addIfNotNull(String key, dynamic? variable) {
    if (variable != null) {
      return {'$key': variable};
    } else {
      return {};
    }
  }
}

abstract class Mapper<T> {
  Map<String, dynamic> toJson();
  T fromJson(dynamic json);
}

abstract class Entity<T> {
  bool ok<T>(T obj) => obj != null;
  bool nul<T>(T obj) => obj == null;

  Map<String, dynamic> addIfNotNull(String key, dynamic? variable) {
    if (variable != null && variable != '') {
      return {'$key': variable};
    } else {
      return {};
    }
  }

  num? convertToNumber(dynamic? value) {
    try {
      if (value == null) {
        throw 'number null';
      } else if (value is String) {
        return num.parse(value);
      } else if (value is num) {
        return value;
      }
    } catch (e) {
      return null;
    }
  }

  DateTime? convertToDate(dynamic? value) {
    try {
      if (value == null) {
        throw 'date null';
      } else if (value is String) {
        return DateTime.parse(value);
      } else if (value is DateTime) {
        return value;
      }
    } catch (e) {
      return null;
    }
  }

  int? convertToInt(dynamic? value) {
    try {
      if (value == null) {
        throw 'number null';
      } else if (value is String) {
        return int.parse(value);
      } else if (value is int) {
        return value;
      }
    } catch (e) {
      return null;
    }
  }

  // void parametersExist(dynamic json) {
  //   try {
  //     final isExist = json.keys.toList().any((x) {
  //       try {
  //         return json[x] != null;
  //       } catch (e) {
  //         return false;
  //       }
  //     });
  //     if (!isExist) throw '';
  //   } catch (e) {
  //     print(e);
  //     throw 'ERROR VALIDATING JSON';
  //   }
  // }
  //
  void parametersExist(dynamic json, List<String> params) {
    final isExist = params.any((x) {
      try {
        return json[x] != null;
      } catch (e) {
        return false;
      }
    });

    if (!isExist) throw 'ERROR VALIDATING JSON';
  }

  T createMock();
  Map<String, dynamic> toJson();
  T? fromJson(dynamic json);
}

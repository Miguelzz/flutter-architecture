import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';

final Map<String, dynamic Function()> factories = {
  'Demo': () => Demo(),
  'User': () => User(),
  'Token': () => Token(),
};

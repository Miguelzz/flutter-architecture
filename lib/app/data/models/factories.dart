import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

final Map<String, dynamic Function()> factories = {
  'User': () => User(),
  'Token': () => Token(),
};

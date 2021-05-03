import 'package:flutter_architecture/app/data/models/assets.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';

final Map<String, Entity Function()> factories = {
  'Demo': () => Demo(),
  'DemoPaginate': () => DemoPaginate(),
  'User': () => User(),
  'Token': () => Token(),
};

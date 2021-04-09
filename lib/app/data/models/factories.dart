import 'package:group/app/data/models/token.dart';
import 'package:group/app/data/models/user.dart';

final Map<String, dynamic Function()> factories = {
  'User': () => User(),
  'RequestToken': () => Token(),
};

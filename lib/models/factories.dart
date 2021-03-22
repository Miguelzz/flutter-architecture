import 'package:group/models/assets.dart';
import 'package:group/models/user.dart';

final Map<String, Entity Function()> factories = {
  'User': () => User(),
};

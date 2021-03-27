import 'package:group/app/data/models/assets.dart';
import 'package:group/app/data/models/user.dart';

final Map<String, Entity Function()> factories = {
  'User': () => User(),
};

import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Token token = EventsApp.token;
  User user = EventsApp.user;

  String countdown = '';

  @override
  void onInit() async {
    super.onInit();

    EventsApp.token$.listen((token) {
      this.token = token;
      final date = token.convertToDate(token.expiresAt) ?? DateTime.now();

      final duration = date.difference(DateTime.now());
      final days = duration.inDays;
      final hours = duration.inHours - (duration.inDays * 24);
      final minutes = duration.inMinutes - (duration.inHours * 60);
      final seconds = duration.inSeconds - (duration.inMinutes * 60);

      countdown =
          '$days dias | $hours horas | $minutes minutos | $seconds segundos';

      update();
    });

    EventsApp.user$.listen((token) {
      this.user = user;
      update();
    });

    print('HOME');
  }
}

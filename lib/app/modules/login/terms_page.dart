import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class TermsPage extends StatelessWidget {
  final LoginController controller = Get.find();
  final RouteController route = Get.find();
  final phone = TextEditingController();
  final bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FullScreen(
        safeArea: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Box(
                child: Text(
              Constants.NAME_APP,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
            Container(
              height: size.height * 0.5,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Image.asset(Constants.LOGO_APP),
              ),
            ),
            Column(
              children: [
                Box(
                    margin: EdgeInsets.only(bottom: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            style: TextStyle(color: Colors.black),
                            text:
                                'Toca "Aceptar y continuar" para aceptar los '),
                        TextSpan(
                            style: TextStyle(color: PRIMARY_COLOR),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => route.nexReadTerms(),
                            text:
                                'Terminos de servicio y politica de privacidad de ${Constants.NAME_APP}'),
                      ]),
                    )),
                ButtonLoading(
                  onPressed: () => route.nexNumber(),
                  child: Text('ACEPTAR Y CONTINUAR'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

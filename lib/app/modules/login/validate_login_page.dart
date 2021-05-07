import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/global_widgets/box.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fonts.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateLoginPage extends StatelessWidget {
  final RouteController route = Get.find();
  final code = TextEditingController()..text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (_) {
        return FullScreen(
          safeArea: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  H5(
                    'Verificar +${_.codePhone} ${_.phone}',
                    textAlign: TextAlign.center,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(height: 20),
                  P(
                    'Se te envió un mensaje a tu numero de WhatsApp. Revisa tus mensajes.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Box(
                  maxWidth: 200,
                  child: Column(
                    children: [
                      H5(
                        'Código',
                        textAlign: TextAlign.center,
                        color: PRIMARY_COLOR,
                      ),
                      PinFieldAutoFill(
                        codeLength: 4,
                        decoration: UnderlineDecoration(
                          textStyle: Theme.of(context).textTheme.headline6,
                          colorBuilder:
                              FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        ),
                        currentCode: '',
                        onCodeChanged: (code) async {
                          if (code?.length == 4) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _.validateCode(code!);
                          }
                        },
                      ),
                    ],
                  )),
              Text(Constants.NAME_APP)
            ],
          ),
        );
      }),
    );
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/global_widgets/button.dart';
import 'package:flutter_architecture/app/modules/global_widgets/box.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fonts.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:flutter_architecture/app/modules/global_widgets/input.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class NumberPage extends StatelessWidget {
  final RouteController route = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                    'Verifica tu número ',
                    textAlign: TextAlign.center,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(height: 20),
                  P('${Constants.NAME_APP} te enviará un SMS para verificar tu número de teléfono. Introduce tu código de país y número de teléfono.',
                      textAlign: TextAlign.center),
                ],
              ),
              Box(
                maxWidth: 300,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          countryListTheme: CountryListThemeData(),
                          context: context,
                          showPhoneCode: true,
                          onSelect: _.changeCountry,
                        );
                      },
                      child: Input(
                        ignoring: true,
                        labelText: _.country,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(children: [
                      Input(
                        width: size.width * 0.15,
                        labelText: '+${_.codePhone}',
                        ignoring: true,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Input(
                        onChanged: (value) {
                          _.changePhone(value);
                        },
                        keyboardType: TextInputType.number,
                        labelText: 'Celular',
                        textAlign: TextAlign.center,
                      )),
                    ])
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonLoadingFullScreen(
                        title: 'Espera un momento!',
                        onPressed:
                            _.phone.length >= 7 ? _.validateNumber : null,
                        after: route.nexValidateCode,
                        child: Text('txt_f590ead4'.tr),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Te llegara un mensaje al numero de whatsAap con el código de verificación.',
                    textAlign: TextAlign.center,
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}

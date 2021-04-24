import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/fonts.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
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
                  H4(
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
                          onSelect: (country) {
                            _.changeCountry(country.name);
                            _.changeCodePhone(country.phoneCode);
                          },
                        );
                      },
                      child: Input(
                        enabled: false,
                        labelText: _.country,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(children: [
                      Input(
                        width: size.width * 0.15,
                        labelText: '+${_.codePhone}',
                        enabled: false,
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
                      ButtonLoading(
                        onPressed: _.phone.length > 4
                            ? () async {
                                await _.validateNumber();
                              }
                            : null,
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

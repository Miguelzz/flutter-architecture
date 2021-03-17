import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(height: 20),
          //Obx(() => Text('Bienvenido ${service.connection.value}')),
          OutlinedButton(
            onPressed: () {
              // final api = Services.instance;

              // api.getUsers().then((value) {
              //   print('*****************************');
              //   print(value);
              //   print('*****************************');
              // });
            },
            child: Text("OUTLINED BUTTON"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

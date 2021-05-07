import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:get/get.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Container(
                color: Colors.blue, child: Text('Container (display: inline)')),
            Align(child: Text('Align (display: block)')),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola 1'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola 3'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola'),
            Text('hola 2'),
          ],
        ),
      ),
    );
  }
}

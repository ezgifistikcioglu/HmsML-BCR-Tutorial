import 'package:flutter/material.dart';
import 'package:flutter_ml_bcr_tutorial/src/home_page.dart';

import 'src/constant/app_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ApplicationConstants.mTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ApplicationConstants.title),
    );
  }
}

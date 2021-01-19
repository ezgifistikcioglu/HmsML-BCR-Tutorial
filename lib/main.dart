import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_ml_bcr_tutorial/ResultWidget.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_analyzer.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_settings.dart';
import 'package:huawei_ml/models/ml_bankcard.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ML Bank Card Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MLBankcardAnalyzer analyzer;
  MlBankcardSettings settings;
  var filePath;
  var nBitmapFilePath;
  bool _controlResult = false;
  dynamic _cardType = "Card Type";
  dynamic _cardExpire = "Card Expire";
  dynamic _cardOrganization = "Card Organization";
  dynamic _cardIssuer = "Card Issuer";
  dynamic _cardNumber = "Card Number";
  Map<Permission, PermissionState> permission;
  bool test = false;

  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }

  _requestPermissions() async {
    if (test == false) {
      permission = await PermissionsPlugin.requestPermissions([
        Permission.CAMERA,
        Permission.READ_EXTERNAL_STORAGE,
        Permission.WRITE_EXTERNAL_STORAGE
      ]);
    } else {
      permission = await PermissionsPlugin.checkPermissions([
        Permission.CAMERA,
        Permission.READ_EXTERNAL_STORAGE,
        Permission.WRITE_EXTERNAL_STORAGE
      ]);
    }
  }

  startMlBcrCameraCapture() async {
    // Create an MLBankcardAnalyzer object
    analyzer = new MLBankcardAnalyzer();
    // Create an MLBankcardSettings object to configure the recognition.
    settings = new MlBankcardSettings();

    try {
      // Start a capture activity to obtain bankcard information
      MLBankcard card = await analyzer.captureBankcard(settings: settings);

      var originalBitmapFilePath =
          await FlutterAbsolutePath.getAbsolutePath(card.originalBitmap);
      var numberBitmapFilePath =
          await FlutterAbsolutePath.getAbsolutePath(card.numberBitmap);

      setState(() {
        filePath = originalBitmapFilePath;
        nBitmapFilePath = numberBitmapFilePath;
        _cardExpire = card.expire.toString();
        _cardType = card.type.toString();
        _cardOrganization = card.organization.toString();
        _cardIssuer = card.issuer.toString();
        _cardNumber = card.number.toString();
        _controlResult = true;
      });
    } on Exception catch (e) {
      debugPrint("****Exception : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent[400],
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 4,
              ),
              child: Image.asset(
                "assets/bcr_bg.JPG",
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Huawei ML Kit-BCR Flutter ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "The bank card recognition service recognizes bank cards in camera streams within angle offset of 15 degrees and extracts key information such as card number and expiration date.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            SizedBox(
              height: 12.0,
            ),
            Divider(
              thickness: 1.0,
              color: Colors.purple,
            ),
            Text(
              'Your personal information will be protected in accordance with the law.',
              style: TextStyle(fontSize: 10.0),
            ),
            filePath == null
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/bcrIcon.jpg",
                        height: 300,
                        width: 300,
                      ),
                    ],
                  )
                : Image.file(
                    (new File(filePath)),
                  ),
            Divider(
              thickness: 1.0,
              color: Colors.purple,
            ),
            _controlResult == true
                ? Column(children: [
                    SizedBox(height: 20),
                    ResultWidget(
                      filePath: nBitmapFilePath,
                      cardOrganization: _cardOrganization,
                      cardExpire: _cardExpire,
                      cardIssuer: _cardIssuer,
                      cardNumber: _cardNumber,
                      cardType: _cardType,
                    ),
                  ])
                : AlertDialog(
                    content: Text("Your credit card information will be here."),
                  ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              onPressed: startMlBcrCameraCapture,
              color: Colors.purpleAccent[400],
              textColor: Colors.white,
              splashColor: Colors.purpleAccent[100],
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Take Card Photo",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

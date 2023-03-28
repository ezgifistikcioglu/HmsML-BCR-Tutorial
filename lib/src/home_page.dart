import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_ml_bcr_tutorial/src/ResultWidget.dart';
import 'package:flutter_ml_bcr_tutorial/src/constant/app_constants.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_analyzer.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_settings.dart';
import 'package:huawei_ml/models/ml_bankcard.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MLBankcardAnalyzer mLBankcardAnalyzer;
  MlBankcardSettings mlBankcardSettings;
  bool _controlResult = false;

  String filePath;
  String nBitmapFilePath;
  dynamic _cardType = ApplicationConstants.cardType;
  dynamic _cardExpire = ApplicationConstants.cardExpire;
  dynamic _cardOrganization = ApplicationConstants.cardOrganization;
  dynamic _cardIssuer = ApplicationConstants.cardIssuer;
  dynamic _cardNumber = ApplicationConstants.cardNumber;

  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }

  _requestPermissions() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    print(statuses[Permission.camera]);
  }

  startMlBcrCameraCapture() async {
    // Create an MLBankcardAnalyzer object
    mLBankcardAnalyzer = new MLBankcardAnalyzer();
    // Create an MLBankcardSettings object to configure the recognition.
    mlBankcardSettings = new MlBankcardSettings();

    try {
      // Start a capture activity to obtain bankcard information
      MLBankcard card = await mLBankcardAnalyzer.captureBankcard(
          settings: mlBankcardSettings);

      // URI to File
      String originalBitmapFilePath =
          await FlutterAbsolutePath.getAbsolutePath(card.originalBitmap);
      String numberBitmapFilePath =
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
            _sizedBoxEight(),
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
                padding: ApplicationConstants.normalPadding,
                child: Column(
                  children: [
                    Text(
                      ApplicationConstants.mlBCR,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    _sizedBoxEight(),
                    Text(
                      ApplicationConstants.recService,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            _sizedBoxTwelve(),
            _divider(),
            Text(
              ApplicationConstants.personalInfo,
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
            _divider(),
            _controlResult == true
                ? Column(children: [
                    _sizedBoxTwenty(),
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
                    content: Text(ApplicationConstants.alert),
                  ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF985EA2),
                  padding: ApplicationConstants.normal2xPadding,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  textStyle: TextStyle(color: Colors.white)),
              onPressed: startMlBcrCameraCapture,
              child: Text(
                ApplicationConstants.takeCard,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _sizedBoxTwenty() => SizedBox(height: 20);

  SizedBox _sizedBoxEight() => SizedBox(height: 8.0);

  SizedBox _sizedBoxTwelve() => SizedBox(height: 12.0);

  Divider _divider() {
    return Divider(
      thickness: 1.0,
      color: Colors.purple,
    );
  }
}

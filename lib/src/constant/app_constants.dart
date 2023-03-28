import 'package:flutter/material.dart';

class ApplicationConstants {
  static const String alert = 'Your credit card information will be here.';
  static const String takeCard = 'Take Card Photo';
  static const String personalInfo =
      'Your personal information will be protected in accordance with the law.';
  static const String recService =
      'The bank card recognition service recognizes bank cards in camera streams within angle offset of 15 degrees and extracts key information such as card number and expiration date.';
  static const String mlBCR = 'Huawei ML Kit-BCR Flutter ';
  static const String title = 'Flutter Demo Home Page';
  static const String mTitle = 'Flutter ML Bank Card Recognition';

  static const String cardType = 'Card Type';
  static const String cardExpire = 'Card Expire';
  static const String cardOrganization = 'Card Organization';
  static const String cardIssuer = 'Card Issuer';
  static const String cardNumber = 'Card Number';

// SizedBox
  SizedBox get sizedBoxEight => const SizedBox(height: 8);
  SizedBox get sizedBoxTwelve => const SizedBox(height: 12);
  SizedBox get sizedBoxTwenty => const SizedBox(height: 20);

  // Padding
  static const EdgeInsets normalPadding = EdgeInsets.all(8);
  static const EdgeInsets normal2xPadding = EdgeInsets.all(12);
  static const EdgeInsets symmetricPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

//MediaQuery
  double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double getMaxHeight(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.9;

  //Color
  Color get lightPurple => const Color(0xFF985EA2);
}

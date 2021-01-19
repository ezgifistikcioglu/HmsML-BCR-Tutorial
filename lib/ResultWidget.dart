import 'dart:io';

import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String numberBitmap;
  final String cardType;
  final String cardExpire;
  final String cardOrganization;
  final String cardIssuer;
  final String cardNumber;
  final String filePath;

  ResultWidget(
      {this.cardType,
      this.cardExpire,
      this.cardOrganization,
      this.cardIssuer,
      this.cardNumber,
      this.numberBitmap,
      this.filePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color.fromRGBO(247, 242, 241, 1),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("You can see your card number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        filePath != null
                            ? Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: .5,
                                        color: Colors.black.withOpacity(.4),
                                        style: BorderStyle.solid)),
                                child: Image.file(
                                  (new File(filePath)),
                                ))
                            : Text("test"),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Card Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: .5,
                                  color: Colors.black.withOpacity(.4),
                                  style: BorderStyle.solid)),
                          child: Text(cardNumber.toString()),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Card Organization",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: .5,
                                  color: Colors.black.withOpacity(.4),
                                  style: BorderStyle.solid)),
                          child: Text(cardOrganization.toString()),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Card Expire",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: .5,
                                  color: Colors.black.withOpacity(.4),
                                  style: BorderStyle.solid)),
                          child: Text(cardExpire.toString()),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Card Issuer",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: .5,
                                  color: Colors.black.withOpacity(.4),
                                  style: BorderStyle.solid)),
                          child: Text(cardIssuer.toString()),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Card Type",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: .5,
                                  color: Colors.black.withOpacity(.4),
                                  style: BorderStyle.solid)),
                          child: Text(cardType.toString()),
                        )
                      ]),
                ))));
  }
}

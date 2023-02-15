import 'dart:io';

import 'package:flutter/material.dart';
import '../helpers/DateHelper.dart';

class PersonelModel {
  int? ID;
  String? TCKIMLIKNO;
  String? ADISOYADI;
  String? CINSIYET;
  DateTime? DOGUMTARIHI;
  String? TELEFON;
  String? RESIMYOLU;

  PersonelModel() {}

  PersonelModel.fromObject(dynamic json) {
    ID = json['ID'];
    TCKIMLIKNO = json['TCKIMLIKNO'];
    ADISOYADI = json['ADISOYADI'];
    CINSIYET = json['CINSIYET'];
    TELEFON = json['TELEFON'];
    RESIMYOLU = json['RESIMYOLU'];
    DOGUMTARIHI = json['DOGUMTARIHI'] == null
        ? null
        : DateHelper.GetDate(
            json['DOGUMTARIHI'].toString(), "yyyy-MM-dd HH:mm:ss");
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TCKIMLIKNO'] = this.TCKIMLIKNO;
    data['ADISOYADI'] = this.ADISOYADI;
    data['CINSIYET'] = this.CINSIYET;
    data['TELEFON'] = this.TELEFON;
    data['RESIMYOLU'] = this.RESIMYOLU;
    data['DOGUMTARIHI'] = DOGUMTARIHI == null
        ? null
        : DateHelper.GetString(DOGUMTARIHI!, "yyyy-MM-dd HH:mm:ss");
    return data;
  }

  Widget toView() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
            child: Container(
                height: 150,
                child: Row(children: [
                  Container(
                      width: 150,
                      child: RESIMYOLU == null
                          ? Container(width: 50)
                          : Image.file(File(RESIMYOLU!), fit: BoxFit.cover)),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(ADISOYADI ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                                SizedBox(height: 10),
                                Text(TCKIMLIKNO ?? ""),
                                SizedBox(height: 10),
                                Text(CINSIYET ?? ""),
                                SizedBox(height: 10),
                                Text(DOGUMTARIHI == null
                                    ? ""
                                    : DateHelper.GetString(
                                        DOGUMTARIHI!, "dd.MM.yyyy"))
                              ])))
                ]))));
  }
}

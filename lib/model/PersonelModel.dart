import 'package:flutter/material.dart';
import 'package:personeltakipapp/helpers/DBHelper.dart';
import 'package:personeltakipapp/helpers/DateHelper.dart';

class PersonelModel {
  int? ID;
  String? TCKIMLIKNO;
  String? ADISOYADI;
  String? CINSIYET;
  DateTime? DOGUMTARIHI;

  PersonelModel() {}

  PersonelModel.fromObject(dynamic json) {
    ID = json['ID'];
    TCKIMLIKNO = json['TCKIMLIKNO'];
    ADISOYADI = json['ADISOYADI'];
    CINSIYET = json['CINSIYET'];
    DOGUMTARIHI = json['DOGUMTARIHI'] == null
        ? null
        : DateHelper.GetDate(
            json['DOGUMTARIHI'].toString(), "YYYY-MM-DD HH:MM:SS.SSS");
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TCKIMLIKNO'] = this.TCKIMLIKNO;
    data['ADISOYADI'] = this.ADISOYADI;
    data['CINSIYET'] = this.CINSIYET;
    data['DOGUMTARIHI'] = DOGUMTARIHI == null
        ? null
        : DateHelper.GetString(DOGUMTARIHI!, "YYYY-MM-DD HH:MM:SS.SSS");
    return data;
  }

  Widget toView() {
    return Container(child: Text(ADISOYADI ?? ""));
  }
}

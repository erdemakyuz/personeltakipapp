import 'package:personeltakipapp/helpers/DateHelper.dart';

class PersonelModel {
  int? ID;
  String? TCKIMLIKNO;
  String? ADISOYADI;
  String? CINSIYET;
  DateTime? DOGUMTARIHI;

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
}

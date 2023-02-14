import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:personeltakipapp/helpers/DBHelper.dart';
import 'package:personeltakipapp/helpers/DateHelper.dart';
import 'package:personeltakipapp/helpers/UtilsHelper.dart';
import 'package:personeltakipapp/model/PersonelModel.dart';

class DetayScreen extends StatefulWidget {
  final PersonelModel? PersonelItem;
  const DetayScreen({super.key, required this.PersonelItem});

  @override
  State<DetayScreen> createState() => _DetayScreenState(PersonelItem);
}

class _DetayScreenState extends State<DetayScreen> {
  //Personel bilgisini taşımak için kullanılıyor.
  final PersonelModel? PersonelItem;
  _DetayScreenState(this.PersonelItem) {
    if (this.PersonelItem != null) {
      tcKimlikController.text = PersonelItem?.TCKIMLIKNO ?? "";
      adSoyadController.text = PersonelItem?.ADISOYADI ?? "";
      cinsiyetController.text = PersonelItem?.CINSIYET ?? "";
      if (PersonelItem?.DOGUMTARIHI != null) {
        dogumTarihiController.text =
            DateHelper.GetString(PersonelItem!.DOGUMTARIHI!, "dd.MM.yyyy");
        selectedDate = PersonelItem!.DOGUMTARIHI!;
      }
    }
  }

  TextEditingController tcKimlikController = TextEditingController();
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController cinsiyetController = TextEditingController();
  TextEditingController dogumTarihiController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  DateTime? selectedDate; //Seçili tarihi DateTime almak için kullandık.
  Future<void> selectDogumTarihi(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(1970),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      selectedDate = pickedDate;
      dogumTarihiController.text =
          DateHelper.GetString(pickedDate, "dd.MM.yyyy");
    }
  }

  final List<String> cinsiyetList = ['ERKEK', 'KADIN'];
  Future selectCinsiyet(BuildContext context) {
    return showDialog(
        context: context,
        builder: (dcontext) {
          var dialog = AlertDialog(
            title: Text('Cinsiyet Seçiniz'),
            content: SingleChildScrollView(
              //Telefon boyutuna göre sığmama durumu ile karşılaşmamak için SingleChildScrollView kullandık.
              child: Container(
                  width: double
                      .infinity, //Alert ekranı widthini ayarlamak için kullanıyoruz.
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: cinsiyetList
                        .map((e) => RadioListTile(
                              title: Row(children: [
                                Icon(e == "ERKEK" ? Icons.male : Icons.female),
                                SizedBox(width: 20),
                                Text(e)
                              ]),
                              value: e,
                              groupValue: cinsiyetController.text,
                              selected: cinsiyetController.text == e,
                              onChanged: (value) {
                                cinsiyetController.text = value.toString();
                                setState(() {});
                                Navigator.of(dcontext).pop();
                              },
                            ))
                        .toList(),
                  )),
            ),
          );
          return dialog;
        });
  }

  void personelKaydet(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //Kaydet
      var model = this.PersonelItem ?? new PersonelModel();
      model.TCKIMLIKNO = tcKimlikController.text;
      model.ADISOYADI = adSoyadController.text;
      model.TELEFON = telefonController.text;
      model.DOGUMTARIHI = selectedDate;
      model.CINSIYET = cinsiyetController.text;

      if (this.PersonelItem != null) {
        DBHelper().updatePersonel(model).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Personel kaydedildi.')));
          Navigator.pop(context, true);
        }).catchError((onError) {
          //hata mesajını gösterebiliriz.
          EasyLoading.showError('Personel Kaydedilemedi.' + onError.toString());
        });
      } else {
        DBHelper().insertPersonel(model).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Personel kaydedildi.')));
          Navigator.pop(context, true);
        }).catchError((onError) {
          //hata mesajını gösterebiliriz.
          EasyLoading.showError('Personel Kaydedilemedi.' + onError.toString());
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personel Detay")),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  //Validation kullanmak için Form nesnesini ekledik.
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          //Validation kullanacaksak TextFormField gerekiyor.
                          controller: tcKimlikController,
                          keyboardType:
                              TextInputType.number, //Aktif klavye görünümü
                          maxLength: 11,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'T.C. Kimlik No',
                              prefixIcon:
                                  Icon(Icons.card_membership), //sol icon
                              suffixIcon:
                                  tcKimlikController.text.isNotEmpty //sağ ikon
                                      ? IconButton(
                                          icon: Icon(Icons.clear_outlined),
                                          onPressed: () {
                                            tcKimlikController.text = "";
                                          },
                                        )
                                      : null),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "T.C. Kimlik No boş olamaz";
                            }
                            if (value.trim().length != 11) {
                              return "T.C. Kimlik No 11 rakamdan oluşmalıdır.";
                            }
                            if (UtilsHelper.isTCKimlikNo(
                                    int.parse(value.trim())) ==
                                false) {
                              return "Lütfen geçerli bir T.C. Kimlik No giriniz.";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: adSoyadController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adı Soyadı',
                              prefixIcon: Icon(Icons.account_box_outlined)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: cinsiyetController,
                          readOnly: true,
                          showCursor: false,
                          enableInteractiveSelection: false,
                          onTap: (() {
                            selectCinsiyet(context);
                          }),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Cinsiyet',
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          showCursor: false, //imleci gösterme
                          readOnly: true, //readonly yap
                          enableInteractiveSelection:
                              false, //tıklanmaya bağlı renklendirme yapma
                          controller: dogumTarihiController,
                          onTap: () {
                            selectDogumTarihi(context);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Doğum Tarihi',
                              prefixIcon: Icon(Icons.calendar_month)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: telefonController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Cep Telefonu',
                              prefixIcon: Icon(Icons.phone)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, //Ekranın size ini almak için kullanıyoruz.
                          child: ElevatedButton.icon(
                              onPressed: () {
                                personelKaydet(context);
                              },
                              icon: Icon(Icons.save),
                              label: Text('Personel Kaydet')))
                    ],
                  )))),
    );
  }
}

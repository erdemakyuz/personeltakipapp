import 'package:flutter/material.dart';
import 'package:personeltakipapp/helpers/DateHelper.dart';
import 'package:personeltakipapp/helpers/UtilsHelper.dart';

class DetayScreen extends StatefulWidget {
  const DetayScreen({super.key});

  @override
  State<DetayScreen> createState() => _DetayScreenState();
}

class _DetayScreenState extends State<DetayScreen> {
  TextEditingController tcKimlikController = TextEditingController();
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController cinsiyetController = TextEditingController();
  TextEditingController dogumTarihiController = TextEditingController();

  Future<void> selectDogumTarihi(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(1970),
        lastDate: DateTime.now());
    if (pickedDate != null) {
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

  void personelKaydet() {
    if (_formKey.currentState!.validate()) {
      //Kaydet
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
                      Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, //Ekranın size ini almak için kullanıyoruz.
                          child: ElevatedButton.icon(
                              onPressed: () {
                                personelKaydet();
                              },
                              icon: Icon(Icons.save),
                              label: Text('Personel Kaydet')))
                    ],
                  )))),
    );
  }
}

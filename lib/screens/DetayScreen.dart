import 'package:flutter/material.dart';
import 'package:personeltakipapp/helpers/DateHelper.dart';

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
  String selectedCinsiyet = "";
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
                              title: Text(e),
                              value: e,
                              groupValue: selectedCinsiyet,
                              selected: selectedCinsiyet == e,
                              onChanged: (value) {
                                selectedCinsiyet = value.toString();
                              },
                            ))
                        .toList(),
                  )),
            ),
          );
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personel Detay")),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: tcKimlikController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'T.C. Kimlik No',
                      prefixIcon: Icon(Icons.card_membership)),
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
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: Text('Personel Kaydet')))
            ],
          )),
    );
  }
}

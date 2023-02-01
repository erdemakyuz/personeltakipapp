import 'package:flutter/material.dart';

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
      dogumTarihiController.text = pickedDate.toString();
    }
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

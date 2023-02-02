import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:personeltakipapp/helpers/DBHelper.dart';
import 'package:personeltakipapp/model/PersonelModel.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<PersonelModel>? personelListe = null;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    EasyLoading.show(status: "Liste Yükleniyor...");
    DBHelper().getPersonelList().then((value) {
      personelListe = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personel Listesi"),
        actions: [
          GestureDetector(
              onTap: () {
                openDetayScreen(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.add_circle, color: Colors.white)))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: (extd, index) {
              return personelListe![index].toView();
            },
            separatorBuilder: (sep, index) {
              return Divider();
            },
            itemCount: personelListe?.length ?? 0),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15, right: 15),
        child: FloatingActionButton(
            heroTag: "button1", //Birden fazla kullanımında istiyor.
            backgroundColor: Colors.blue,
            onPressed: () {
              openDetayScreen(context);
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  void openDetayScreen(BuildContext context) {
    Navigator.pushNamed(context, "/Detay");
  }
}

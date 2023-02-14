import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:personeltakipapp/helpers/DBHelper.dart';
import 'package:personeltakipapp/model/PersonelModel.dart';
import 'package:personeltakipapp/screens/DetayScreen.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    EasyLoading.show(status: "Liste Yükleniyor...").then((value) {
      DBHelper().getPersonelList().then((value) {
        EasyLoading.dismiss();
        personelListe = value;
        setState(() {});
      });
    });
  }

  void showActionSheet(BuildContext ctx, PersonelModel model) {
    showCupertinoDialog(
        context: ctx,
        barrierDismissible: true,
        builder: (builder) => Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoActionSheet(
              message: Text("Lütfen seçim yapınız !"),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      //tel: diye yazınca aramaya gidiyor.
                      var url = "tel:${model.TELEFON}";
                      if (canLaunchUrlString(url) == true) {
                        launchUrlString("tel:${model.TELEFON}");
                      }
                    },
                    child: Text('Personel Telefon Et')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      //sms: diye yazınca aramaya gidiyor.
                      var url = "sms:${model.TELEFON}";
                      if (canLaunchUrlString(url) == true) {
                        launchUrlString("sms:${model.TELEFON}");
                      }
                    },
                    child: Text('Personel SMS Gönder')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Personel QR Code')),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Vazgeç',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personel Listesi"),
        actions: [
          GestureDetector(
              onTap: () {
                openDetayScreen(context, null);
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
              return GestureDetector(
                  onTap: () {
                    openDetayScreen(context, personelListe![index]);
                  },
                  onLongPress: () {
                    showActionSheet(context, personelListe![index]);
                  },
                  child: personelListe![index].toView());
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
              openDetayScreen(context, null);
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  Future<void> openDetayScreen(
      BuildContext context, PersonelModel? model) async {
    //Eğer DetayScreen den true dönersek liste yenilenecek, değilse aynen kalacak

    if (model == null) {
      final result = await Navigator.pushNamed(context, "/Detay");
      if (result != null && result == true) {
        refreshData();
      }
    } else {
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetayScreen(PersonelItem: model))));
      if (result != null && result == true) {
        refreshData();
      }
    }
  }
}

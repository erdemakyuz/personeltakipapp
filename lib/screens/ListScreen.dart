import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personel Listesi"),
        actions: [
          GestureDetector(
              onTap: () {
                openDetayScreen();
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.add_circle, color: Colors.white)))
        ],
      ),
      body: Container(color: Colors.white),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15, right: 15),
        child: FloatingActionButton(
            heroTag: "button1", //Birden fazla kullanımında istiyor.
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

import 'package:flutter/material.dart';
import 'package:personeltakipapp/model/PersonelModel.dart';

class QRScreen extends StatefulWidget {
  final PersonelModel? PersonelItem;
  const QRScreen({super.key, required this.PersonelItem});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final PersonelModel? PersonelItem;
  _QRScreenState(this.PersonelItem) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personel QR")),
      body: Container(color: Colors.yellow),
    );
  }
}

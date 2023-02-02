import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:personeltakipapp/screens/DetayScreen.dart';
import 'package:personeltakipapp/screens/ListScreen.dart';
import 'package:personeltakipapp/screens/LoginScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Yükleniyor ekranda çıktığında ekranın kalan boşluklarını kitlemesi için eklendi. s
    //Mask
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    return MaterialApp(
      title: 'Personel Takip App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('tr', 'TR')],
      builder: EasyLoading.init(),
      initialRoute: "/",
      routes: {
        "/": ((context) => const LoginScreen()),
        "/List": ((context) => const ListScreen()),
        "/Detay": ((context) => const DetayScreen()),
      },
    );
  }
}

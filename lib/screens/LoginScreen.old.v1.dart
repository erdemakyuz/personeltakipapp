import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController =
      new TextEditingController(text: 'admin');
  TextEditingController passwordController =
      new TextEditingController(text: '123456');
  bool beniHatirla = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                width: 200,
                child: Image.asset('lib/assets/images/bursakart-burulas.png'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Kullanıcı Adı'),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, //Şifre için metnin gizlenmesini sağlar.
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kullanıcı Şifre'),
                ),
              ),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterSwitch(
                        value: beniHatirla,
                        onToggle: (value) {
                          beniHatirla = value;
                          setState(() {});
                        }),
                    OutlinedButton.icon(
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Kullanıcı Giriş Yap',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {
                        girisYap(context);
                      },
                    )
                  ]),
              SizedBox(height: 50),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Şifremi Unuttum',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ]),
      ),
    );
  }

  void girisYap(BuildContext context) {
    if (usernameController.text == 'admin' &&
        passwordController.text == '123456') {
      Navigator.pushReplacementNamed(context, "/List");
    } else {
      EasyLoading.showToast('Kullanıcı adı ve/veya şifreniz hatalıdır !');
    }
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:pwdmanls/db.dart';
import 'package:encrypt/encrypt.dart' as enc;

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController urlcontroller = TextEditingController();

  @override
  void initState() {
    loadSettings(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("יצירת סיסמא"),
        ),
        body: Center(
            child: Column(children: [
          const SizedBox(height: 40),
          loginRegline(titlecontroller, "שם האתר"),
          const SizedBox(height: 10),
          loginRegline(emailcontroller, "אימייל"),
          const SizedBox(height: 10),
          passwordText(passwordcontroller, 'סיסמה'),
          const SizedBox(height: 10),
          urlText(urlcontroller),
          const SizedBox(height: 10),
          generateButton(),
          const SizedBox(height: 10),
          addPasswordButton(),
        ])));
  }

  Widget loginRegline(TextEditingController controller, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          key: const Key("Email_controller"),
          maxLength: 45,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          autofocus: false,
          decoration: InputDecoration(
            counterText: "",
            border: const OutlineInputBorder(),
            labelText: title,
          ),
        ),
      ),
    );
  }

  Widget passwordText(TextEditingController controller, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          enabled: false,
          key: const Key("Password"),
          maxLength: 45,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          autofocus: false,
          decoration: InputDecoration(
            counterText: "",
            border: const OutlineInputBorder(),
            labelText: title,
          ),
        ),
      ),
    );
  }

  Widget urlText(TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          key: const Key("Url"),
          maxLength: 45,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          autofocus: false,
          decoration: const InputDecoration(
            counterText: "",
            border: OutlineInputBorder(),
            labelText: "url",
          ),
        ),
      ),
    );
  }

  Widget generateButton() {
    return ElevatedButton(
      key: const Key("LoginButton"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          )),
      onPressed: () async {
        passwordcontroller.text = generatePassword();
      },
      child: const Text("תמצא סיסמא"),
    );
  }

  Widget addPasswordButton() {
    return ElevatedButton(
      key: const Key("LoginPasswordButton"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          )),
      onPressed: () async {
        savePassword(context);
      },
      child: const Text("שמור סיסמא"),
    );
  }

  String generatePassword() {
    int length = 8;
    const String letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
    String letterUpperCase = letterLowerCase.toUpperCase();
    const numbers = '0123456789';

    String pass = '';
    pass += letterLowerCase;
    pass += letterUpperCase;
    pass += numbers;

    return List.generate(length, (index) {
      final indexRandom = Random().nextInt(pass.length);
      return pass[indexRandom];
    }).join('');
  }

  Future savePassword(BuildContext context) async {
    if (titlecontroller.text == "") {
      showDialogMsg(context, "שגיאה", "אנא הזן שם לאתר");
      return;
    } else {
      if (emailcontroller.text == "") {
        showDialogMsg(context, "שגיאה", "אנא הזן אימייל");
        return;
      } else {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailcontroller.text);
        if (!emailValid) {
          showDialogMsg(context, "שגיאה", "אימייל לא תקין");
          return;
        } else {
          if (passwordcontroller.text == "") {
            showDialogMsg(context, "שגיאה", "אנא הזן סיסמא");
            return;
          }
        }
      }
    }
    encrypt(passwordcontroller.text).then((value) {
      final database = Provider.of<MyDatabase>(context, listen: false);
    DataSetCompanion data = DataSetCompanion(
      title: drift.Value(titlecontroller.text),
        email: drift.Value(emailcontroller.text),
        password: drift.Value(value),
        url: drift.Value(urlcontroller.text));
    database.insertDataSet(data);
    });
    // database.getDataSet().then((value) => print(value));
  }

  Future<String> encrypt(String password) async{
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: "pkey");
    if(value != null){
      final key = enc.Key.fromUtf8(value);
      final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
      final fernet = enc.Fernet(b64key);
      final encrypter = enc.Encrypter(fernet);
      final encrypted = encrypter.encrypt(password);
      print(encrypted.base64);
      final dec = encrypter.decrypt(encrypted);
      print(dec);
      return encrypted.base64;
    }
    return "Error";
  }

  Future showDialogMsg(BuildContext context, String title, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(title),
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('אישור'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> loadSettings(BuildContext context) async {
    final database = Provider.of<MyDatabase>(context, listen: false);
    database.getDefaultEmail().then((value) {
      if (value.isNotEmpty) {
        for (var v in value) {
          emailcontroller.text = v.email;
        }
      }
    });
    return 0;
  }
}

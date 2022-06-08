import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwdmanls/db.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
   TextEditingController urlcontroller = TextEditingController();

   @override
  void initState() {
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
            child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            loginRegline(emailcontroller, "אימייל"),
            const SizedBox(height: 10),
            passwordText(passwordcontroller, 'סיסמה'),
            const SizedBox(height: 10),
            urlText(urlcontroller),
            const SizedBox(height: 10),
            generateButton(),
            const SizedBox(height: 10),
            addPasswordButton(),
          ],
        )));
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
      key: const Key("LoginButton"),
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

  String generatePassword(){
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
    final database = Provider.of<MyDatabase>(context,listen: false);
    DataSetCompanion data = DataSetCompanion(username: Value(emailcontroller.text),password: Value(passwordcontroller.text),url : Value(urlcontroller.text));
    print(database.insertDataSet(data));
    // database.getDataSet().then((value) => print(value));
  }
}

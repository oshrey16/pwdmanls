import 'dart:math';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwdmanls/db.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController emailcontroller = TextEditingController();
  bool flaginit = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("הגדרות"),
        ),
        body: Center(
            child: Column(children: [
          const SizedBox(height: 40),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return loginRegline(emailcontroller, "אימייל");
            },
            future: loadDatabase(context),
          ),
          const SizedBox(
            height: 20,
          ),
          saveSettings(),
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

  Widget saveSettings() {
    return ElevatedButton(
      key: const Key("LoginButton"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          )),
      onPressed: () async {
        flaginit ? insertDatabase(context) :updateDatabase(context);
      },
      child: const Text("שמור הגדרות"),
    );
  }

  Future<int> loadDatabase(BuildContext context) async {
    final database = Provider.of<MyDatabase>(context, listen: false);
    database.getDefaultEmail().then((value) {
      if (value.isNotEmpty) {
        for (var v in value) {
          emailcontroller.text = v.email;
        }
      }
      else{
        flaginit = true;
      }
    });
    return 0;
  }

  Future<int> updateDatabase(BuildContext context) async {
    final database = Provider.of<MyDatabase>(context, listen: false);
    database.updateEmailSettings(
        SettingsCompanion(email: drift.Value(emailcontroller.text)));
    return 0;
  }

  Future<int> insertDatabase(BuildContext context) async {
    final database = Provider.of<MyDatabase>(context, listen: false);
    database.insertEmailSettings(
        SettingsCompanion(email: drift.Value(emailcontroller.text)));
    flaginit = false;
    return 0;
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
}

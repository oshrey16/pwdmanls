import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:pwdmanls/db.dart';
import 'package:pwdmanls/struct.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:encrypt/encrypt.dart' as enc;

class GetPasswordPage extends StatefulWidget {
  const GetPasswordPage({Key? key}) : super(key: key);

  @override
  State<GetPasswordPage> createState() => _GetPasswordPageState();
}

class _GetPasswordPageState extends State<GetPasswordPage> {
  final List<PasswordStruct> passwords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("רשימת סיסמאות"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return Column(children: [
                  for (var pass in passwords)
                    GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blueGrey.shade100,
                        elevation: 14.0,
                        child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pass.title,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("שם משתמש: ${pass.email}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "סיסמא: ${pass.password.replaceRange(2, pass.password.length - 3, "•••••")}"),
                                      if (pass.url != '')
                                        InkWell(
                                            child: Text(
                                              'Link To ${pass.title}',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            onTap: () async {
                                              if (await canLaunchUrlString(
                                                  "https://${pass.url}")) {
                                                launchUrlString(
                                                    "https://${pass.url}");
                                              }
                                            }),
                                    ],
                                  ),
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 10, 0),
                                      child: GestureDetector(
                                        child: const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        onLongPress: () {
                                          decryptPass(pass.password)
                                              .then((value) {
                                                setState(() {
                                                  showDialogMsg(context, "סיסמא", value);
                                                });
                                            
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: IconButton(
                                          icon: const Icon(Icons.copy),
                                          color: Colors.green,
                                          iconSize: 40,
                                          onPressed: () {
                                            decryptPass(pass.password)
                                                .then((value) {
                                              if (value.isNotEmpty) {
                                                Clipboard.setData(
                                                    ClipboardData(text: value));
                                              }
                                            });
                                          },
                                        ))
                                  ]),
                                ])),
                      ),
                      onTap: () {},
                    )
                ]);
              }
              return const Text("Error");
            }
          },
          future: getDatabase(context),
        ))));
  }

  Future<int> getDatabase(BuildContext context) async {
    passwords.clear();
    final database = Provider.of<MyDatabase>(context, listen: false);
    database.getDataSet().then((value) {
      for (var v in value) {
        PasswordStruct p =
            PasswordStruct(v.id, v.title, v.email, v.password, v.url);
        passwords.add(p);
      }
    });
    return 0;
  }

  Future<String> decryptPass(String password) async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: "pkey");
    if (value != null) {
      final key = enc.Key.fromUtf8(value);
      final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
      final fernet = enc.Fernet(b64key);
      final encrypter = enc.Encrypter(fernet);
      final dec = encrypter.decrypt(enc.Encrypted.fromBase64(password));
      return dec;
    }
    return "Error";
  }

  Future showDialogMsg(BuildContext context, String title, String text) async {
    const oneSec = Duration(seconds:3);
    Timer.periodic(oneSec, (Timer t) { Navigator.of(context).pop();t.cancel();});
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
        );
      },
    );
  }
}

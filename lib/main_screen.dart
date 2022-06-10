import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("מסך ראשי"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [createButton(),const SizedBox(height: 20,),getButton(),const SizedBox(height: 20,),settings()]),
          ),
        ));
  }

  Widget createButton() {
    return ElevatedButton(
        key: const Key("CreateButton"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        onPressed: () async {
           Navigator.pushNamed(context, '/set');
        },
        child: const Text('יצירת סיסמה חדשה'));
  }
  Widget getButton() {
    return ElevatedButton(
        key: const Key("GetButton"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        onPressed: () async {
          Navigator.pushNamed(context, '/get');
        },
        child: const Text('צפייה בסיסמאות שמורות'));
  }

  Widget settings() {
    return ElevatedButton(
        key: const Key("SettingsButton"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        onPressed: () async {
          Navigator.pushNamed(context, '/settings');
        },
        child: const Text('הגדרות'));
  }
}

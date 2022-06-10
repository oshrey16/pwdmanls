import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            child: Column(children: [
              createButton(),
              const SizedBox(
                height: 20,
              ),
              getButton(),
              const SizedBox(
                height: 20,
              ),
              settings(),
              const SizedBox(
                height: 30,
              ),
              developer()
            ]),
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

  Widget developer() {
    return Column(children: [
      const Text("developed by Oshrey Avaraham"),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
          InkWell(
              child: const Text(
                'Linkdin',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                if (await canLaunchUrlString(
                    "https://https://www.linkedin.com/in/oshrey-avraham/")) {
                  launchUrlString(
                      "https://www.linkedin.com/in/oshrey-avraham/");
                }
              }),
              const SizedBox(width: 10),
              InkWell(
              child: const Text(
                'Github',
                style: TextStyle(color: Colors.blueGrey),
              ),
              onTap: () async {
                if (await canLaunchUrlString(
                    "https://github.com/oshrey16")) {
                  launchUrlString(
                      "https://github.com/oshrey16");
                }
              }),
        ],
      )
    ]);
  }
}

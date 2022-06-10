import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pwdmanls/db.dart';
import 'package:pwdmanls/get_password.dart';
import 'package:pwdmanls/main_screen.dart';
import 'package:pwdmanls/set_password.dart';
import 'package:provider/provider.dart';
import 'package:pwdmanls/settings.dart';

late MyDatabase database;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      child: const MyApp(),
      dispose: (context, db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(title: 'PwdManagerls'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const MainScreen(),
        '/set': (context) => const SetPassword(),
        '/get': (context) => const GetPasswordPage(),
        '/settings': (context) => const SettingsPage(),
      },
      title: 'PwdManls',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'PwdManagerls'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _passwordVisible = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            loginReglinePassword(_passwordController, "סיסמא"),
            const SizedBox(height: 30),
            loginButton(),
            const SizedBox(height: 15),
            // registerButton(),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
        key: const Key("LoginButton"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        onPressed: () async {
          loginFuture(context).then((value) {
            print(value);
            if (value == 0) {
              Navigator.pushNamed(context, '/second');
            }
            else{
              showDialogMsg(context,"שגיאה","סיסמא לא נכונה");
            }
          });
        },
        child: const Text('התחבר'));
  }

  Widget loginReglinePassword(TextEditingController controller, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          maxLength: 45,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          autofocus: false,
          obscureText: _passwordVisible,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: title,
              counterText: "",
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )),
        ),
      ),
    );
  }

  Future<int> loginFuture(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: "pass");
    if (value == null) {
      showDialogRegister(context, storage).then((value) {
        return 0;
      });
    }
    print(value);
    if (value == _passwordController.text) {
      return 0;
    }
    return -1;
  }

  Future showDialogRegister(
      BuildContext context, FlutterSecureStorage storage) async {
    TextEditingController register = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text("הרשמה"),
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: register,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'הכנס סיסמא',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('אישור'),
              onPressed: () async {
                if (register.text != '') {
                  await storage.write(key: "pass", value: register.text.toString());
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
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

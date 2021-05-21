import 'package:app_bilmemne/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:vibration/vibration.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'listeleme_sayfasi.dart';
import 'test.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TestAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Beni Kapama",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Hive.openBox("test"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return MyHomePage();
          } else
            return Scaffold(
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade900,
                      Colors.blueAccent.shade400
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _sayfalar = [
    Anasayfa(),
    ListeSayfasi(),
    Text(" ayar "),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: NewGradientAppBar(
       title: Text("Uygulamaya koyacak isim bulamadım", style: TextStyle(fontSize: 15),),
       gradient: LinearGradient( tileMode: TileMode.mirror,colors: [Colors.blueAccent.shade700, Colors.lightBlue.shade900]),
       centerTitle: true,
     ),
      body: _sayfalar[_currentIndex], backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle:
            TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        selectedItemColor: Colors.red,
        iconSize: 25,
        selectedFontSize: 14,
        selectedIconTheme: IconThemeData(color: Colors.red, size: 30),
        currentIndex: _currentIndex,
        items: [
           // ignore: deprecated_member_use
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text("Son çözülenler"),
              backgroundColor: Colors.grey.shade200),
          // ignore: deprecated_member_use
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              title: Text("Son çözülenler"),
              backgroundColor: Colors.grey.shade200),
          // ignore: deprecated_member_use
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              title: Text("Ayarlar"),
              backgroundColor: Colors.grey.shade200),
        ],
        backgroundColor: Colors.white,
        onTap: (index) async {
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(duration: 5);
          }

          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

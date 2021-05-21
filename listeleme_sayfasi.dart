import 'package:app_bilmemne/test.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class ListeSayfasi extends StatefulWidget {
  @override
  _ListeSayfasiState createState() => _ListeSayfasiState();
}

class _ListeSayfasiState extends State<ListeSayfasi> {
  final testBox = Hive.box('test');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: testBox.length,
      itemBuilder: (BuildContext context, int index) {
        final test = testBox.get(index) as Test;
        return Card(
          color: Color.fromARGB(100, 2, 157, 175),
          child: ListTile(
            title: Text(
              "Gün: ${test.gun} \n  Çözdüğün Soru sayısı: ${test.dogruSayisi + test.yanlisSayisi} ",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Yanlış sayısı:" + test.yanlisSayisi.toString(),
              style: TextStyle(color: Colors.red),
            ),
            onLongPress: () async {
              if (await Vibration.hasVibrator()) {
                Vibration.vibrate(duration: 5);
                setState(() {
                  try {
                    testBox.deleteAt(index);
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "Bir Hata İle Karşılaştık Gardaş",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                });
              }
            },
          ),
        );
      },
    );
  }
}

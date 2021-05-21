import 'package:app_bilmemne/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  TextEditingController _t2 = TextEditingController();
  double _sliderValue = 0;
  double _sliderValueYanlis = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.black,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Doğru Sayısı:" + _sliderValue.round().toString()),
                Slider(
                  activeColor: Colors.green.shade400,
                  value: _sliderValue,
                  min: 0,
                  max: 400,
                  label: _sliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                Text("Yanlış Sayısı:" + _sliderValueYanlis.round().toString()),
                Slider(
                  activeColor: Colors.orange,
                  value: _sliderValueYanlis,
                  min: 0,
                  max: 100,
                  label: _sliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValueYanlis = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    
                    decoration: InputDecoration(
                        hintText: "Kaçıncı Günde Olduğunu yaz..",
                        hintStyle: TextStyle(color: Colors.black38)),
                    controller: _t2,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: Ekle,
                      child: Text("Ekle"),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (await Vibration.hasVibrator()) {
                          Vibration.vibrate(duration: 5);

                          setState(() {
                            _sliderValue = 0;
                            _sliderValueYanlis = 0;

                            Fluttertoast.showToast(
                                msg: "Girdikleriniz Temizlendi",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                        }
                      },
                      child: Text("Temizle"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void Ekle() async {
    
    int sliderValue = int.parse(
        _sliderValue.round().toString()); // 1. slider bardan sayı aldık
    int sliderValueYanlis = int.parse(
        _sliderValueYanlis.round().toString()); // sliderbardan sayı aldık

    try {
      int gun = int.parse(_t2.text);
      final yeniTest = Test(sliderValue, sliderValueYanlis, gun);

      if (_sliderValue != null) {
        debugPrint("slider value boş değil");
        if (_sliderValueYanlis != null) {
        debugPrint("slider value yanlis  boş değil");

          if (_t2 != null) {
        debugPrint(" t2 boş değil");

            TestEkle(yeniTest);
            Fluttertoast.showToast(
                msg: "Girdikleriniz Eklendi",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "_t2 Boş",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "_valueyanlis Boş",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "slider value Boş",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {
        _sliderValueYanlis = 0;
        _sliderValue = 0;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Günü Yazsana Gardaş",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

void TestEkle(Test test) {
  final TestBox = Hive.box("test");
  TestBox.add(test);
}

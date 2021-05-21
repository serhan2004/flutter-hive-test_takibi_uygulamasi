
import 'package:hive/hive.dart';
import 'dart:core';
part 'test.g.dart';

@HiveType(typeId: 0)
class Test {
  @HiveField(0)
  int  dogruSayisi;
  @HiveField(1)
  int  yanlisSayisi;
  @HiveField(2)
  int gun;
  Test(this.dogruSayisi,this.yanlisSayisi,this.gun);
  

  double kdrHesapla(int dogruSayisi, int yanlisSayisi){
    double kdr = dogruSayisi/yanlisSayisi;
    return kdr;
  }

}


import 'package:flutter/cupertino.dart';

class Datas extends ChangeNotifier{
 bool _loggedin =false;
 List<int> fav=[];
 bool get loggedin =>_loggedin;

 void login_out(){
  _loggedin=!_loggedin;
  notifyListeners();
 }
 void add_to_fav(int index)
 {
  fav.add(index);
  print(fav);
 }

 void sub_from_fav(int index)
 {
  fav.remove(index);
  print(fav);
 }
}
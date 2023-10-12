

import 'package:tracker_app/model/User.dart';

class Pointing {
  Pointing({required this.user,required this.date});

  final User user;
  final DateTime date;
  final List<DateTime> pointingIn = [];
  final List<DateTime> pointingOut = [];


  void addPointingIn (){
    if(pointingIn.length<2 && pointingIn.length <= pointingOut.length){
      pointingIn.add(DateTime.now());
    }
    else{
      print("too much");
    }

  }

    void addPointingOut (){
    if(pointingOut.length<2 && pointingOut.length <= pointingIn.length){
      pointingOut.add(DateTime.now());
    }
    else{
      print("too much");
    }
  }
}
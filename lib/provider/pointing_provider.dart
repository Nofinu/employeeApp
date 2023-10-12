import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/pointing.dart';
import 'package:tracker_app/provider/auth_provider.dart';

class PointingNotifier extends StateNotifier<List<Pointing>> {
  PointingNotifier(this.ref) : super([]);
  StateNotifierProviderRef<PointingNotifier, List<Pointing>> ref ;

  void createPointing(User user,Pointing pointing) {
    state = ([...state, pointing]);
  }

  void addPointing(String type) {
    User user = ref.watch(authProvider);
    Pointing pointingEdit;
    int index ;
    List<Pointing> pointingList = state;
    bool testIsDone = false;
    for(Pointing pointing in pointingList){
      if(user == pointing.user && DateUtils.isSameDay(DateTime.now(), pointing.date)){
        index = pointingList.indexOf(pointing);
        pointingEdit = pointing;
        type == "in"? pointingEdit.addPointingIn() : pointingEdit.addPointingOut();
        pointingList.replaceRange(index, index+1, [pointingEdit]);
        testIsDone = true;
      }
    }
    if(!testIsDone){
      Pointing newPointing = Pointing(user: user, date: DateTime.now());
      newPointing.addPointingIn();
      pointingList.add(newPointing);
    }
    state = pointingList;
  }
}

final pointingProvider =
    StateNotifierProvider<PointingNotifier, List<Pointing>>(
        (ref) => PointingNotifier(ref));

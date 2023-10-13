import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/avatar.dart';

class PointingNotifier extends StateNotifier<List<Pointing>> {
  PointingNotifier(this.ref) : super(getPointing());
  StateNotifierProviderRef<PointingNotifier, List<Pointing>> ref;

  void createPointing(User user, Pointing pointing) {
    state = (<Pointing>[...state, pointing]);
  }

  void addPointing(String type) {
    User user = ref.watch<User>(authProvider);
    Pointing pointingEdit;
    int index;
    List<Pointing> pointingList = state;
    bool testIsDone = false;
    for (Pointing pointing in pointingList) {
      if (user == pointing.user &&
          DateUtils.isSameDay(DateTime.now(), pointing.date)) {
        index = pointingList.indexOf(pointing);
        pointingEdit = pointing;
        type == "in"
            ? pointingEdit.addPointingHour(PointingType.inPointing)
            : pointingEdit.addPointingHour(PointingType.outPointing);
        pointingList.replaceRange(index, index + 1, <Pointing>[pointingEdit]);
        testIsDone = true;
      }
    }
    if (!testIsDone) {
      Pointing newPointing = Pointing(user: user, date: DateTime.now());
      newPointing.addPointingHour(PointingType.inPointing);
      pointingList.add(newPointing);
    }
    state = pointingList;
  }

  List<Avatar> getAvatarFromList(double width) {
    User user = ref.watch<User>(authProvider);
    List<Avatar> avatars = [];
    for (Pointing pointing in state) {
      if (user != pointing.user &&
          DateUtils.isSameDay(DateTime.now(), pointing.date) &&
          pointing.pointingList[pointing.pointingList.length - 1].typeOfPointing == PointingType.inPointing) {
        avatars.add(
          Avatar(user: pointing.user, radius: width),
        );
      }
    }
    return avatars;
  }
}

final pointingProvider =
    StateNotifierProvider<PointingNotifier, List<Pointing>>(
        (ref) => PointingNotifier(ref));

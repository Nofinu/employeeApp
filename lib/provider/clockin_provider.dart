import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/clockin/clockin_hour.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/avatar.dart';

class ClockinNotifier extends StateNotifier<List<Clockin>> {
  ClockinNotifier(this.ref) : super(getPointing());
  StateNotifierProviderRef<ClockinNotifier, List<Clockin>> ref;

  void createClockin(User user, Clockin clockin) {
    state = (<Clockin>[...state, clockin]);
  }

  void addClockin(String type) {
    User user = ref.watch<User>(authProvider);
    Clockin clockinEdit;
    int index;
    List<Clockin> clockinList = state;
    bool testIsDone = false;
    for (Clockin clockin in clockinList) {
      if (user == clockin.user &&
          DateUtils.isSameDay(DateTime.now(), clockin.date)) {
        index = clockinList.indexOf(clockin);
        clockinEdit = clockin;
        type == "in"
            ? clockinEdit.addClockinHour(ClockinType.clockIn)
            : clockinEdit.addClockinHour(ClockinType.clockOut);
        clockinList.replaceRange(index, index + 1, <Clockin>[clockinEdit]);
        testIsDone = true;
      }
    }
    if (!testIsDone) {
      Clockin newClockin = Clockin(user: user, date: DateTime.now());
      newClockin.addClockinHour(ClockinType.clockIn);
      pointingList.add(newClockin);
    }
    state = pointingList;
  }

  List<Avatar> getAvatarFromList(double width) {
    User user = ref.watch<User>(authProvider);
    List<Avatar> avatars = [];
    for (Clockin clockin in state) {
      if (user != clockin.user &&
          DateUtils.isSameDay(DateTime.now(), clockin.date) &&
          clockin.clockinList[clockin.clockinList.length - 1]
                  .typeOfPointing ==
              ClockinType.clockIn) {
        avatars.add(
          Avatar(
            user: clockin.user,
            radius: width,
            isCircle: false,
          ),
        );
      }
    }
    return avatars;
  }

  Clockin getClockinToday() {
    User user = ref.watch<User>(authProvider);
    for (Clockin clockin in state) {
      if (user == clockin.user &&
          DateUtils.isSameDay(DateTime.now(), clockin.date)) {
        return clockin;
      }
    }
    return Clockin(user: user, date: DateTime.now());
  }

  String getTotalWorkHours(Clockin clockin) {
    String content = "00h00";
    if (clockin.clockinList.length >= 2) {
      final differenceAm = clockin.clockinList[1].hour
          .difference(clockin.clockinList[0].hour);
      if (clockin.clockinList.length == 4) {
        final differencePm = clockin.clockinList[3].hour
            .difference(clockin.clockinList[2].hour);
        final totalDiff = differenceAm + differencePm;
        int hours = totalDiff.inHours;
        int minutes = totalDiff.inMinutes%60;
  
        List<String> hoursAndMinutes = _getHoursAndMinInStr(hours, minutes);
        content = "${hoursAndMinutes[0]}h${hoursAndMinutes[1]}";
      } else {
        List<String> hoursAndMinutes = _getHoursAndMinInStr(
            differenceAm.inHours, (differenceAm.inMinutes % 60));
        content = "${hoursAndMinutes[0]}h${hoursAndMinutes[1]}";
      }
    }

    return content;
  }

  List<String> _getHoursAndMinInStr(int hours, int minutes) {
    List<String> hoursAndMinutes = [];
    String hoursStr;
    String minutesStr;
    if (hours < 10) {
      hoursStr = "0$hours";
    } else {
      hoursStr = hours.toString();
    }

    if (minutes < 10) {
      minutesStr = "0$minutes";
    } else {
      minutesStr = minutes.toString();
    }
    hoursAndMinutes.add(hoursStr);
    hoursAndMinutes.add(minutesStr);
    return hoursAndMinutes;
  }
}

final clockinProvider =
    StateNotifierProvider<ClockinNotifier, List<Clockin>>(
        (ref) => ClockinNotifier(ref));

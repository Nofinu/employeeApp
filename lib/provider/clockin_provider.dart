import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/avatar.dart';
import 'package:http/http.dart' as http;

class ClockinNotifier extends StateNotifier<List<Clockin>> {
  ClockinNotifier(this.ref) : super([]);

  StateNotifierProviderRef<ClockinNotifier, List<Clockin>> ref;

  void setClockIn() async {
    User user = ref.watch(authProvider);
    var response = await http.get(
        Uri.parse("http://localhost:8080/api/clockin/today_clockin/${user.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      List<Clockin> clockins = [];
      clockins = List<Clockin>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Clockin>((value) => Clockin.fromJson(value))
          .toList());
      state = clockins;
    }
  }

  bool isClockin() {
    if (state.isNotEmpty) {
      if (state[state.length - 1].clockOutHour == null) {
        return true;
      }
    }
    return false;
  }

  void createClockin() async {
    User user = ref.watch(authProvider);
    var response = await http.get(
        Uri.parse("http://localhost:8080/api/clockin/${user.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Clockin clockin = Clockin.fromJson(jsonDecode(response.body));
      state = [...state, clockin];
    }
  }

  void setClockOut() async {
    Clockin clockinFind = state[state.length - 1];
    var response = await http.get(
        Uri.parse(
            "http://localhost:8080/api/clockin/clockout/${clockinFind.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Clockin clockin = Clockin.fromJson(jsonDecode(response.body));
      List<Clockin> clockins = [...state];
      clockins.removeLast();
      clockins.add(clockin);
      state = clockins;
    }
  }

      Future<List<Clockin>> getUserActive() async {
      var response = await http.get(
          Uri.parse("http://localhost:8080/api/clockin/notclosed"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      List<Clockin> clockins = [];
      if (response.statusCode == 200) {
        clockins = List<Clockin>.from(
            (jsonDecode(response.body) as List<dynamic>)
                .map<Clockin>((value) => Clockin.fromJson(value))
                .toList());
                print(clockins.length);
      }
      return clockins;
    }

  // List<Avatar> getAvatarFromList(double width) {
  //   User user = ref.watch<User>(authProvider);
  //   List<Avatar> avatars = [];
  //   for (Clockin clockin in state) {
  //     if (user != clockin.user &&
  //         DateUtils.isSameDay(DateTime.now(), clockin.date) &&
  //         clockin.clockinList[clockin.clockinList.length - 1]
  //                 .typeOfPointing ==
  //             ClockinType.clockIn) {
  //       avatars.add(
  //         Avatar(
  //           user: clockin.user,
  //           radius: width,
  //           isCircle: false,
  //         ),
  //       );
  //     }
  //   }
  //   return avatars;
  // }

  // String getTotalWorkHours(Clockin clockin) {
  //   String content = "00h00";
  //   if (clockin.clockinList.length >= 2) {
  //     final differenceAm = clockin.clockinList[1].hour
  //         .difference(clockin.clockinList[0].hour);
  //     if (clockin.clockinList.length == 4) {
  //       final differencePm = clockin.clockinList[3].hour
  //           .difference(clockin.clockinList[2].hour);
  //       final totalDiff = differenceAm + differencePm;
  //       int hours = totalDiff.inHours;
  //       int minutes = totalDiff.inMinutes%60;

  //       List<String> hoursAndMinutes = _getHoursAndMinInStr(hours, minutes);
  //       content = "${hoursAndMinutes[0]}h${hoursAndMinutes[1]}";
  //     } else {
  //       List<String> hoursAndMinutes = _getHoursAndMinInStr(
  //           differenceAm.inHours, (differenceAm.inMinutes % 60));
  //       content = "${hoursAndMinutes[0]}h${hoursAndMinutes[1]}";
  //     }
  //   }

  //   return content;
  // }

  // List<String> _getHoursAndMinInStr(int hours, int minutes) {
  //   List<String> hoursAndMinutes = [];
  //   String hoursStr;
  //   String minutesStr;
  //   if (hours < 10) {
  //     hoursStr = "0$hours";
  //   } else {
  //     hoursStr = hours.toString();
  //   }

  //   if (minutes < 10) {
  //     minutesStr = "0$minutes";
  //   } else {
  //     minutesStr = minutes.toString();
  //   }
  //   hoursAndMinutes.add(hoursStr);
  //   hoursAndMinutes.add(minutesStr);
  //   return hoursAndMinutes;
  // }
}

final clockinProvider = StateNotifierProvider<ClockinNotifier, List<Clockin>>(
    (ref) => ClockinNotifier(ref));

import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/exception/time_exception.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:http/http.dart' as http;

const String url = "http://localhost:8080/api/clockin";

class ClockinNotifier extends StateNotifier<List<Clockin>> {
  ClockinNotifier(this.ref) : super([]);

  StateNotifierProviderRef<ClockinNotifier, List<Clockin>> ref;

  void setClockIn() async {
    User user = ref.watch(authProvider);
    var response = await http.get(Uri.parse("$url/today_clockin/${user.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

print("test clockin");
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
    var response =
        await http.get(Uri.parse("$url/${user.id}"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      Clockin clockin = Clockin.fromJson(jsonDecode(response.body));
      state = [...state, clockin];
    }
  }

  Future setClockOut() async {
    User user = ref.watch(authProvider);
    Clockin clockinFind = state[state.length - 1];
    var response = await http.get(
        Uri.parse("$url/clockout/${user.id}/${clockinFind.id}"),
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
    if (response.statusCode == 401) {
      throw TimeException(response.body);
    }
  }

  void test(String response) {
    Clockin clockin = Clockin.fromJson(jsonDecode(response));
    List<Clockin> clockins = [...state];
    clockins.removeLast();
    clockins.add(clockin);
    state = clockins;
  }

  Future<List<Clockin>> getUserActive() async {
    User user = ref.watch(authProvider);
    var response = await http
        .get(Uri.parse("$url/notclosed/${user.id}"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    List<Clockin> clockins = [];
    if (response.statusCode == 200) {
      clockins = List<Clockin>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Clockin>((value) => Clockin.fromJson(value))
          .toList());
    }
    return clockins;
  }

  Future<int> getTodayWorkinHours() async {
    User user = ref.watch(authProvider);
    DateTime date = DateTime.now();
    var response = await http.get(
        Uri.parse(
            "$url/hours_worked_day/${user.id}/${date.day}-${date.month}-${date.year}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    int value = 0;
    if (response.statusCode == 200) {
      value = jsonDecode(response.body) as int;
    }
    return value;
  }

  Future<int> getWeekWorkinHours() async {
    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

    final date = DateTime.now();
    DateTime dateStart =
        getDate(date.subtract(Duration(days: date.weekday - 1)));
    DateTime dateEnd =
        getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
    User user = ref.watch(authProvider);

    var response = await http.get(
        Uri.parse(
            "$url/hours_worked_week/${user.id}/${dateStart.day}-${dateStart.month}-${dateStart.year}/${dateEnd.day}-${dateEnd.month}-${dateEnd.year}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    int value = 0;
    if (response.statusCode == 200) {
      value = jsonDecode(response.body) as int;
    }
    return value;
  }

  Future<List<Clockin>> getClockinByWeek() async {
    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

    final date = DateTime.now();
    DateTime dateStart =
        getDate(date.subtract(Duration(days: date.weekday - 1)));
    DateTime dateEnd =
        getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
    User user = ref.watch(authProvider);

    var response = await http.get(
        Uri.parse(
            "$url/clockin_by_week/${user.id}/${dateStart.day}-${dateStart.month}-${dateStart.year}/${dateEnd.day}-${dateEnd.month}-${dateEnd.year}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    List<Clockin> clockins = [];
    if (response.statusCode == 200) {
      clockins = List<Clockin>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Clockin>((value) => Clockin.fromJson(value))
          .toList());
    }
    return clockins;
  }
}

final clockinProvider = StateNotifierProvider<ClockinNotifier, List<Clockin>>(
    (ref) => ClockinNotifier(ref));

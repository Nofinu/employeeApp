import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_app/model/fake_day.dart';

class DayNotifier extends StateNotifier<List<FakeDay>> {
  DayNotifier() : super([]);

  void getfakeDay() async {
    var response = await http.get(
        Uri.parse("http://localhost:8080/api/fakedata/dayweek"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
        print(response.body);
    List<FakeDay> fake_day = [];
    if (response.statusCode == 200) {
      fake_day = List<FakeDay>.from((jsonDecode(response.body) as List<dynamic>)
          .map<FakeDay>((value) => FakeDay.fromJson(value))
          .toList());
          for(int i = 0; i<fake_day.length;i++){
            fake_day[i].users.length;
          }
          state = fake_day;
    } 
  }
}

final dayProvider =
    StateNotifierProvider<DayNotifier, List<FakeDay>>((ref) => DayNotifier());

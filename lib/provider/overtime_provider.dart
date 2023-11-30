import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:http/http.dart' as http;

const String url = "http://localhost:8080/api/overtime";

class OvertimeNotifier extends StateNotifier<List<Overtime>> {
  OvertimeNotifier(this.ref) : super([]);

    StateNotifierProviderRef<OvertimeNotifier, List<Overtime>> ref;

  void getOvertimeFromUser () async{
     var user = ref.watch(authProvider);
     String request = user.isAdmin ?"$url/all"  :"$url/user_overtime/${user.id}";
    var response = await http.get(Uri.parse(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
        
    if (response.statusCode == 200) {
      List<Overtime> overtimes = [];
      overtimes = List<Overtime>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Overtime>((value) => Overtime.fromJson(value))
          .toList());
      state = overtimes;
    }
  }


  void setValidationOnRequest(Overtime overtime, bool validation) async{
    var response = await http.get(Uri.parse("$url/isvalidated/${overtime.id}/$validation"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Overtime overtimeUpdate = Overtime.fromJson(jsonDecode(response.body));
      List<Overtime> overtimes = [...state];
      int index = overtimes.indexWhere((overtime) => overtime.id == overtimeUpdate.id);
      overtimes.replaceRange(index, index+1, [overtimeUpdate]);
      state = overtimes;
    }
  }


  void addMessage(Overtime overtime) async {
 var response = await http.post(
        Uri.parse('$url/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, dynamic>{"title": overtime.title, "detail": overtime.detail,"writer":overtime.writer.id,"nbrHours":overtime.nbrHours,"dateOvertime":"${overtime.dateOvertime.day}-${overtime.dateOvertime.month}-${overtime.dateOvertime.year}"}));

    if (response.statusCode == 200) {
        Overtime overtime = Overtime.fromJson(jsonDecode(response.body));
        state = [...state,overtime];
    }
  }

  void setViewMessage(Overtime overtime) async {
    var response = await http.get(Uri.parse("$url/isview/${overtime.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Overtime overtimeUpdate = Overtime.fromJson(jsonDecode(response.body));
      List<Overtime> overtimes = [...state];
      int index = overtimes.indexWhere((overtime) => overtime.id == overtimeUpdate.id);
      overtimes.replaceRange(index, index+1, [overtimeUpdate]);
      state = overtimes;
    }
  }
}

final overtimeProvider =
    StateNotifierProvider<OvertimeNotifier, List<Overtime>>(
        (ref) => OvertimeNotifier(ref));

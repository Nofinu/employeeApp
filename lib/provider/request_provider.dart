import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:http/http.dart' as http;

const String url = "http://localhost:8080/api/request";

class RequestNotifier extends StateNotifier<List<Request>> {
  RequestNotifier(this.ref) : super([]);

     StateNotifierProviderRef<RequestNotifier, List<Request>> ref;

    void getRequestFromUser () async{
     var user = ref.watch(authProvider);
     String request = user.isAdmin ?"$url/all"  :"$url/user_request/${user.id}";
    var response = await http.get(Uri.parse(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      List<Request> requests = [];
      requests = List<Request>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Request>((value) => Request.fromJson(value))
          .toList());
      state = requests;
    }
  }


  void setValidationOnRequest(Request request, bool validation) async{
    var response = await http.get(Uri.parse("$url/isvalidated/${request.id}/$validation"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Request requestUpdate = Request.fromJson(jsonDecode(response.body));
      List<Request> requests = [...state];
      int index = requests.indexWhere((request) => request.id == requestUpdate.id);
      requests.replaceRange(index, index+1, [requestUpdate]);
      state = requests;
    }
  }


  void addMessage(Request request) async {
 var response = await http.post(
        Uri.parse('$url/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, dynamic>{"title": request.title, "detail": request.detail,"writer":request.writer.id,"requestDate":"${request.requestDate.day}-${request.requestDate.month}-${request.requestDate.year}"}));

    if (response.statusCode == 200) {
        Request request = Request.fromJson(jsonDecode(response.body));
        state = [...state,request];
    }
  }

  void setViewMessage(Request request) async {
    var response = await http.get(Uri.parse("$url/isview/${request.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Request requestUpdate = Request.fromJson(jsonDecode(response.body));
      List<Request> requests = [...state];
      int index = requests.indexWhere((request) => request.id == requestUpdate.id);
      requests.replaceRange(index, index+1, [requestUpdate]);
      state = requests;
    }
  }
}

final requestProvider = StateNotifierProvider<RequestNotifier, List<Request>>(
    (ref) => RequestNotifier(ref));

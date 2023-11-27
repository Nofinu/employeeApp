import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/issue.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';

const String url = "http://localhost:8080/api/issue";

class IssueNotifier extends StateNotifier<List<Issue>> {
  IssueNotifier(this.ref) : super([]);

    StateNotifierProviderRef<IssueNotifier, List<Issue>> ref;

  void getIssueFromUser () async{
     User user = ref.watch(authProvider);
     String request = user.isAdmin ?"$url/all"  :"$url/user_issue/${user.id}";
    var response = await http.get(Uri.parse(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      List<Issue> issues = [];
      issues = List<Issue>.from((jsonDecode(response.body) as List<dynamic>)
          .map<Issue>((value) => Issue.fromJson(value))
          .toList());
      state = issues;
    }
  }


  void setValidationOnRequest(Issue issue, bool validation) async{
    var response = await http.get(Uri.parse("$url/isvalidated/${issue.id}/$validation"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Issue issueUpdate = Issue.fromJson(jsonDecode(response.body));
      List<Issue> issues = [...state];
      int index = issues.indexWhere((issue) => issue.id == issueUpdate.id);
      issues.replaceRange(index, index+1, [issueUpdate]);
      state = issues;
    }
  }


  void addMessage(Issue issue) async {
 var response = await http.post(
        Uri.parse('http://localhost:8080/api/issue/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, dynamic>{"title": issue.title, "detail": issue.detail,"writer":issue.writer.id,"priority":issue.priority.toString(),"privacy":issue.privacy.toString()}));

    if (response.statusCode == 200) {
        Issue issue = Issue.fromJson(jsonDecode(response.body));
        state = [...state,issue];
    }
  }

  void setViewMessage(Issue issue) async {
    var response = await http.get(Uri.parse("$url/isview/${issue.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Issue issueUpdate = Issue.fromJson(jsonDecode(response.body));
      List<Issue> issues = [...state];
      int index = issues.indexWhere((issue) => issue.id == issueUpdate.id);
      issues.replaceRange(index, index+1, [issueUpdate]);
      state = issues;
    }
  }
}

final issueProvider =
    StateNotifierProvider<IssueNotifier, List<Issue>>(
        (ref) => IssueNotifier(ref));

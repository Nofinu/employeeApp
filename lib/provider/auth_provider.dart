import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/user.dart';
import 'package:http/http.dart' as http;

class AuthNotifier extends StateNotifier<User> {
  AuthNotifier() : super( User(0, "", "", "", false, ""));

  Future<bool> connection(String email, String password) async {
    var response = await http.post(
        Uri.parse('http://localhost:8080/api/Authentication/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));

    if (response.statusCode == 200) {
      var responseDeco = jsonDecode(response.body);
      if(responseDeco["isAuthSuccessful"] as bool){
        User user = User.fromJson(responseDeco['userDTO'] as Map<String, dynamic>);
        user.token = responseDeco['token'];
        state = user;
        return true;
      }
      return false;
    }

    return false;
  }

  void setUser(User user) {
    state = user;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, User>((ref) => AuthNotifier());

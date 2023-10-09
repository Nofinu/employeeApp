import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/User.dart';

class AuthNotifier extends StateNotifier<User> {
  AuthNotifier() : super(const User("", "", "", false, "", ""));

  void setUser(User user){
    state = user;
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, User>(
    (ref) => AuthNotifier());

import 'package:flutter/material.dart';
import 'package:tracker_app/model/User.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.index, this.user, this.users,required this.radius});

  final User? user;
  final List<User>? users;
  final int? index;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user != null
          ? user!.imageUrl
          : (users != null && index != null)
              ? users![index!].imageUrl
              : ""),
      radius: radius,
    );
  }
}

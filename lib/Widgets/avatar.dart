import 'package:flutter/material.dart';
import 'package:tracker_app/model/user.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.index, this.user, this.users,required this.radius, this.isCircle = true});

  final User? user;
  final List<User>? users;
  final int? index;
  final double radius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    if(isCircle){
      return CircleAvatar(
        backgroundImage: NetworkImage(user != null
            ? user!.imageUrl
            : (users != null && index != null)
                ? users![index!].imageUrl
                : ""),
        radius: radius,
      );
    }
    else{
      return Container(
              width: radius,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.onBackground),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(user != null
            ? user!.imageUrl
            : (users != null && index != null)
                ? users![index!].imageUrl
                : ""),
                  fit: BoxFit.contain,
                ),
              ),
            );
    }
  }
}

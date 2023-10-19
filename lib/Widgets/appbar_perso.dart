import 'package:flutter/material.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/widgets/avatar.dart';

class AppBarPerso extends AppBar {
  AppBarPerso(User user, String title, BuildContext context)
      : super(
          toolbarHeight: 80,
          centerTitle: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Avatar(
                  radius: 70,
                  user: user,
                  isCircle: false,
                ),
              ),
            ),
          ],
        );
}

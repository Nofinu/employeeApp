import 'package:flutter/material.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/widgets/avatar.dart';

class Generator {

  List<Widget> buildIconRow(int nbrPerson, List<User> users, double radius) {
    List<Widget> lines = [];
    List<Widget> iconForLine = [];

    if (nbrPerson == 1) {
      lines.add(
        Row(
          children: [Avatar(index:0,users: users,radius: radius)],
        ),
      );

      return lines;
    }
    for (var i = 0; i < nbrPerson - 1; i++) {
      if (i % 3 == 0) {
        if (i != 0) {
          lines.add(
            Row(
              children: iconForLine,
            ),
          );
          lines.add(
            const SizedBox(
              height: 8,
            ),
          );
        }
        iconForLine = [];
        iconForLine.add(Avatar(index:i,users: users,radius: radius));
        iconForLine.add(const SizedBox(
          width: 8,
        ));
      }
      iconForLine.add(Avatar(index:i,users: users,radius: radius));
      iconForLine.add(const SizedBox(
        width: 8,
      ));
    }
    lines.add(
      Row(
        children: iconForLine,
      ),
    );
    return lines;
  }
}

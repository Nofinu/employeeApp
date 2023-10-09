import 'package:flutter/material.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/fake_day.dart';

class Generator {

  CircleAvatar generateIcon(int index, List<User> users, double radius) {
    CircleAvatar icon = CircleAvatar(
      backgroundImage: NetworkImage(users[index].imageUrl),
      radius: radius,
    );
    return icon;
  }

  List<Widget> buildIconRow(int nbrPerson, List<User> users, double radius) {
    List<Widget> lines = [];
    List<Widget> iconForLine = [];

    if (nbrPerson == 1) {
      lines.add(
        Row(
          children: [generateIcon(0, users, radius)],
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
        iconForLine.add(generateIcon(i, users, radius));
        iconForLine.add(const SizedBox(
          width: 8,
        ));
      }
      iconForLine.add(generateIcon(i, users, radius));
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

  
    String toUpperCase(String value) {
      var letter = value[0];
      return value.replaceFirst(value[0], letter.toUpperCase());
    }

  Container generateTypeOfWork (FakeDay fakeday){
    return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: fakeday.repos
                        ? Colors.grey
                        : ((fakeday.type == TypeOfWork.dev ||
                                fakeday.type == TypeOfWork.preparation)
                            ? Colors.green
                            : Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    fakeday.repos ? "Repos" : toUpperCase(fakeday.type.name),
                    style: const TextStyle(fontSize: 20),
                  ),
                );
  }
}

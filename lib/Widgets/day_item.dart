import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/presenceManagement/presence_management_detail.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/util/generator.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.day,
    required this.fakeday,
  });

  final FakeDay fakeday;
  final String day;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    String toUpperCase(String value) {
      String letter = value[0];
      return value.replaceFirst(value[0], letter.toUpperCase());
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                PresenceManagementDetailScreen(planing: fakeday, day: day),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.8,
        margin:
            EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.1),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(66, 0, 0, 0),
                blurRadius: 5,
                offset: Offset(5, 10),
                spreadRadius: 0.1,
                blurStyle: BlurStyle.normal),
          ],
          color: const Color.fromARGB(255, 240, 239, 239),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    day,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
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
                ),
              ],
            ),
            ...Generator()
                .buildIconRow(fakeday.users.length, fakeday.users, 30),
          ],
        ),
      ),
    );
  }
}

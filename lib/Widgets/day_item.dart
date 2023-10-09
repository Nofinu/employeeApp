import 'package:flutter/material.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/User.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.typeOfWork,
    required this.repos,
    this.formation,
    required this.day,
    required this.users,
  });
  
  final String typeOfWork;
  final bool repos;
  final String? formation;
  final String day;
  final List<User> users;

CircleAvatar generateIcon (int index){
     CircleAvatar icon = CircleAvatar(
    backgroundImage: NetworkImage(user[index].imageUrl),
    radius: 30,
  );
  return icon;
}
 

  List<Widget> buildIconRow(int nbrPerson) {
    List<Widget> lines = [];
    List<Widget> iconForLine = [];

    if (nbrPerson == 1) {
      lines.add(
        Row(
          children: [generateIcon(0)],
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
        }
        iconForLine = [];
        iconForLine.add(generateIcon(i));
      }
      iconForLine.add(generateIcon(i));
    }
    lines.add(
      Row(
        children: iconForLine,
      ),
    );
    return lines;
  }
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    String toUpperCase(String value) {
      var letter = value[0];
      return value.replaceFirst(value[0], letter.toUpperCase());
    }

    return Container(
      width: screenWidth * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.1),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 10
                ,
                offset: Offset(5, 10),
                spreadRadius: 0.1,
                blurStyle: BlurStyle.normal),
          ],
          color: const Color.fromARGB(255, 240, 239, 239),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  color: repos
                      ? Colors.grey
                      : ((typeOfWork == "dev" || typeOfWork == "preparation")
                          ? Colors.green
                          : Colors.red),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  repos ? "Repos" : toUpperCase(typeOfWork),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          ...buildIconRow(users.length),
        ],
      ),
    );
  }
}

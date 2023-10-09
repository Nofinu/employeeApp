import 'package:flutter/material.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/widgets/day_item.dart';

class PresenceManagementScreen extends StatelessWidget {
  const PresenceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listeDay = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"];
    List<FakeDay> semaineList = semaine;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Gestion Pressence",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < listeDay.length; i++)
              DayItem(
                typeOfWork: semaineList[i].type.name,
                repos: semaineList[i].repos,
                day: listeDay[i],
                formation: semaineList[i].formation ?? semaineList[i].formation,
                users: semaineList[i].users,
              ),
          ],
        ),
      ),
    );
  }
}

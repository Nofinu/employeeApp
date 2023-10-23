import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/day_item.dart';

class PresenceManagementScreen extends ConsumerWidget {
  const PresenceManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listeDay = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"];
    List<FakeDay> semaineList = semaine;

    return Scaffold(
      appBar:
          AppBarPerso(ref.watch(authProvider), "Team Tracker", context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).colorScheme.primary,
                    size: 70,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Semaine du",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${semaine[0].getDate()} au ${semaine[semaine.length - 1].getDate()}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            for (var i = 0; i < listeDay.length; i++)
              DayItem(
                day: listeDay[i],
                fakeday: semaineList[i],
              ),
          ],
        ),
      ),
    );
  }
}

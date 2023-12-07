import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/day_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/day_item.dart';

class PresenceManagementScreen extends ConsumerWidget {
  const PresenceManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listeDay = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"];
    List<FakeDay> semaineList = ref.watch(dayProvider);
    print(semaineList.length);
  

    return Scaffold(
      appBar: AppBarPerso(ref.watch(authProvider), "Team Tracker", context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: const Size(100, 50),
                ),
                color: Theme.of(context).colorScheme.onPrimary,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              IconButton(
                 style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: const Size(100, 50),
                ),
                color: Theme.of(context).colorScheme.onPrimary,
                icon: const Icon(Icons.arrow_forward_outlined),
                onPressed: () {},
              )
            ],
      ),
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
                      "${semaineList[0].getDate()} au ${semaineList[semaineList.length - 1].getDate()}",
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

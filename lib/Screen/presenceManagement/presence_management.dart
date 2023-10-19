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
  Widget build(BuildContext context,WidgetRef ref) {
    final listeDay = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"];
    List<FakeDay> semaineList = semaine;

    return Scaffold(
      appBar: AppBarPerso(ref.watch(authProvider), "Gestion pressence", context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/clockin_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/clockin_show_item.dart';

class GlobalClockinScreen extends ConsumerStatefulWidget {
  const GlobalClockinScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GlobalClockinScreenState();
  }
}

class _GlobalClockinScreenState extends ConsumerState<GlobalClockinScreen> {
  List<Clockin> clockins = [];

  List<ClockinShowItem> setClockinByDay() {
    List<ClockinShowItem> clockinShowItems = [];
    if (clockins.isNotEmpty && clockins.length % 2 == 1) {
      for (int i = 1; i < clockins.length; i += 2) {
        if (clockins[i - 1].clockInHour.day != clockins[i].clockInHour.day) {
        } else {
          clockinShowItems.add(ClockinShowItem(
            clockinMorning: clockins[i - 1],
            clockinAfterNoon: clockins[i],
          ));
        }
      }
      clockinShowItems.add(ClockinShowItem(
        clockinMorning: clockins[clockins.length - 1],
      ));
    } else if (clockins.isNotEmpty) {
      for (int i = 1; i < clockins.length; i += 2) {
        if (clockins[i - 1].clockInHour.day != clockins[i].clockInHour.day) {
        } else {
          clockinShowItems.add(ClockinShowItem(
            clockinMorning: clockins[i - 1],
            clockinAfterNoon: clockins[i],
          ));
        }
      }
    }

    return clockinShowItems;
  }

  @override
  void initState() {
    Timer.run(() {
            ref.read(clockinProvider.notifier).getClockinByWeek().then((value) => {
            setState(() {
              clockins = value;
            })
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    User user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBarPerso(user, "Pointage", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            children: setClockinByDay(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/clockin/clockin_hour.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/clockin_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/clockin_hour.dart';

class ClockinScreen extends ConsumerStatefulWidget {
  const ClockinScreen({super.key});

  @override
  ConsumerState<ClockinScreen> createState() {
    return _ClockinScreenState();
  }
}

class _ClockinScreenState extends ConsumerState<ClockinScreen> {
  bool checked = false;

  List<ClockinHourWidget> getClockinHourWidget(
      Clockin clockin, double screenWidth) {
    List<ClockinHourWidget> clockinHoursWidgets = [];
    int cpt = 0;
    if (clockin.clockinList.isNotEmpty) {
      for (ClockinHour clockinHour in clockin.clockinList) {
        clockinHoursWidgets.add(
          ClockinHourWidget(
            width: screenWidth * 0.15,
            marginRight: 15,
            content: "${clockinHour.hour.hour}h${clockinHour.hour.minute}",
          ),
        );
        cpt++;
      }
    }
    for (int i = cpt; i < 4; i++) {
      clockinHoursWidgets.add(
        ClockinHourWidget(
          width: screenWidth * 0.15,
          marginRight: 15,
          content: "",
        ),
      );
    }
    return clockinHoursWidgets;
  }

  @override
  Widget build(BuildContext context) {
//Color.fromRGBO(0, 194, 8, 1)
    final Clockin clockin =
        ref.watch(clockinProvider.notifier).getClockinToday();

    if(clockin.clockinList.length % 2 == 1){
      setState(() {
        checked = true;
      });
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final User user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBarPerso(user,"Pointage",context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (!checked) {
                    ref.watch(clockinProvider.notifier).addClockin("in");
                  } else {
                    ref.watch(clockinProvider.notifier).addClockin("out");
                  }
                  setState(() {
                    checked = !checked;
                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(210, 210),
                  elevation: 25,
                  backgroundColor: checked
                      ? Colors.red
                      : const Color.fromRGBO(51, 215, 24, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  checked ? "Sortir" : "Enter",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Heures travaillées : ${ref.watch(clockinProvider.notifier).getTotalWorkHours(clockin)}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getClockinHourWidget(clockin, screenWidth)),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Total des heures semaine : 34:30:00",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Text(
                            "Qui est disponible ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          runSpacing: 15,
                          children: ref
                              .watch(clockinProvider.notifier)
                              .getAvatarFromList(screenWidth * 0.16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Widgets/avatar.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
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
  List<Avatar> avatars = [];

  

  List<ClockinHourWidget> getClockinHourWidget(
      List<Clockin> clockins, double screenWidth) {
    List<ClockinHourWidget> clockinHoursWidgets = [];
    int cpt = 0;
    if (clockins.isNotEmpty) {
      for (Clockin clockin in clockins) {
        clockinHoursWidgets.add(
          ClockinHourWidget(
            width: screenWidth * 0.15,
            marginRight: 15,
            content:
                "${clockin.clockInHour.hour}h${clockin.clockInHour.minute}",
          ),
        );
        if (clockin.clockOutHour != null) {
          clockinHoursWidgets.add(
            ClockinHourWidget(
              width: screenWidth * 0.15,
              marginRight: 15,
              content:
                  "${clockin.clockOutHour!.hour}h${clockin.clockOutHour!.minute}",
            ),
          );
          cpt++;
        }
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

  void setUserActive(double screenWidth) {
    ref
        .watch(clockinProvider.notifier)
        .getUserActive()
        .then((value) => setListOfAvatar(value, screenWidth));
  }

  void setListOfAvatar(List<Clockin> clockins, double screenWidth) {
    List<Avatar> avatarsList = [];
    for (Clockin clockin in clockins) {
      avatarsList.add(
        Avatar(
          radius: screenWidth * 0.1,
          user: user[clockin.userId],
        ),
      );
    }
    setState(() {
      avatars = avatarsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch(clockinProvider.notifier).setClockIn();
    checked = ref.watch(clockinProvider.notifier).isClockin();
    

    final double screenWidth = MediaQuery.of(context).size.width;
    final User user = ref.watch(authProvider);

  if(avatars.isEmpty){
    setUserActive(screenWidth);
  }
    

    return Scaffold(
      appBar: AppBarPerso(user, "Pointage", context),
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
                    ref.watch(clockinProvider.notifier).createClockin();
                  } else {
                    ref.watch(clockinProvider.notifier).setClockOut();
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
                "Heures travaillées : 5",
                // ${ref.watch(clockinProvider.notifier).getTotalWorkHours(clockin)}
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
                children: getClockinHourWidget(
                    ref.watch(clockinProvider), screenWidth),
              ),
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
                          children: avatars,
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

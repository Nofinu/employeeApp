import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Widgets/avatar.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/exception/time_exception.dart';
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
  int workingTimeDay = 0;
  int workingTimeWeek = 0;
  late Timer _timer;
  late Timer _workHourTimer;
  final view = PlatformDispatcher.instance.views.first;

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

  String getWorkingHours(int workTime) {
    int totalWorkHours = workTime;
    int workHours = (workTime / 3600).floor();
    totalWorkHours = workTime - workHours * 3600;
    int workMinutes = (totalWorkHours / 60).floor();
    totalWorkHours = totalWorkHours - workMinutes * 60;
    return "$workHours h ${workMinutes < 10 ? "0$workMinutes" : workMinutes} : ${totalWorkHours < 10 ? "0$totalWorkHours" : totalWorkHours}";
  }

  void showMessage(TimeException exception) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(exception.message)),
    );
  }

  @override
  void initState() {
    Timer.run(() {
      setUserActive(view.physicalSize.width / view.devicePixelRatio);
      checked = ref.watch(clockinProvider.notifier).isClockin();
      ref
          .watch(clockinProvider.notifier)
          .getTodayWorkinHours()
          .then((value) => {
                setState(() {
                  workingTimeDay = value;
                }),
              });
      ref.watch(clockinProvider.notifier).getWeekWorkinHours().then((value) => {
            setState(() {
              workingTimeWeek = value;
            }),
          });
    });
    _timer = Timer.periodic(const Duration(minutes: 5), (arg) {
      setUserActive(view.physicalSize.width / view.devicePixelRatio);
    });

    _workHourTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (checked) {
        setState(() {
          workingTimeDay += 1;
          workingTimeWeek += 1;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    if (_workHourTimer.isActive) {
      _workHourTimer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checked = ref.watch(clockinProvider.notifier).isClockin();

    final double screenWidth = MediaQuery.of(context).size.width;
    final User user = ref.watch(authProvider);

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
                    if (!_workHourTimer.isActive) {
                      _workHourTimer =
                          Timer.periodic(const Duration(seconds: 1), (timer) {
                        setState(() {
                          workingTimeDay += 1;
                          workingTimeWeek += 1;
                        });
                      });
                    }
                  } else {
                    ref
                        .watch(clockinProvider.notifier)
                        .setClockOut()
                        .then((value) => _workHourTimer.cancel())
                        .catchError((error) => {showMessage(error)});
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
                "Heures travaillées : ${getWorkingHours(workingTimeDay)}",
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
                "Total des heures semaine : ${getWorkingHours(workingTimeWeek)}",
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

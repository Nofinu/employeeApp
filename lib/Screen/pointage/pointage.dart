import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';
import 'package:tracker_app/provider/pointing_provider.dart';
import 'package:tracker_app/widgets/pointing_hour.dart';

class PointageScreen extends ConsumerStatefulWidget {
  const PointageScreen({super.key});

  @override
  ConsumerState<PointageScreen> createState() {
    return _PointageScreenState();
  }
}

class _PointageScreenState extends ConsumerState<PointageScreen> {
  bool checked = false;

  List<PointingHourWidget> getPointingHourWidget(
      Pointing pointing, double screenWidth) {
    List<PointingHourWidget> pointingHoursWidgets = [];
    int cpt = 0;
    if (pointing.pointingList.isNotEmpty) {
      for (PointingHour pointingHour in pointing.pointingList) {
        pointingHoursWidgets.add(
          PointingHourWidget(
            width: screenWidth * 0.15,
            marginRight: 15,
            content: "${pointingHour.hour.hour}h${pointingHour.hour.minute}",
          ),
        );
        cpt++;
      }
    }
    for (int i = cpt; i < 4; i++) {
      pointingHoursWidgets.add(
        PointingHourWidget(
          width: screenWidth * 0.15,
          marginRight: 15,
          content: "",
        ),
      );
    }
    return pointingHoursWidgets;
  }

  @override
  Widget build(BuildContext context) {
//Color.fromRGBO(0, 194, 8, 1)
    final Pointing pointing =
        ref.watch(pointingProvider.notifier).getPointingToday();

    final double screenWidth = MediaQuery.of(context).size.width;

      DateTime date1 = DateTime(2023, 10, 18, 9,05);
        DateTime date2 = DateTime(2023, 10, 18, 12, 35);
        final difference = date2.difference(date1);
        print("${difference.inHours}h${difference.inMinutes%60}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pointage",
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
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
                    ref.watch(pointingProvider.notifier).addPointing("in");
                  } else {
                    ref.watch(pointingProvider.notifier).addPointing("out");
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
                "Heures travaillées : ${ref.watch(pointingProvider.notifier).getTotalWorkHours(pointing)}",
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
                  children: getPointingHourWidget(pointing, screenWidth)),
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
                          // borderRadius: const BorderRadius.only(
                          //     topLeft: Radius.circular(14),
                          //     topRight: Radius.circular(14),),
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
                            vertical: 20, horizontal: 10),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          runSpacing: 15,
                          children: ref
                              .watch(pointingProvider.notifier)
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

import 'package:flutter/material.dart';
import 'package:tracker_app/Widgets/clockin_hour.dart';
import 'package:tracker_app/model/clockin/clockin.dart';

class ClockinShowItem extends StatelessWidget {
  const ClockinShowItem(
      {super.key, required this.clockinMorning, this.clockinAfterNoon});
  final Clockin clockinMorning;
  final Clockin? clockinAfterNoon;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
          color: Colors.brown, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                clockinMorning.getDateClockin(),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClockinHourWidget(
                    width: screenWidth * 0.15,
                    content: clockinMorning.getClockInHour(),
                    marginRight: 10,
                  ),
                  ClockinHourWidget(
                    width: screenWidth * 0.15,
                    content: clockinMorning.getClockOutHour(),
                    marginRight: 10,
                  ),
                  ClockinHourWidget(
                    width: screenWidth * 0.15,
                    content: clockinAfterNoon != null
                        ? clockinAfterNoon!.getClockInHour()
                        : "",
                    marginRight: 10,
                  ),
                  ClockinHourWidget(
                    width: screenWidth * 0.15,
                    content: clockinAfterNoon != null
                        ? clockinAfterNoon!.getClockOutHour()
                        : "",
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

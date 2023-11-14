import 'package:flutter/material.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/clockin/clockin_hour.dart';
import 'package:tracker_app/widgets/clockin_hour.dart';

class ClockinShowItem extends StatelessWidget {
  const ClockinShowItem({super.key, required this.clockin});
  final Clockin clockin;

  @override
  Widget build(BuildContext context) {
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
                clockin.getDate(),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              Row(
                children: [
                  for (ClockinHour hours in clockin.clockinList)
                    ClockinHourWidget(
                      width: 80,
                      content: hours.getHours(),
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

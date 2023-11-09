import 'package:flutter/material.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';
import 'package:tracker_app/widgets/pointing_hour.dart';

class PointingShowItem extends StatelessWidget {
  const PointingShowItem({super.key, required this.pointing});
  final Pointing pointing;

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
                pointing.getDate(),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              Row(
                children: [
                  for (PointingHour hours in pointing.pointingList)
                    PointingHourWidget(
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

import 'package:flutter/material.dart';

class PointingHourWidget extends StatefulWidget {
  const PointingHourWidget(
      {super.key,
      required this.width,
      this.marginRight = 0,
      this.content = ""});

  final double width;
  final double marginRight;
  final String content;
  @override
  State<StatefulWidget> createState() {
    return _PointingHourWidgetState();
  }
}

class _PointingHourWidgetState extends State<PointingHourWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 40,
      margin: EdgeInsets.fromLTRB(0, 0, widget.marginRight, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Center(
        child: Text(
          widget.content,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

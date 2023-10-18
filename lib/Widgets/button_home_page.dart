import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ButtonHommePage extends StatelessWidget {
  const ButtonHommePage(
      {super.key,
      required this.text,
      required this.icon,
      required this.colorBg,
      required this.colorIcon,
      required this.route,
      this.badgeValue,
      required this.height,
      required this.width,
      this.wrap = false,
      this.textSize,
      this.biggerSize = false,
      this.row = false});

  final String text;
  final IconData icon;
  final Color colorBg;
  final Color colorIcon;
  final Widget route;
  final int? badgeValue;
  final double height;
  final double width;
  final bool wrap;
  final double? textSize;
  final bool biggerSize;
  final bool row;

  @override
  Widget build(BuildContext context) {
    Widget textContainer;
    Widget iconButton;

    if (text.contains(" ") && wrap) {
      int indexSpace = text.indexOf(" ");
      String textFirst = text.substring(0, indexSpace);
      String textSecond = text.substring(indexSpace + 1);

      textContainer = Align(
        alignment: row? Alignment.centerLeft : Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              row ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              textFirst,
              textAlign: row ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                color: colorIcon,
                fontWeight: FontWeight.w800,
                fontSize: textSize ?? textSize,
                letterSpacing: 1.3,
              ),
            ),
            Text(
              textSecond,
              textAlign: row ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                color: colorIcon,
                fontWeight: FontWeight.w800,
                fontSize: textSize ?? textSize,
                letterSpacing: 1.3,
              ),
            )
          ],
        ),
      );
    } else {
      textContainer = Align(
        alignment: row? Alignment.centerLeft : Alignment.center,
          child: Text(
            text,
            textAlign: row ? TextAlign.start : TextAlign.center,
            style: TextStyle(
              color: colorIcon,
              fontWeight: FontWeight.w800,
              fontSize: textSize ?? textSize,
              letterSpacing: 1.3,
            ),
          ),
      );
    }

    if (badgeValue != null && badgeValue! > 0) {
      iconButton = badges.Badge(
        position: badges.BadgePosition.custom(
            top: badgeValue! < 10 ? 0 : 4, start: 35),
        badgeContent: Text(
          badgeValue! < 100 ? badgeValue.toString() : "!!",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: colorIcon,
              fontWeight: FontWeight.bold,
              fontSize: badgeValue! < 10 ? 24 : 18),
        ),
        child: Icon(
          icon,
          size: width * 0.28 < height * 0.45 ? width * 0.28 : height * 0.5,
          color: colorIcon,
        ),
      );
    } else {
      iconButton = Icon(
        icon,
        size: width * 0.28 < height * 0.45 ? width * 0.28 : height * 0.45,
        color: colorIcon,
      );
    }

    final List<Widget> content = <Widget>[
      iconButton,
      SizedBox(width: row? 30 : 0,), 
      textContainer,
    ];

    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => route),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        padding: const EdgeInsets.all(8),
        backgroundColor: colorBg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 10,
      ),
      child: row
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: content,
            ),
    );
  }
}

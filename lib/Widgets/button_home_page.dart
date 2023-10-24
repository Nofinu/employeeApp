import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ButtonHommePage extends StatelessWidget {
  const ButtonHommePage({
    super.key,
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
    this.row = false,
    this.notImplemented = false,
  });

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
  final bool notImplemented;

  @override
  Widget build(BuildContext context) {
    Widget textContainer;
    Widget iconButton;
    const double letterSpacing = 1.2;

    if (text.contains(" ") && wrap) {
      int indexSpace = text.indexOf(" ");
      String textFirst = text.substring(0, indexSpace);
      String textSecond = text.substring(indexSpace + 1);

      textContainer = Align(
        alignment: row ? Alignment.centerLeft : Alignment.center,
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
                letterSpacing: letterSpacing,
              ),
            ),
            Text(
              textSecond,
              textAlign: row ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                color: colorIcon,
                fontWeight: FontWeight.w800,
                fontSize: textSize ?? textSize,
                letterSpacing: letterSpacing,
              ),
            )
          ],
        ),
      );
    } else {
      textContainer = Align(
        alignment: row ? Alignment.centerLeft : Alignment.center,
        child: Text(
          text,
          textAlign: row ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: colorIcon,
            fontWeight: FontWeight.w800,
            fontSize: textSize ?? textSize,
            letterSpacing: letterSpacing,
          ),
        ),
      );
    }

    if (badgeValue != null && badgeValue! > 0) {
      iconButton = badges.Badge(
        badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.fromLTRB(8, 5, 8, 8),
            borderSide: BorderSide(width: 5, color: Colors.red)),
        position: badges.BadgePosition.custom(
            start: 45, top: badgeValue! > 9 ? -10 : -5),
        badgeContent: Text(
          badgeValue! < 9 ? badgeValue.toString() : "!",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: badgeValue! > 9 ? 24 : 19),
        ),
        child: Icon(
          icon,
          size: row ? height * 0.8 : height * 0.45,
          color: colorIcon,
        ),
      );
    } else {
      iconButton = Icon(
        icon,
        size: row ? height * 0.8 : height * 0.45,
        color: colorIcon,
      );
    }

    final List<Widget> content = <Widget>[
      iconButton,
      SizedBox(
        width: row ? 15 : 0,
      ),
      textContainer,
    ];

    return ElevatedButton(
      onPressed: () {
        if (notImplemented) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Not Implemented"),
            ),
          );
          return;
        }
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

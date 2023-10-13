import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ButtonHommePage extends StatelessWidget {
  const ButtonHommePage(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.route,
      this.badgeValue});

  final String text;
  final IconData icon;
  final Color color;
  final Widget route;
  final int? badgeValue;

  @override
  Widget build(BuildContext context) {
    Widget textContainer;
    Widget iconButton;

    if (text.contains(" ")) {
      int indexSpace = text.indexOf(" ");
      String textFirst = text.substring(0, indexSpace);
      String textSecond = text.substring(indexSpace + 1);

      textContainer = Column(
        children: [
          Text(
            textFirst,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            textSecond,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      );
    } else {
      textContainer = Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }

    if (badgeValue != null && badgeValue!>0) {
      iconButton = badges.Badge(
        position: badges.BadgePosition.custom(top: badgeValue!<10? 0 : 4, start: 35),
        badgeContent: Text(
          badgeValue!<100 ? badgeValue.toString(): "!!",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: badgeValue!<10? 24 : 18),
        ),
        child: Icon(
          icon,
          size: 65,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
    } else {
      iconButton = Icon(
        icon,
        size: 65,
        color: Theme.of(context).colorScheme.onSurface,
      );
    }

    return SizedBox(
      width: 145,
      height: 155,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => route),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconButton,
            const SizedBox(
              height: 10,
            ),
            FittedBox(
              child: textContainer,
            ),
          ],
        ),
      ),
    );
  }
}

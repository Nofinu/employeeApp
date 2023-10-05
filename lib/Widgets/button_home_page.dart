import 'package:flutter/material.dart';

class ButtonHommePage extends StatelessWidget {
  const ButtonHommePage(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.route});

  final String text;
  final IconData icon;
  final Color color;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 100;
    Widget textContainer;

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

    return SizedBox(
      width: 145,
      height: screenHeight * 0.26,
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
            Icon(
              icon,
              size: screenHeight*0.1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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

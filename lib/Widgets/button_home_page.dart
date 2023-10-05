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
    return SizedBox(
      width: 145,
      height: 150,
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
              size: 70,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

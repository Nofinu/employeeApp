import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/messageBox/message_box.dart';
import 'package:tracker_app/model/User.dart';

class MessageBoxItem extends StatelessWidget {
  const MessageBoxItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MessageBoxScreen(user: user,),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.8,
        margin:
            EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.1),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                offset: Offset(5, 10),
                spreadRadius: 0.1,
                blurStyle: BlurStyle.normal),
          ],
          color: const Color.fromARGB(255, 90, 114, 157),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    user.firstname,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

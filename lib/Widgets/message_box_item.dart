import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/messageBox/message_box.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/message.dart';
import 'package:tracker_app/provider/messages_provider.dart';
import 'package:tracker_app/util/generator.dart';
import 'package:tracker_app/widgets/avatar.dart';
import 'package:badges/badges.dart' as badges;

class MessageBoxItem extends ConsumerWidget {
  const MessageBoxItem({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

      List<Message> messagesTabs = ref.watch(messageProvider.notifier).messages;
    if (user != null) {
      messagesTabs = messagesTabs
          .where(
            (message) => message.writter == user,
          )
          .toList();
    }

    final notification = Generator().countNotification(messagesTabs);

    Widget avatar;


    if(user != null && notification != 0){
      avatar =  badges.Badge(
                      position:
                          badges.BadgePosition.custom(top: -10, start: 55),
                      badgeContent: Text(
                        notification.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Avatar(user: user, radius: 35));
    }else if(user != null){
        avatar = Avatar(user: user, radius: 35);
    }
    else{
      avatar = const SizedBox();
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MessageBoxScreen(
              user: user,
            ),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.8,
        margin:
            EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.1),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
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
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: user != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: <Widget>[
                avatar,
                FittedBox(
                  child: Text(
                    user == null ? "Tout" : user!.firstname,
                    textAlign: TextAlign.center,
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

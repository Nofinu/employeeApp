import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/messageBox/probleme_detail.dart';
import 'package:tracker_app/Screen/report_problem.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/messages_provider.dart';

class ProbelemMessageItem extends ConsumerWidget {
  const ProbelemMessageItem({super.key, required this.probleme});

  final Probleme probleme;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        final User user = ref.read(authProvider);
        if(!probleme.isView && user.isAdmin){
           ref.read(messageProvider.notifier).setViewMessage(probleme);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProblemeDetailScreen(probleme: probleme),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.8,
        height: 80,
        margin:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 239, 239),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  probleme.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  probleme.getDate(),
                ),
              ],
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: probleme.priority == Priority.low
                    ? Colors.green
                    : probleme.priority == Priority.medium
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

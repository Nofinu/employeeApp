import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/issue.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';

class IssueDetailScreen extends ConsumerWidget {
  const IssueDetailScreen({super.key, required this.issue,required this.onClickValidationButton});

  final Issue issue;

    final void Function(bool validation, Issue issue) onClickValidationButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    User user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Probleme Detail",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                issue.title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.priority_high_rounded,
                color: issue.priority == Priority.low
                    ? const Color.fromRGBO(0, 194, 8, 1)
                    : issue.priority == Priority.medium
                        ? const Color.fromRGBO(237, 121, 14, 1)
                        : const Color.fromRGBO(214, 38, 38, 1),
                size: 28,
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            issue.getDate(),
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            issue.detail,
            style: const TextStyle(fontSize: 22),
          ),
          Visibility(
            visible: user.isAdmin && !issue.isCheked,
            child: ElevatedButton(
              onPressed: () {
                onClickValidationButton(true, issue);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: const Color.fromRGBO(0, 194, 8, 1),
                minimumSize: Size(screenWidth * 0.9, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
              ),
              child: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

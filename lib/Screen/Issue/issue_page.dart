import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/Issue/form_issue.dart';
import 'package:tracker_app/model/messageModel/issue.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/issue_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/issue_message_item.dart';

class IssueScreen extends ConsumerStatefulWidget {
  const IssueScreen({super.key, required this.user});

  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _IssueScreenState();
  }
}

class _IssueScreenState extends ConsumerState<IssueScreen> {
  void onClickValidationButton(bool validation, Issue issue) {
    ref
        .read(issueProvider.notifier)
        .setValidationOnRequest(issue, validation);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List<Issue> messagesTabs = ref.watch(issueProvider);

    return Scaffold(
      appBar:
          AppBarPerso(ref.watch(authProvider), "Signaler un problème", context),
                floatingActionButton: Visibility(
        visible: !widget.user.isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ReportIssueScreen(),
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: screenWidth * 0.8,
                child: const Text(
                  "Liste des problemes",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              for (int i = 0; i < messagesTabs.length; i++)
                IssueMessageItem(issue: messagesTabs[i],
                    onClickValidationButton: onClickValidationButton
                    ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

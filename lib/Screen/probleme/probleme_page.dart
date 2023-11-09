import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/probleme/form_problem.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/probleme_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/probelem_message_item.dart';

class ProblemeScreen extends ConsumerStatefulWidget {
  const ProblemeScreen({super.key, required this.user});

  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProblemeScreenState();
  }
}

class _ProblemeScreenState extends ConsumerState<ProblemeScreen> {
  void onClickValidationButton(bool validation, Probleme probleme) {
    ref
        .read(problemeProvider.notifier)
        .setValidationOnRequest(probleme, validation);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Probleme> messagesTabs = ref.watch(problemeProvider);

      if (!widget.user.isAdmin) {
        messagesTabs = messagesTabs
            .where(
              (message) => message.writer == widget.user,
            )
            .toList();
      }
    

    return Scaffold(
      appBar:
          AppBarPerso(ref.watch(authProvider), "Signaler un problème", context),
                floatingActionButton: Visibility(
        visible: !widget.user.isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ReportProblemeScreen(),
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
                ProblemeMessageItem(probleme: messagesTabs[i],
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

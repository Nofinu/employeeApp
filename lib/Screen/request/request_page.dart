import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/request/form_request.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/request_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/request_message_item.dart';

class RequestScreen extends ConsumerStatefulWidget {
  const RequestScreen({super.key, required this.user});

  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RequestScreenState();
  }
}

class _RequestScreenState extends ConsumerState<RequestScreen> {
  void onClickValidationButton(bool validation, Request request) {
    ref
        .read(requestProvider.notifier)
        .setValidationOnRequest(request, validation);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Request> messagesTabs = ref.watch(requestProvider);

    if (!widget.user.isAdmin) {
      messagesTabs = messagesTabs
          .where(
            (message) => message.writer == widget.user,
          )
          .toList();
    }

    return Scaffold(
      appBar:
          AppBarPerso(ref.watch(authProvider), "Aménagement horaire", context),
      floatingActionButton: Visibility(
        visible: !widget.user.isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const FormRequestScreen(),
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
                  "Liste des demandes",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              for (int i = 0; i < messagesTabs.length; i++)
                RequestMessageItem(
                    request: messagesTabs[i],
                    onClickValidationButton: onClickValidationButton),
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

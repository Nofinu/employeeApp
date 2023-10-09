import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/model/messageModel/message.dart';
import 'package:tracker_app/provider/messages_provider.dart';

class MessageBoxScreen extends ConsumerStatefulWidget {
  const MessageBoxScreen({super.key, this.user});

  final User? user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessageBoxScreenState();
  }
}

class _MessageBoxScreenState extends ConsumerState<MessageBoxScreen> {
//a faire dans un provider pour refresh dinamique
  void onClickValidationButton(bool validation, Request request) {
    ref
        .read(messageProvider.notifier)
        .setValidationOnRequest(request, validation);
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messagesTabs = ref.watch(messageProvider);
    if (widget.user != null) {
      messagesTabs = messagesTabs
          .where(
            (message) => message.writter == widget.user,
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Messagerie",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < messagesTabs.length; i++)
              messagesTabs[i].showWidget(onClickValidationButton)
          ],
        ),
      ),
    );
  }
}

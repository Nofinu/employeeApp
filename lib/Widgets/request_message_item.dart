import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/messageBox/request_detail.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/messages_provider.dart';

class RequestMessageItem extends ConsumerStatefulWidget {
  const RequestMessageItem(
      {super.key,
      required this.request,
      required this.onClickValidationButton});

  final Request request;
  final void Function(bool validation, Request request) onClickValidationButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RequestMessageItemState();
  }
}

class _RequestMessageItemState extends ConsumerState<RequestMessageItem> {
  late Request requestShow;

  void onclickRefresh(bool validation, Request request) {
    widget.onClickValidationButton(validation, request);
    request.setIsValidated(validation);
    request.setIsChecked();
    setState(() {
      requestShow = request;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    requestShow = widget.request;

    return Container(
      width: screenWidth * 0.8,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 239, 239),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.request.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.request.getDate(),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 7,
              backgroundColor: const Color.fromRGBO(96, 185, 205, 1),
            ),
            onPressed: () {
              final User user = ref.read<User>(authProvider);
              if (!widget.request.isView && user.isAdmin) {
                ref.read(messageProvider.notifier).setViewMessage(widget.request);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => RequestDetailScreen(
                    request: widget.request,
                    onClickValidationButton: onclickRefresh,
                  ),
                ),
              );
            },
            child: Text(
              "Detail",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromRGBO(126, 126, 126, 1)),
            child: Icon(
              widget.request.isCheked
                  ? widget.request.isvalidated
                      ? Icons.check
                      : Icons.cancel_outlined
                  : Icons.question_mark,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

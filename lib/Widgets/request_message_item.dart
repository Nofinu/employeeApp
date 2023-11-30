import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/request/request_detail.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/request_provider.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              final User user = ref.read<User>(authProvider);
              if (!widget.request.isView && user.isAdmin) {
                ref
                    .read(requestProvider.notifier)
                    .setViewMessage(widget.request);
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
            child: Container(
              width: screenWidth * 0.55,
              height: 80,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 239, 239),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.request.title,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.request.getDate(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.18,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: requestShow.isCheked
                  ? requestShow.isvalidated
                      ? const Color.fromRGBO(0, 194, 8, 1)
                      : const Color.fromRGBO(205, 0, 0, 1)
                  : const Color.fromRGBO(126, 126, 126, 1),
            ),
            child: Icon(
              requestShow.isCheked
                  ? requestShow.isvalidated
                      ? Icons.check
                      : Icons.close_sharp
                  : null,
              size: screenWidth * 0.1,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}

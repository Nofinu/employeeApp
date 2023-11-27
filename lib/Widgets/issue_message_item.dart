import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/Issue/issue_detail.dart';
import 'package:tracker_app/model/messageModel/issue.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/issue_provider.dart';

class IssueMessageItem extends ConsumerStatefulWidget {
  const IssueMessageItem({super.key, required this.issue,required this.onClickValidationButton});

  final Issue issue;
  final void Function(bool validation, Issue request) onClickValidationButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProblemeMessageItemState();
  }
}

class _ProblemeMessageItemState extends ConsumerState<IssueMessageItem> {
  late Issue problemeShow;

  void onclickRefresh(bool validation, Issue issue) {
    widget.onClickValidationButton(validation, issue);
    issue.setIsValidated(validation);
    issue.setIsChecked();
    setState(() {
      problemeShow = issue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    problemeShow = widget.issue;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              final User user = ref.read<User>(authProvider);
              if (!widget.issue.isView && user.isAdmin) {
                ref
                    .read(issueProvider.notifier)
                    .setViewMessage(widget.issue);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => IssueDetailScreen(
                    issue: widget.issue,
                    onClickValidationButton: onclickRefresh,
                  ),
                ),
              );
            },
            child: Container(
              width: screenWidth * 0.58,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.issue.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.issue.getDate(),
                      ),
                    ],
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                        color: problemeShow.priority == Priority.low
                            ? const Color.fromRGBO(0, 194, 8, 1)
                            : problemeShow.priority == Priority.medium
                                ? const Color.fromRGBO(237, 121, 14, 1)
                                : const Color.fromRGBO(214, 38, 38, 1)),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.18,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color:
                   problemeShow.isvalidated
                      ? const Color.fromRGBO(0, 194, 8, 1)
                      : const Color.fromRGBO(126, 126, 126, 1)
            ),
            child: Icon(
              problemeShow.isCheked
                  ? problemeShow.isvalidated
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

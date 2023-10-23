import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/probleme/probleme_detail.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/probleme_provider.dart';

class ProblemeMessageItem extends ConsumerStatefulWidget {
  const ProblemeMessageItem({super.key, required this.probleme,required this.onClickValidationButton});

  final Probleme probleme;
  final void Function(bool validation, Probleme request) onClickValidationButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProblemeMessageItemState();
  }
}

class _ProblemeMessageItemState extends ConsumerState<ProblemeMessageItem> {
  late Probleme problemeShow;

  void onclickRefresh(bool validation, Probleme probleme) {
    widget.onClickValidationButton(validation, probleme);
    probleme.setIsValidated(validation);
    probleme.setIsChecked();
    setState(() {
      problemeShow = probleme;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    problemeShow = widget.probleme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              final User user = ref.read<User>(authProvider);
              if (!widget.probleme.isView && user.isAdmin) {
                ref
                    .read(problemeProvider.notifier)
                    .setViewMessage(widget.probleme);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProblemeDetailScreen(
                    probleme: widget.probleme,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.probleme.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.probleme.getDate(),
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
              color: problemeShow.isCheked
                  ? problemeShow.isvalidated
                      ? const Color.fromRGBO(0, 194, 8, 1)
                      : const Color.fromRGBO(126, 126, 126, 1)
                  : const Color.fromRGBO(126, 126, 126, 1),
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

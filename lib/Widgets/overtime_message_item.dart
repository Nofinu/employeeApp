
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/overtime/overtime_detail.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/overtime_provider.dart';

class OvertimeMessageItem extends ConsumerStatefulWidget{
  const OvertimeMessageItem({super.key,required this.overtime,required this.onClickValidationButton});

  final Overtime overtime;
  final void Function(bool validation, Overtime request) onClickValidationButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    
    return _OvertimeMessageItemState();
  }
}

class _OvertimeMessageItemState extends ConsumerState<OvertimeMessageItem>{
  late Overtime overtimeShow;

  void onclickRefresh(bool validation, Overtime request) {
    widget.onClickValidationButton(validation, request);
    request.setIsValidated(validation);
    request.setIsChecked();
    setState(() {
      overtimeShow = request;
    });
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    overtimeShow = widget.overtime;

    return Container(
      margin: const  EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              final User user = ref.read<User>(authProvider);
              if (!widget.overtime.isView && user.isAdmin) {
                ref.read(overtimeProvider.notifier).setViewMessage(widget.overtime);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => OvertimeDetailScreen(
                    overtime: widget.overtime,
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
                        overtimeShow.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        overtimeShow.getDate(),
                      ),
                    ],
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
              color: overtimeShow.isCheked
                  ? overtimeShow.isvalidated
                      ? const Color.fromRGBO(0, 194, 8, 1)
                      : const Color.fromRGBO(205, 0, 0, 1)
                  : const Color.fromRGBO(126, 126, 126, 1),
            ),
            child: Icon(
              overtimeShow.isCheked
                  ? overtimeShow.isvalidated
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
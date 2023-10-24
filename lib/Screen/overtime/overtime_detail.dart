import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';

class OvertimeDetailScreen extends ConsumerWidget {
  const OvertimeDetailScreen(
      {super.key,
      required this.overtime,
      required this.onClickValidationButton});

  final Overtime overtime;

  final void Function(bool validation, Overtime request) onClickValidationButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<Widget> buttonCheck = [];
    final User user = ref.read(authProvider);

    if (!overtime.isCheked && user.isAdmin) {
      buttonCheck.add(
        ElevatedButton(
          onPressed: () {
            onClickValidationButton(false, overtime);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color.fromRGBO(205, 0, 0, 1),
              minimumSize: Size(screenWidth * 0.4, 75)),
          child: Icon(
            Icons.cancel_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 60,
          ),
        ),
      );
      buttonCheck.add(
        SizedBox(
          width: screenWidth * 0.1,
        ),
      );
      buttonCheck.add(
        ElevatedButton(
          onPressed: () {
            onClickValidationButton(true, overtime);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color.fromRGBO(0, 194, 8, 1),
              minimumSize: Size(screenWidth * 0.4, 75)),
          child: Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 60,
          ),
        ),
      );
    } else {
      buttonCheck.add(
        Container(
          width: screenWidth * 0.8,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: overtime.isCheked
                ? overtime.isvalidated
                    ? const Color.fromRGBO(0, 194, 8, 1)
                    : const Color.fromRGBO(205, 0, 0, 1)
                : const Color.fromRGBO(126, 126, 126, 1),
          ),
          child: Icon(
            overtime.isCheked
                ? overtime.isvalidated
                    ? Icons.check
                    : Icons.cancel_outlined
                : Icons.question_mark,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarPerso(user,overtime.title,context),
      body: Column(
        children: <Widget>[
          Text(
            overtime.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            overtime.getOvertimeDate(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            overtime.detail,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            overtime.nbrHours.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonCheck,
          )
        ],
      ),
    );
  }
}

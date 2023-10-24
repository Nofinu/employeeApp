

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/overtime/overtime_form.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/overtime_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/overtime_message_item.dart';

class OvertimeScreen extends ConsumerStatefulWidget {
  const OvertimeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OvertimeScreenState();
  }
}

class _OvertimeScreenState extends ConsumerState<OvertimeScreen>{

    void onClickValidationButton(bool validation, Overtime overtime) {
    ref
        .read(overtimeProvider.notifier)
        .setValidationOnRequest(overtime, validation);
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.watch(authProvider);
    final List<Overtime> overtimes = ref.watch(overtimeProvider);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPerso(ref.watch(authProvider),"Heure supplémentaire",context),
        floatingActionButton: Visibility(
        visible: !user.isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const OvertimeFormScreen(),
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
          child: Column(children: [
            for(Overtime overtime in overtimes)
              OvertimeMessageItem(overtime: overtime, onClickValidationButton: onClickValidationButton)
          ],),
        ),
      ),
    );
  }
}
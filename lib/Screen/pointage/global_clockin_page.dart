import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/clockin/clockin.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/clockin_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/clockin_show_item.dart';

class GlobalClockinScreen extends ConsumerStatefulWidget {
  const GlobalClockinScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GlobalClockinScreenState();
  }
}

class _GlobalClockinScreenState extends ConsumerState<GlobalClockinScreen> {
  @override

  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    User user = ref.watch(authProvider); 
    List<Clockin> clockinList = ref.watch(clockinProvider);
    // clockinList = clockinList.where((pointing)=> pointing.user == user).toList();
    return Scaffold(
      appBar: AppBarPerso(user, "Pointage", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1 ),
          child: Column(
            children: [
              for(Clockin clockIn  in clockinList)
                ClockinShowItem(clockin: clockIn)
            ],
          ),
        ),
      ),
    );
  }
}

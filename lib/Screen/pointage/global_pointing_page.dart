import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/pointing_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';
import 'package:tracker_app/widgets/pointing_show_item.dart';

class GlobalPointingScreen extends ConsumerStatefulWidget {
  const GlobalPointingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GlobalPointingScreen();
  }
}

class _GlobalPointingScreen extends ConsumerState<GlobalPointingScreen> {
  @override

  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    User user = ref.watch(authProvider); 
    List<Pointing> pointingList = ref.watch(pointingProvider);
    pointingList = pointingList.where((pointing)=> pointing.user == user).toList();
    return Scaffold(
      appBar: AppBarPerso(user, "Pointage", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1 ),
          child: Column(
            children: [
              for(Pointing pointing  in pointingList)
                PointingShowItem(pointing: pointing)
            ],
          ),
        ),
      ),
    );
  }
}

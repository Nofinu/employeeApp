import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/messageBox/admin_message_box.dart';
import 'package:tracker_app/Screen/messageBox/exceptional_request.dart';
import 'package:tracker_app/Screen/messageBox/message_box.dart';
import 'package:tracker_app/Screen/pointage/pointage.dart';
import 'package:tracker_app/Screen/presenceManagement/presence_management.dart';
import 'package:tracker_app/Screen/profil_screen.dart';
import 'package:tracker_app/Screen/messageBox/report_problem.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/messageModel/message.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/messages_provider.dart';
import 'package:tracker_app/widgets/button_home_page.dart';
import 'package:tracker_app/data/fake_data.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() {
    return _HomePageScreenState();
  }
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  int countNotification(List<Message> messages) {
    print("notification home");
    int cpt = 0;
    for (var message in messages) {
      if (!message.isView) {
        cpt++;
      }
    }
    print(cpt);
    return cpt;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 100;
    final User userActive = user[1];
    final messages = ref.watch(messageProvider).messages;
    final notification = countNotification(messages);
    
    Future(() {
      ref.read(authProvider.notifier).setUser(userActive);
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.onBackground),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(userActive.imageUrl, scale: 1),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProfilPageScreen(),
                ),
              );
            },
          ),
        ],
        title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Bienvenue",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20),
          ),
          Text("${userActive.firstname} ${userActive.lastname}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22)),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, screenHeight * 0.04),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonHommePage(
                  text: "Signaler probleme",
                  icon: Icons.announcement_outlined,
                  color: Color.fromRGBO(249, 129, 129, 1),
                  route: ReportProblemeScreen(),
                ),
                ButtonHommePage(
                  text: "Demande Exeptionel",
                  icon: Icons.chat,
                  color: Color.fromRGBO(210, 169, 251, 1),
                  route: ExceptionalRequest(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonHommePage(
                text: "Gestion presence",
                icon: Icons.calendar_month,
                color: Color.fromRGBO(16, 216, 223, 0.6),
                route: PresenceManagementScreen(),
              ),
              ButtonHommePage(
                text: "Pointer",
                icon: Icons.punch_clock_rounded,
                color: Color.fromRGBO(215, 248, 28, 0.8),
                route: PointageScreen(),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userActive.isAdmin
                  ? ButtonHommePage(
                      text: "Messagerie",
                      icon: Icons.notifications,
                      color: const Color.fromRGBO(40, 221, 36, 0.7),
                      route: const AdminMessageBoxScreen(),
                      badgeValue: notification,
                    )
                  : ButtonHommePage(
                      text: "Messagerie",
                      icon: Icons.notifications,
                      color: const Color.fromRGBO(40, 221, 36, 0.7),
                      route: MessageBoxScreen(
                        user: userActive,
                      ),
                    ),
              const ButtonHommePage(
                text: "Gestion pointage",
                icon: Icons.description_outlined,
                color: Color.fromRGBO(203, 113, 30, 0.7),
                route: ReportProblemeScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

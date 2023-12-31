import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/Issue/issue_page.dart';
import 'package:tracker_app/Screen/overtime/overtime.dart';
import 'package:tracker_app/Screen/pointage/global_clockin_page.dart';
import 'package:tracker_app/Screen/pointage/clockin_page.dart';
import 'package:tracker_app/Screen/presenceManagement/presence_management.dart';
import 'package:tracker_app/Screen/profil_screen.dart';
import 'package:tracker_app/Screen/request/request_page.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/clockin_provider.dart';
import 'package:tracker_app/provider/day_provider.dart';
import 'package:tracker_app/provider/overtime_provider.dart';
import 'package:tracker_app/provider/issue_provider.dart';
import 'package:tracker_app/provider/request_provider.dart';
import 'package:tracker_app/util/generator.dart';
import 'package:tracker_app/widgets/button_home_page.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() {
    return _HomePageScreenState();
  }
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  late Timer _timer;
  int minutes = 0;
  int seconde = 5 ;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration( seconds: 1), (arg) {
      ref.read(issueProvider.notifier).getIssueFromUser();
      ref.read(clockinProvider.notifier).setClockIn();
      ref.read(overtimeProvider.notifier).getOvertimeFromUser();
      ref.read(requestProvider.notifier).getRequestFromUser();
      ref.read(dayProvider.notifier).getfakeDay();
      _timer.cancel();

      _timer = Timer.periodic(const Duration( minutes: 10), (arg) {
      ref.read(issueProvider.notifier).getIssueFromUser();
      ref.read(clockinProvider.notifier).setClockIn();
      ref.read(overtimeProvider.notifier).getOvertimeFromUser();
      ref.read(requestProvider.notifier).getRequestFromUser();
      ref.read(dayProvider.notifier).getfakeDay();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
  if(_timer.isActive){
    _timer.cancel();
  }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height - 100;
    final double screenWidth = MediaQuery.of(context).size.width;
    // final User userActive = ref.watch(authProvider);
    final User userActive = user[0];
    int notificationIssue = 0;
    int notificationOvertime = 0;
    int notificationRequest = 0;
    if(userActive.isAdmin){
     notificationIssue = Generator().countNotification(ref.watch(issueProvider));
     notificationOvertime = Generator().countNotification(ref.watch(overtimeProvider));
     notificationRequest = Generator().countNotification(ref.watch(requestProvider));
    }
    final Color whiteColor = Theme.of(context).colorScheme.onPrimary;

    Future(() {
      ref.read(authProvider.notifier).setUser(userActive);
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 26, screenWidth * 0.05, 0),
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
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue",
                  style: TextStyle(color: whiteColor, fontSize: 18),
                ),
                Text("${userActive.firstname} ${userActive.lastname}",
                    style: TextStyle(color: whiteColor, fontSize: 22)),
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
              padding: EdgeInsets.fromLTRB(0, 40, 0, screenHeight * 0.03),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(20),
                      bottomStart: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <ButtonHommePage>[
                    userActive.isAdmin
                        ? ButtonHommePage(
                            text: "visualisation Pointage",
                            icon: Icons.punch_clock_rounded,
                            colorBg: whiteColor,
                            route: const ClockinScreen(),
                            colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                            width: screenWidth * 0.42,
                            height: 130,
                            wrap: true,
                          )
                        : ButtonHommePage(
                            text: "Pointage",
                            icon: Icons.punch_clock_rounded,
                            colorBg: whiteColor,
                            route: const ClockinScreen(),
                            colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                            width: screenWidth * 0.42,
                            height: 130,
                          ),
                    ButtonHommePage(
                      text: "Team Tracker",
                      icon: Icons.calendar_month_rounded,
                      colorBg: const Color.fromRGBO(206, 224, 251, 1),
                      route: const PresenceManagementScreen(),
                      colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                      wrap: true,
                      width: screenWidth * 0.42,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            ButtonHommePage(
              text: "Mon Calendrier",
              icon: Icons.calendar_month,
              colorBg: const Color.fromRGBO(96, 197, 249, 1),
              route: const PresenceManagementScreen(),
              colorIcon: whiteColor,
              width: screenWidth * 0.9,
              height: 80,
              row: true,
              notImplemented: true,
            ),
            const SizedBox(
              height: 20,
            ),
            userActive.isAdmin
                ? ButtonHommePage(
                    text: "Détails des pointages",
                    icon: Icons.punch_clock_rounded,
                    colorBg: const Color.fromRGBO(96, 197, 249, 1),
                    route: const GlobalClockinScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    row: true,
                  )
                : ButtonHommePage(
                    text: "Mes Pointages",
                    icon: Icons.punch_clock_rounded,
                    colorBg: const Color.fromRGBO(96, 197, 249, 1),
                    route: const GlobalClockinScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    row: true,
                  ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <ButtonHommePage>[
                  userActive.isAdmin
                      ? ButtonHommePage(
                          text: "Probleme signalés",
                          icon: Icons.announcement_outlined,
                          colorBg: whiteColor,
                          route: IssueScreen(
                            user: userActive,
                          ),
                          colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                          width: screenWidth * 0.42,
                          height: 110,
                          wrap: true,
                          badgeValue: notificationIssue,
                        )
                      : ButtonHommePage(
                          text: "Signaler un probleme",
                          icon: Icons.notifications,
                          colorBg: whiteColor,
                          route: IssueScreen(
                            user: userActive,
                          ),
                          colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                          width: screenWidth * 0.42,
                          height: 110,
                          wrap: true,
                        ),
                  userActive.isAdmin
                      ? ButtonHommePage(
                          text: "Aménagement horaires",
                          icon: Icons.forum_outlined,
                          colorBg: whiteColor,
                          route: RequestScreen(
                            user: userActive,
                          ),
                          colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                          width: screenWidth * 0.42,
                          height: 110,
                          wrap: true,
                          badgeValue: notificationRequest,
                        )
                      : ButtonHommePage(
                          text: "Aménagement horaires",
                          icon: Icons.notifications,
                          colorBg: whiteColor,
                          route: RequestScreen(
                            user: userActive,
                          ),
                          colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                          width: screenWidth * 0.42,
                          height: 110,
                          wrap: true,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            userActive.isAdmin
                ? ButtonHommePage(
                    text: "Heures supplémentaires demandés",
                    icon: Icons.notifications,
                    colorBg: const Color.fromRGBO(96, 197, 249, 1),
                    route: const OvertimeScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    wrap: true,
                    biggerSize: true,
                    row: true,
                    badgeValue: notificationOvertime,
                  )
                : ButtonHommePage(
                    text: "Signaler des heures supplémentaires",
                    icon: Icons.notifications,
                    colorBg: const Color.fromRGBO(96, 197, 249, 1),
                    route: const OvertimeScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    wrap: true,
                    biggerSize: true,
                    row: true,
                  ),
          ],
        ),
      ),
    );
  }
}

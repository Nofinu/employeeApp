import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/overtime/overtime.dart';
import 'package:tracker_app/Screen/pointage/pointage.dart';
import 'package:tracker_app/Screen/presenceManagement/presence_management.dart';
import 'package:tracker_app/Screen/probleme/probleme_page.dart';
import 'package:tracker_app/Screen/profil_screen.dart';
import 'package:tracker_app/Screen/request/request_page.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/overtime_provider.dart';
import 'package:tracker_app/provider/probleme_provider.dart';
import 'package:tracker_app/provider/request_provider.dart';
import 'package:tracker_app/util/generator.dart';
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
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height - 100;
    final double screenWidth = MediaQuery.of(context).size.width;
    final User userActive = user[0];
    final List<Probleme> problemesList = ref.watch(problemeProvider);
    final int notificationProbleme =
        Generator().countNotification(problemesList);
    final List<Request> requestList = ref.watch(requestProvider);
    final int notificationRequest = Generator().countNotification(requestList);
    final List<Overtime> overtimeList = ref.watch(overtimeProvider);
    final int notificationOvertime =
        Generator().countNotification(overtimeList);
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
                            route: const PointageScreen(),
                            colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                            width: screenWidth * 0.42,
                            height: 130,
                            wrap: true,
                          )
                        : ButtonHommePage(
                            text: "Pointage",
                            icon: Icons.punch_clock_rounded,
                            colorBg: whiteColor,
                            route: const PointageScreen(),
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
                    route: const PointageScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    row: true,
                    notImplemented: true,
                  )
                : ButtonHommePage(
                    text: "Mes Pointages",
                    icon: Icons.punch_clock_rounded,
                    colorBg: const Color.fromRGBO(96, 197, 249, 1),
                    route: const PointageScreen(),
                    colorIcon: whiteColor,
                    width: screenWidth * 0.9,
                    height: 80,
                    row: true,
                    notImplemented: true,
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
                          route: ProblemeScreen(
                            user: userActive,
                          ),
                          colorIcon: const Color.fromRGBO(12, 67, 147, 1),
                          width: screenWidth * 0.42,
                          height: 110,
                          wrap: true,
                          badgeValue: notificationProbleme,
                        )
                      : ButtonHommePage(
                          text: "Signaler un probleme",
                          icon: Icons.notifications,
                          colorBg: whiteColor,
                          route: ProblemeScreen(
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

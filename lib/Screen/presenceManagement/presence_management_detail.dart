import 'package:flutter/material.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/util/generator.dart';

class PresenceManagementDetailScreen extends StatelessWidget {
  const PresenceManagementDetailScreen(
      {super.key, required this.planing, required this.day});

  final FakeDay planing;
  final String day;

  Container _generatePanel(
      double screenHeight, double screenWidth, String textPanel) {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.35,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(5, 10),
                spreadRadius: 0.1,
                blurStyle: BlurStyle.normal),
          ],
          color: const Color.fromARGB(255, 240, 239, 239),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                textPanel,
                style: const TextStyle(fontSize: 32),
              ),
              Generator().generateTypeOfWork(planing),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            children: [
              ...Generator().buildIconRow(
                  planing.users.length, planing.users, screenWidth * 0.085),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _generatePanel(screenHeight, screenWidth, "Matin"),
          _generatePanel(screenHeight, screenWidth, "Aprés-Midi"),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 8,
                maximumSize: Size(screenWidth * 0.8, 80),
                minimumSize: Size(screenWidth * 0.8, 80),
                backgroundColor: const Color.fromRGBO(6, 195, 2, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Distancielle",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ))
        ],
      )),
    );
  }
}

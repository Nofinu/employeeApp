import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/loginPage/Login_page_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.asset(
            'assets/images/utopiosLogo.png',
            height: screenHeight * 0.15,
          ),
          const SizedBox(height: 8,),
          Text(
            "TeamTracker",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "UTOPIOS",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8,),
          Image.asset(
            'assets/images/teamTrackerLogo.png',
            height: screenHeight * 0.25,
          ),
          const LoginPageFrom(),
        ],
      )),
    );
  }
}

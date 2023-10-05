import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/loginPage/Login_page_item.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: screenHeight / 4,
        flexibleSpace: Column(
          children: [
            SizedBox(
              height: screenHeight / 20,
            ),
            Icon(
              Icons.map_outlined,
              color: Theme.of(context).colorScheme.onBackground,
              size: screenHeight / 5,
            ),
            Text(
              "Track Employee",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 23),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: LoginPageItem(),
      ),
    );
  }
}

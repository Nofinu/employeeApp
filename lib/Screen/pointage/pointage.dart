import 'package:flutter/material.dart';

class PointageScreen extends StatelessWidget {
  const PointageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pointage",
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.8,
                    screenHeight * 0.5,
                  ),
                  side: const BorderSide(
                    color: Color.fromRGBO(0, 194, 8, 1),
                    width: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Enter",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 194, 8, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 15,
                  fixedSize: Size(screenWidth * 0.8, 80),
                ),
                child: Text(
                  "pressent",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

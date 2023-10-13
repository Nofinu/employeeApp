import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/pointage/pointage_pressence.dart';
import 'package:tracker_app/provider/pointing_provider.dart';

class PointageScreen extends ConsumerStatefulWidget {
  const PointageScreen({super.key});

  @override
  ConsumerState<PointageScreen> createState() {
    return _PointageScreenState();
  }
}

class _PointageScreenState extends ConsumerState<PointageScreen> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
//Color.fromRGBO(0, 194, 8, 1)

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
                onPressed: () {
                  if (!checked) {
                    ref.watch(pointingProvider.notifier).addPointing("in");
                  } else {
                    ref.watch(pointingProvider.notifier).addPointing("out");
                  }
                  setState(() {
                    checked = !checked;
                  });
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.8,
                    screenHeight * 0.5,
                  ),
                  side: BorderSide(
                    color: checked ? Colors.red : Colors.green,
                    width: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  checked ? "Sortir" : "Enter",
                  style: TextStyle(
                    color: checked ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PointagePressence(),
                    ),
                  );
                },
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/home_page.dart';
import 'package:tracker_app/Screen/loginPage/login_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(12, 67, 147, 1),
            primary: const Color.fromRGBO(12, 67, 147, 1),
            onPrimary: const Color.fromARGB(255, 244, 244, 244),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(206, 224, 251, 1),
          appBarTheme: const AppBarTheme().copyWith(
            color: const Color.fromRGBO(12, 67, 147, 1),
            iconTheme: const IconThemeData().copyWith(
              color: const Color.fromARGB(255, 244, 244, 244),
            ),
          ),
        ),
        home: const HomePageScreen(),
      ),
    ),
  );
}

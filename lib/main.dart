import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tracker_app/Screen/loginPage/login_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 12, 67, 147),
            onBackground: const Color.fromARGB(255, 231, 231, 231),
            surface: const Color.fromARGB(255, 45, 91, 177),
          ),
        ),
        home: const HomePageScreen(),
      ),
    ),
  );
}


//todo:
//changer le pointing creee une liste d'objet contenant la date et le type de pointing et en faire une liste
//pour la page on work recuperer la liste de tout les utilisateur et recuperer le dernier item de la liste du jour pour s'avoir qui travail actuelement
// recherche des messages par persone / afficher le nom  du writter sur le msg

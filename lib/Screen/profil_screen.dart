import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/widgets/avatar.dart';

class ProfilPageScreen extends ConsumerWidget {
  const ProfilPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final User user = ref.read<User>(authProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mon Profil",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: (screenWidth / 2) - 50, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Avatar(user: user, radius: 50),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: const TextStyle(fontSize: 21),
                      decoration: InputDecoration(
                        labelText: "Nom complet :",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 21),
                      decoration: InputDecoration(
                        labelText: "Email :",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 21),
                      decoration: InputDecoration(
                        labelText: "Telephone :",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: const Color.fromRGBO(0, 194, 8, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          maximumSize: Size(screenWidth * 0.8, 80),
                          minimumSize: Size(screenWidth * 0.8, 80)),
                      child: Text(
                        "Modifier",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          maximumSize: Size(screenWidth * 0.8, 80),
                          minimumSize: Size(screenWidth * 0.8, 80)),
                      child: const Text(
                        "Deconection",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 194, 8, 1),
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

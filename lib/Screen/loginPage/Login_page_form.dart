import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/Screen/home_page.dart';
import 'package:tracker_app/provider/auth_provider.dart';

class LoginPageFrom extends ConsumerWidget {
  const LoginPageFrom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeightBody = screenHeight - (screenHeight / 3);
    final formKey = GlobalKey<FormState>();

    var email = "";
    var password = "";

    void moveTo() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomePageScreen(),
        ),
      );
    }

    void showErrorMessage() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Email ou Mot de passe incorect.",
          ),
        ),
      );
    }

    void onLogin() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        bool isLogged = false;
        await ref
            .watch(authProvider.notifier)
            .connection(email, password)
            .then((value) => isLogged = value);

        if (isLogged) {
          moveTo();
        } else {
          showErrorMessage();
        }
      }
      formKey.currentState!.reset();
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: screenHeightBody > 400
                ? 15 + (screenHeightBody / 10)
                : 15 + (screenHeightBody / 15),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: TextFormField(
              initialValue: email,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                label: const Text(
                  "Email :",
                  style: TextStyle(fontSize: 22),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              validator: (value) {
                if (value == null || !value.contains("@")) {
                  return "Entrer un email Valide";
                }
                return null;
              },
              onSaved: (value) {
                email = value!;
              },
            ),
          ),
          SizedBox(
            height: screenHeightBody > 400
                ? 10 + (screenHeightBody / 15)
                : 10 + (screenHeightBody / 20),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: TextFormField(
              obscureText: true,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                label: const Text(
                  "Password :",
                  style: TextStyle(fontSize: 22),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "Entrer un mot de passe valide ";
                }
                return null;
              },
              onSaved: (value) {
                password = value!;
              },
            ),
          ),
          SizedBox(
            height: screenHeightBody > 400
                ? 10 + (screenHeightBody / 15)
                : 10 + (screenHeightBody / 20),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: onLogin,
              child: Text(
                "Connection",
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

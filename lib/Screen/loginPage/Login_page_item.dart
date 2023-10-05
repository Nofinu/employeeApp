

import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/home_page.dart';
import 'package:tracker_app/data/fake_data.dart';

class LoginPageItem extends StatelessWidget{
  const LoginPageItem({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeightBody = screenHeight - (screenHeight / 3);
    final _formKey = GlobalKey<FormState>();

    var _email = "";
    var _password = "";

    void _onLogin() {
      if (_formKey.currentState!.validate()) {
        //request connection to api with email and password
        _formKey.currentState!.save();
        if (_email == loginData["email"] &&
            _password == loginData["password"]) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const HomePageScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Email ou Mot de passe incorect.",
              ),
            ),
          );
        }
      }
      _formKey.currentState!.reset();
    }

    
    return Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
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
                  initialValue: _email,
                  style: const TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    label: const Text(
                      "Email :",
                      style: TextStyle(fontSize: 22),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  validator: (value) {
                    if (value == null || !value.contains("@")) {
                      return "Entrer un email Valide";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
              ),
              SizedBox(
                height: screenHeightBody > 400
                    ? 10 + (screenHeightBody / 10)
                    : 10 + (screenHeightBody / 15),
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
                    fillColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Entrer un mot de passe valide ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              ),
              SizedBox(
                height: screenHeightBody > 400
                    ? 10 + (screenHeightBody / 10)
                    : 10 + (screenHeightBody / 15),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.green,
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: 5 + screenWidth / 5, vertical: 25),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: _onLogin,
                  child: Text(
                    "Connection",
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
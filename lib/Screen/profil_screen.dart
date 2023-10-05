import 'package:flutter/material.dart';

class ProfilPageScreen extends StatelessWidget {
  const ProfilPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          "Mon Profil",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Icon(
              Icons.person,
              size: 50,
            ),
            // child : Image(image: ,),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                            maximumSize: Size(screenWidth * 0.8, 80),
                            minimumSize: Size(screenWidth * 0.8, 80)),
                        child: Text(
                          "Deconection",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

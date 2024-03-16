import 'package:flutter/material.dart';
import '../nutrition/kalorienrechner.dart';

void main() {
  runApp(const LoginSign());
}

class LoginSign extends StatefulWidget {
  const LoginSign({super.key});

  @override
  State<LoginSign> createState() => _LoginSignState();
}

class _LoginSignState extends State<LoginSign> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyLoginSign(title: 'LoginSign'),
    );
  }
}

class MyLoginSign extends StatefulWidget {
  const MyLoginSign({super.key, required this.title});

  final String title;

  @override
  State<MyLoginSign> createState() => _MyLoginSignState();
}

class _MyLoginSignState extends State<MyLoginSign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 42, 41, 41),
          title: const Center(
            child: Text(
              'Select your Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Was ist dein Ziel?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton<String>(
                      value: 'Kraft',
                      onChanged: (String? newValue) {},
                      items: <String>['Kraft', 'Definition', 'Bodyweight']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Welches Trainingsniveau hast du?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton<String>(
                      value: 'Beginner',
                      onChanged: (String? newValue) {},
                      items: <String>[
                        'Beginner',
                        'Intermediate',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                height: 80.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/hantel_App.png'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/apfel_App.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Kalorienrechner()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 0),
                        child: IconButton(
                          icon: Image.asset('assets/Logo_Menu_App.png'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/kalender_App.png'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/dreiPunkte_App.png'),
                          onPressed: () {},
                        ),
                      ),
                    ]))));
  }
}

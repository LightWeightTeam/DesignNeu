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
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(137, 207, 240, 1),
        ),
      ),
      home: const MyLoginSign(title: 'OK_Trainingsplan'),
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
        //Header

        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 100,
          title: Stack(
            alignment: Alignment.topRight,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo_Menu_App.png',
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                  const SizedBox(width: 10), // Abstand hinzugefügt
                  const Text(
                    'Light Weight',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                      child:
                          Container()), // Fügt einen flexiblen leeren Container ein
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/search_icon3.png',
                      height: 25,
                    ),
                    onPressed: () {
                      //do something
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/login_App.png',
                      height: 25,
                    ),
                    onPressed: () {
                      //do something
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 0,
                  margin: const EdgeInsets.only(right: 25.0),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Trainingsplan',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(189, 189, 189, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ListView(
                          scrollDirection: Axis.horizontal,
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Woche 1',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Montag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Dienstag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Mittwoch',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Donnerstag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Freitag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Samstag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Sonntag',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                      ],
                    )),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(189, 189, 189, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  height: 120,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Meal 2',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          widthFactor:
                              1.0, // Der Button wird die gesamte Breite einnehmen
                          child: ElevatedButton(
                            onPressed: () {
                              // Hier kannst du die Aktion für den Button definieren
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(189, 189, 189, 1),
                              // Hintergrundfarbe des Buttons
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                            child: const Text('Nahrungsmittel hinzufügen'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(189, 189, 189, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  height: 120,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Meal 3',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          widthFactor:
                              1.0, // Der Button wird die gesamte Breite einnehmen
                          child: ElevatedButton(
                            onPressed: () {
                              // Hier kannst du die Aktion für den Button definieren
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(189, 189, 189, 1),
                              // Hintergrundfarbe des Buttons
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                            child: const Text('Nahrungsmittel hinzufügen'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                IconButton(
                  icon: Image.asset('assets/addmeal_button.png'),
                  iconSize: 50,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
            child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(137, 207, 240, 1),
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
                        //Optik
                        child: IconButton(
                          icon: Image.asset('assets/hantel_App.png'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        //Optik
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
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        width: 70, // Neuer Wert für die Breite
                        height: 70, // Neuer Wert für die Höhe
                        margin: const EdgeInsets.only(
                            bottom: 0), // Verschiebung nach oben
                        child: IconButton(
                          icon: Image.asset('assets/Logo_Color_Menu_App.png'),
                          onPressed: () {
                            // Funktionalität für das Logo-Symbol hinzufügen
                          },
                        ),
                      ),
                      SizedBox(
                        //Optik
                        child: IconButton(
                          icon: Image.asset('assets/kalender_App.png'),
                          onPressed: () {
                            // Add functionality for home icon
                          },
                        ),
                      ),
                      SizedBox(
                        //Optik
                        child: IconButton(
                          icon: Image.asset('assets/dreiPunkte_App.png'),
                          onPressed: () {
                            // Add functionality for home icon
                          },
                        ),
                      ),
                    ]))));

    //Body
  }
}

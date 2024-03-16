import 'package:flutter/material.dart';
import '../login/login.dart';
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
                  const SizedBox(width: 10),
                  const Text(
                    'Light Weight',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: Container()),
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/login_App.png',
                      height: 25,
                    ),
                    onPressed: () {},
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/Hintergrund_1.png'),
                    fit: BoxFit.cover,
                  )),
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Block 1',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          border: TableBorder.all(),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                    child: Center(
                                        child: Text('Mo',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                TableCell(
                                    child: Center(
                                        child: Text(
                                  'Di',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                TableCell(
                                    child: Center(
                                        child: Text(
                                  'Mi',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                TableCell(
                                    child: Center(
                                        child: Text(
                                  'Do',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                TableCell(
                                    child: Center(
                                        child: Text(
                                  'Fr',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                TableCell(
                                    child: Center(
                                        child: Text(
                                  'Sa',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                    'So',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                )
                              ],
                            ),
                            TableRow(children: [
                              TableCell(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                                  },
                                  child: const Center(
                                    child: Text(
                                      'OK',
                                    ),
                                  ),
                                ),
                              ),
                              const TableCell(child: Center(child: Text('UK'))),
                              TableCell(child: Center(child: Text('Rest'))),
                              TableCell(child: Center(child: Text('OK'))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                'UK',
                                textAlign: TextAlign.center,
                              ))),
                              TableCell(child: Center(child: Text('Rest'))),
                              TableCell(child: Center(child: Text('Rest'))),
                            ]),
                            TableRow(children: [
                              TableCell(child: Center(child: Text('OK'))),
                              TableCell(child: Center(child: Text('UK'))),
                              TableCell(child: Center(child: Text('Rest'))),
                              TableCell(child: Center(child: Text('OK'))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                'UK',
                                textAlign: TextAlign.center,
                              ))),
                              TableCell(child: Center(child: Text('Rest'))),
                              TableCell(child: Center(child: Text('Rest'))),
                            ])
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
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
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 0),
                        child: IconButton(
                          icon: Image.asset('assets/Logo_Color_Menu_App.png'),
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

import 'package:flutter/material.dart';
import 'food_tracking.dart';

void main() {
  runApp(const Kalorienrechner());
}

class Kalorienrechner extends StatefulWidget {
  const Kalorienrechner({Key? key});

  @override
  State<Kalorienrechner> createState() => _KalorienrechnerState();
}

class _KalorienrechnerState extends State<Kalorienrechner> {
  String selectedGender = 'female';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ).copyWith(
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
      home: const MyKalorienrechner(title: 'Calories and Macrocalculator'),
    );
  }
}

class MyKalorienrechner extends StatefulWidget {
  const MyKalorienrechner({Key? key, required this.title});

  final String title;

  @override
  State<MyKalorienrechner> createState() => _MyKalorienrechnerState();
}

class _MyKalorienrechnerState extends State<MyKalorienrechner> {
  String selectedGender = 'female';
  String? height, weight, age;

  double calculateBMR() {
    double heightInCm = double.parse(height!);
    double weightInKg = double.parse(weight!);
    double ageInYears = double.parse(age!);

    double bmr;
    if (selectedGender == 'female') {
      bmr = 655 + (9.6 * weightInKg) + (1.8 * heightInCm) - (4.7 * ageInYears);
    } else {
      bmr = 66 + (13.7 * weightInKg) + (5 * heightInCm) - (6.8 * ageInYears);
    }

    double carbs = 0.5 * bmr / 4;
    double protein = 0.3 * bmr / 4;
    double fat = 0.2 * bmr / 9;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Calories and Macros'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Calorie requirement is: $bmr kcal'),
              const SizedBox(height: 10),
              const Text('Macros:'),
              Text('Carbohydrates: ${carbs.toStringAsFixed(2)} g'),
              Text('Proteins: ${protein.toStringAsFixed(2)} g'),
              Text('Fats: ${fat.toStringAsFixed(2)} g'),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    return bmr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Calories and Macrocalculator',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'female',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                        const Text('female'),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: 'male',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                        const Text('male'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'height (in cm)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'weight (in kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: () {
                          calculateBMR();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'calculate calories ',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 25),
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
                        builder: (context) => const Kalorienrechner(),
                      ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodTracking(),
                        ),
                      );
                    }),
              ),
              SizedBox(
                child: IconButton(
                  icon: Image.asset('assets/dreiPunkte_App.png'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'kalorienrechner.dart';
import '../../backend/nutrition_http.dart';

class FoodTracking extends StatefulWidget {
  @override
  _FoodTrackingState createState() => _FoodTrackingState();
}

class _FoodTrackingState extends State<FoodTracking> {
  late DateTime selectedDate;
  late DateTime _focusedDay;

  late int basicCalories;
  late int uebrig;
  late int totalCalories;
  late double totalCarbs;
  late double totalFat;
  late double totalProtein;
  int verbrannt = 500;

  late Map<String, double> maxNutrientValues = {
    'carbs': 0,
    'protein': 0,
    'fat': 0,
  };

  late Future<void> maxNutrientValuesFuture;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    selectedDate = DateTime.now();
    uebrig = 0;
    totalCalories = 0;
    totalCarbs = 0;
    totalFat = 0;
    totalProtein = 0;

    _fetchMealData(selectedDate);
    maxNutrientValuesFuture = _fetchMaxNutrientValues(selectedDate);
  }

  Future<void> _fetchMaxNutrientValues(DateTime selectedDate) async {
    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    try {
      var data = await calculateNutritionIntake(formattedDate);
      setState(() {
        maxNutrientValues = {
          'carbs': (data['carbIntakeGrams'] ?? 0).toDouble(),
          'protein': (data['proteinIntakeGrams'] ?? 0).toDouble(),
          'fat': (data['fatIntakeGrams'] ?? 0).toDouble(),
        };
      });
    } catch (error) {
      print('Fehler beim Abrufen der maximalen Nährstoffwerte: $error');
      setState(() {
        maxNutrientValues = {
          'carbs': 0,
          'protein': 0,
          'fat': 0,
        };
      });
    }
  }

  void _fetchMealData(DateTime selectedDate) {
    setState(() {
      totalCalories = 0;
      totalCarbs = 0;
      totalFat = 0;
      totalProtein = 0;
      basicCalories = 0;
    });

    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    getBasicCalories().then((data) {
      setState(() {
        final double basicCaloriesDouble =
            double.parse(data['basicCalories'].toString());
        basicCalories = basicCaloriesDouble.toInt();
        uebrig = basicCalories - totalCalories + verbrannt;
      });
    }).catchError((error) {
      print('Fehler beim Abrufen der Grundkalorien: $error');
      setState(() {
        basicCalories = 0;
        uebrig = 0;
      });
    });

    getMealSum(formattedDate).then((data) {
      setState(() {
        if (data != null) {
          totalCalories = (data['totalCalories'] ?? 0).round();
          totalCarbs = data['totalCarbs'] ?? 0;
          totalFat = data['totalFat'] ?? 0;
          totalProtein = data['totalProtein'] ?? 0;
          uebrig = basicCalories - totalCalories + verbrannt;
        }
      });
    }).catchError((error) {
      print('Fehler beim Abrufen der Mahlzeitsumme: $error');
      setState(() {
        totalCalories = 0;
        totalCarbs = 0;
        totalFat = 0;
        totalProtein = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/searchPage').then((_) {
                      _fetchMealData(selectedDate);
                    });
                  },
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
              const SizedBox(height: 15),
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2024, 1, 1),
                  lastDay: DateTime(2028, 12, 31),
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _fetchMealData(selectedDay);
                    maxNutrientValuesFuture = _fetchMaxNutrientValues(selectedDay);
                  },
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNutritionBlock('Gegessen', totalCalories.toString()),
                    _buildNutritionBlock('Übrig', uebrig.toString()),
                    _buildNutritionBlock('Verbrannt', verbrannt.toString()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: maxNutrientValuesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Fehler: ${snapshot.error}');
                  } else {
                    return _buildNutrientBars(totalCarbs, totalFat, totalProtein);
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildMealContainer('Meal 1'),
              const SizedBox(height: 5),
              _buildMealContainer('Meal 2'),
              const SizedBox(height: 5),
              _buildMealContainer('Meal 3'),
              const SizedBox(height: 15),
              IconButton(
                icon: Image.asset('assets/addmeal_button.png'),
                iconSize: 50,
                onPressed: () {},
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
              IconButton(
                icon: Image.asset('assets/hantel_App.png'),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('assets/apfel_App.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Kalorienrechner()),
                  );
                },
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
              IconButton(
                icon: Image.asset('assets/kalender_App.png'),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('assets/dreiPunkte_App.png'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionBlock(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientBars(double carbs, double protein, double fat) {
    final maxCarbs = maxNutrientValues['carbs'] ?? 0;
    final maxProtein = maxNutrientValues['protein'] ?? 0;
    final maxFat = maxNutrientValues['fat'] ?? 0;
    return _buildNutrientBarsWithValues(carbs, protein, fat, maxCarbs, maxProtein, maxFat);
  }

  Widget _buildNutrientBarsWithValues(double carbs, double protein, double fat, double maxCarbs, double maxProtein, double maxFat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNutrientBar('Kohlenhydrate', carbs, maxCarbs, Colors.blue),
        _buildNutrientBar('Eiweiß', protein, maxProtein, Colors.green),
        _buildNutrientBar('Fett', fat, maxFat, Colors.orange),
      ],
    );
  }

  Widget _buildNutrientBar(String title, double value, double maxValue, Color color) {
    final barWidth = 100.0;

    return Column(
      children: [
        Text(
          value.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: barWidth,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: maxValue != 0 ? value / maxValue : 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealContainer(String mealType) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mealType,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> arguments = {
                      'selectedDate': selectedDate,
                      'mealType': mealType,
                    };
                    Navigator.pushNamed(context, '/searchFood', arguments: arguments).then((_) {
                      _fetchMealData(selectedDate);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'add',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/previousAddsPage',
                      arguments: {
                        'mealType': mealType,
                        'selectedDate': selectedDate,
                      },
                    ).then((_) {
                      _fetchMealData(selectedDate);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'previous',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

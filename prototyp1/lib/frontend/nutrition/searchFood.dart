/*
import 'package:flutter/material.dart';
import 'kalorienrechner.dart';
import '../../backend/nutrition_http.dart';
import 'food_tracking.dart';



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String mealType = arguments['mealType'] as String;
    final DateTime selectedDate = arguments['selectedDate'] as DateTime;

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
                    // Hier Aktion für die Suchfunktion hinzufügen
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/login_App.png',
                    height: 25,
                  ),
                  onPressed: () {
                    // Hier Aktion für den Login hinzufügen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Hier können weitere Widgets für die Suchergebnisse eingefügt werden
          ],
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
                  onPressed: () {
                    // Hier Aktion für Hantel-Button hinzufügen
                  },
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
                  onPressed: () {
                    // Hier Aktion für das Logo hinzufügen
                  },
                ),
              ),
              SizedBox(
                child: IconButton(
                  icon: Image.asset('assets/kalender_App.png'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/nutritionPage');
                  },
                ),
              ),
              SizedBox(
                child: IconButton(
                  icon: Image.asset('assets/dreiPunkte_App.png'),
                  onPressed: () {
                    // Hier Aktion für drei-Punkte-Button hinzufügen
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../backend/nutrition_http.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _loadingMore = false;
  int _pageNumber = 1;

  late String mealType;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    mealType = arguments['mealType'] as String;
    selectedDate = arguments['selectedDate'] as DateTime;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lebensmittelsuche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Lebensmittel suchen',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text.trim();
                    _loadFoodPage(query);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length + (_loadingMore ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == _searchResults.length) {
                    if (_loadingMore) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox.shrink();
                    }
                  } else {
                    return ListTile(
                      title: Text(_searchResults[index]['food_name']),
                      subtitle: Text(_searchResults[index]['food_description']),
                      onTap: () {
                        _showFoodDetailPage(_searchResults[index]);
                      },
                    );
                  }
                },
              ),
            ),
            if (_searchResults.isNotEmpty && !_loadingMore)
              ElevatedButton(
                child: Text('Weitere Ergebnisse anzeigen'),
                onPressed: () {
                  setState(() {
                    _loadingMore = true;
                  });
                  String query = _searchController.text.trim();
                  _loadFoodPage(query, loadMore: true);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _loadFoodPage(String query, {bool loadMore = false}) {
    loadFoodPage(
      query,
      _searchResults,
      _loadingMore,
      _pageNumber,
      _searchController,
      (bool loading) {
        setState(() {
          _loadingMore = loading;
        });
      },
      (List<Map<String, dynamic>> results) {
        setState(() {
          _searchResults = results;
        });
      },
      (int number) {
        setState(() {
          _pageNumber = number;
        });
      },
    );
  }

  void _showFoodDetailPage(Map<String, dynamic> foodData) {
    Navigator.pushNamed(
      context,
      '/foodDetailPage',
      arguments: {
        'foodDetails': foodData,
        'mealType': mealType,
        'selectedDate': selectedDate,
      },
    );
  }
}

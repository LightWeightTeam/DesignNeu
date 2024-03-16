import 'package:flutter/material.dart';
import '../../backend/nutrition_http.dart';

class FoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> foodDetails;
  final String mealType;
  final DateTime selectedDate;

  const FoodDetailPage({
    Key? key,
    required this.foodDetails,
    required this.mealType,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  late Future<Map<String, dynamic>> _nutritionData;
  late Future<Map<String, dynamic>> _originalData;
  TextEditingController _notesController = TextEditingController();
  String newAmount = '';

  void _updateNewAmount() async {
    double newAmountValue = double.tryParse(_notesController.text) ?? 0.0;
  
    if(newAmountValue == 0.0) {
      newAmountValue = 1.0;
    }
  
    Map<String, dynamic> adjustedNutritionData =
        await adjustNutritionData(newAmountValue, await _originalData);

    setState(() {
      _nutritionData = Future.value(adjustedNutritionData);
    });
  }

  @override
  void initState() {
    super.initState();
    _nutritionData = extractNutritionData(widget.foodDetails['food_description'] ?? '');
    _originalData = extractNutritionData(widget.foodDetails['food_description'] ?? '');
    _notesController.addListener(_updateNewAmount);
  }

  Future<Map<String, dynamic>> extractNutritionData(String nutritionData) async {
    final Map<String, dynamic> extractedData = await splitNutritionData(nutritionData);
    print('Extracted Data: $extractedData');
    return extractedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodDetails['food_name'] ?? 'Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _nutritionData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Fehler beim Laden der Nährwertinformationen'));
            } else {
              int calories = snapshot.data?['calories'] ?? 0;
              double fat = snapshot.data?['fat'] ?? 0.0;
              double carbs = snapshot.data?['carbs'] ?? 0.0;
              double protein = snapshot.data?['protein'] ?? 0.0;
              int amountValue = snapshot.data?['amount']['value'] ?? 0;
              String amountUnit = snapshot.data?['amount']['unit'] ?? '';

              print('Amount: $amountValue $amountUnit');

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nährwertinformationen:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Calories: $calories kcal'),
                  Text('Fat: $fat g'),
                  Text('Carbs: $carbs g'),
                  Text('Protein: $protein g'),
                  Text('Amount: $amountValue $amountUnit'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      int calories = snapshot.data?['calories'] ?? 0.0;
                      double fat = snapshot.data?['fat'] ?? 0.0;
                      double carbs = snapshot.data?['carbs'] ?? 0.0;
                      double protein = snapshot.data?['protein'] ?? 0.0;
                      String foodName = widget.foodDetails['food_name'] ?? '';
                      int amountValue = snapshot.data?['amount']['value'] ?? 0;
                      String amountUnit = snapshot.data?['amount']['unit'] ?? '';
                      String formattedDate =
                          '${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}';

                      await saveNutritionDataToFirebase(
                        calories: calories,
                        fat: fat,
                        carbs: carbs,
                        protein: protein,
                        foodName: foodName,
                        amount: '$amountValue $amountUnit',
                        selectedDate: formattedDate,
                        mealType: widget.mealType,
                      );
                    },
                    child: const Text('Speichern in Firebase'),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Change amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: 'Amount: $amountValue $amountUnit',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

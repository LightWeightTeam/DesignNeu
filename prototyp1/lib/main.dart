import 'package:flutter/material.dart';
import 'frontend/login/startseite.dart';
import 'frontend/login/login.dart';
import 'frontend/login/register.dart';
import 'frontend/nutrition/food_tracking.dart';
import 'frontend/nutrition/searchFood.dart';
import 'frontend/nutrition/foodDetailPage.dart';
import 'frontend/nutrition/previousAddsPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    title: 'Meine Flutter App',
    theme: ThemeData.dark(),
    initialRoute: '/start',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/start': (context) => Startseite(),
      '/nutritionPage': (context) => FoodTracking(),
      '/searchFood': (context) => SearchPage(),
      '/foodDetailPage': (context) {
        final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return FoodDetailPage(
          foodDetails: args['foodDetails'],
          mealType: args['mealType'],
          selectedDate: args['selectedDate'],
        );
      },
      '/previousAddsPage': (context) {
        final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return PreviousAddsPage(
          mealType: args['mealType'],
          selectedDate: args['selectedDate'],
        );
      }
    },
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

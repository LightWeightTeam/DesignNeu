import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Registrierung in Firebase

Future<void> signUp(BuildContext context, String email, String password) async {
  const url = 'https://rest-api-rho-hazel.vercel.app/auth/register';
  final body = jsonEncode({
    'email': email,
    'password': password,
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String uid = data['uid'];
      final String token = data['token'];

      await saveUidLocal(uid);
      await saveTokenLocal(token);

      print('User ID: $uid');
      print('Token ID: $token');
      //INFO für chrisi dort ist die Route wenn die anmeldung erfolgreif war

      Navigator.pushNamed(context, '/nutritionPage');
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['message'];
      print('Fehler beim Registrieren - ${response.statusCode}: $errorMessage');
      //fehler im frontend anzeigen lassen
    }
  } catch (error) {
    print('Fehler beim Registrieren: $error');
    //fehler im frontend anzeigen lassen
  }
}


//Meldet User an

Future<void> signIn(BuildContext context, String email, String password) async {
  const url = 'https://rest-api-rho-hazel.vercel.app/auth/login';
  final body = jsonEncode({
    'email': email,
    'password': password,
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String uid = data['uid'];
      final String token = data['token'].toString();

      await saveUidLocal(uid);
      await saveTokenLocal(token);

      print('User ID: $uid');
      print('User ID: $token');
      //Navigator.pushNamed(context, '/home');
      Navigator.pushNamed(context, '/nutritionPage');
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['message'];
      print('Fehler beim Anmelden - ${response.statusCode}: $errorMessage');
      //fehler im frontend anzeigen lassen
    }
  } catch (error) {
    print('Fehler beim Anmelden: $error');
    //fehler im frontend anzeigen lassen
  }
}



//Speichert UID Lokal

Future<void> saveUidLocal(String uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userUid', uid);
}

//Speichert Token Lokal

Future<void> saveTokenLocal(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userToken', token);
}

//Zeigt die UID an

Future<String?> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userUid');
}
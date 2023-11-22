import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gs_2/models/daily_calorie.dart';

class FitnessCalculatorApi {
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com';
  final String key = 'c826fd375cmsh81e600993822257p19a5a6jsn01fb2b84fc38';
  final String host = 'fitness-calculator.p.rapidapi.com';

   Future<DailyCalorie?> getDailyCalories (String valorIdade, String valorGenero, String valorPeso,
   String valorAltura, String nivel) async {
    final url = '$baseUrl/dailycalorie?age=$valorIdade&gender=$valorGenero&weight=$valorPeso&height=$valorAltura&activitylevel=$nivel';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': key,
        'X-RapidAPI-Host': host,
      },
    );

     if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dailyCalorie = DailyCalorie.fromJson(json["data"]) ;

      return dailyCalorie;
    } else {
      return null;
    }
    
  }
}
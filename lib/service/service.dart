import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telegram_bot/model/coffee_model.dart';

const apiUrl =
    "https://api.sampleapis.com/coffee"; // Replace with your actual API URL
Future<List<CoffeeModel>> fetchCoffeeMenu({required String type}) async {
  try {
    print("URL: $apiUrl/$type");
    final respone = await http.get(Uri.parse('$apiUrl/$type'));
    final List<dynamic> jsonData = jsonDecode(respone.body);
    return jsonData.map((item) => CoffeeModel.fromJson(item)).toList();
  } catch (e) {
    print("Error fetching coffee menu: $e");
    return [];
  }
}

Future<CoffeeModel> fetchCoffeeMenuById({
  required String type,
  required int id,
}) async {
  try {
    final respone = await http.get(Uri.parse('$apiUrl/$type/$id'));
    final jsonData = jsonDecode(respone.body);
    return CoffeeModel.fromJson(
      jsonData.firstWhere((item) => item['id'] == id),
    );
  } catch (e) {
    print("Error fetching coffee menu: $e");
    throw Exception("Failed to fetch coffee menu by id: $e");
  }
}

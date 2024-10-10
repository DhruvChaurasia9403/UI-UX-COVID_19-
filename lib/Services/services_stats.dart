import 'dart:convert';
import 'package:covid/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:covid/Model/world_stats_model.dart';

class StatServices {
  Future<WorldStatsModel> fetchWorldStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return WorldStatsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load world stats');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesStatsApi)); // Use the correct URL here

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body); // Expecting a list of countries
      return data;
    } else {
      throw Exception('Error fetching countries list');
    }
  }
}

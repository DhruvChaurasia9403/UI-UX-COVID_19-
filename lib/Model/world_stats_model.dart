import 'dart:convert';

WorldStatsModel worldStatsModelFromJson(String str) => WorldStatsModel.fromJson(json.decode(str));

String worldStatsModelToJson(WorldStatsModel data) => json.encode(data.toJson());

class WorldStatsModel {
  WorldStatsModel({
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.tests,
    required this.population,
    required this.affectedCountries,
  });

  int cases;
  int deaths;
  int recovered;
  int active;
  int critical;
  int tests;
  int population;
  int affectedCountries;

  factory WorldStatsModel.fromJson(Map<String, dynamic> json) => WorldStatsModel(
    cases: json["cases"],
    deaths: json["deaths"],
    recovered: json["recovered"],
    active: json["active"],
    critical: json["critical"],
    tests: json["tests"],
    population: json["population"],
    affectedCountries: json["affectedCountries"],
  );

  Map<String, dynamic> toJson() => {
    "cases": cases,
    "deaths": deaths,
    "recovered": recovered,
    "active": active,
    "critical": critical,
    "tests": tests,
    "population": population,
    "affectedCountries": affectedCountries,
  };
}

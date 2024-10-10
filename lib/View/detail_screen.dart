import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int active;
  final int critical;
  final int test;
  final int affectedCountries;

  DetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.affectedCountries,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.067,
                ),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReusableRow(
                        title: 'Total Cases',
                        value: widget.totalCases.toString(),
                      ),
                      ReusableRow(
                        title: 'Total Deaths',
                        value: widget.totalDeaths.toString(),
                      ),
                      ReusableRow(
                        title: 'Total Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ReusableRow(
                        title: 'Active Cases',
                        value: widget.active.toString(),
                      ),
                      ReusableRow(
                        title: 'Critical Cases',
                        value: widget.critical.toString(),
                      ),
                      ReusableRow(
                        title: 'Total Tests',
                        value: widget.test.toString(),
                      ),
                      ReusableRow(
                        title: 'Affected Countries',
                        value: widget.affectedCountries.toString(),
                      ),
                      SizedBox(height: 20),
                      Divider(thickness: 1.5),
                      SizedBox(height: 10),  // Space before chart

                      Text(
                        'Deaths and Recovered Statistics',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1.5),
                      SizedBox(height: 10),
                      PieChart(
                        dataMap: {
                          "Deaths": widget.totalDeaths.toDouble(),
                          "Recovered": widget.totalRecovered.toDouble(),
                        },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: true,
                        ),
                        animationDuration: const Duration(milliseconds: 1000),
                        chartType: ChartType.disc,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 2.7,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width * 0.5 - 50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

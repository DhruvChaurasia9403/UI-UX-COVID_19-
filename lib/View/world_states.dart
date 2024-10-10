import 'package:covid/Services/services_stats.dart';
import 'package:covid/View/CountryStatsScreen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xFFf72585),
    const Color(0xFF8ac926),
    const Color(0xFF1982c4),
  ];

  @override
  Widget build(BuildContext context) {
    StatServices statServices = StatServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              FutureBuilder(
                future: statServices.fetchWorldStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show loading spinner while data is being fetched
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.grey[800],
                        size: 50.0,
                        controller: controller,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    var worldStats = snapshot.data!;
                    return Expanded(
                      child: Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(worldStats.cases.toString()),
                              "Recovered": double.parse(worldStats.recovered.toString()),
                              "Deaths": double.parse(worldStats.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                            ),
                            animationDuration: const Duration(milliseconds: 1000),
                            chartType: ChartType.disc,
                            colorList: colorList,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: "Total Cases", value: worldStats.cases.toString()),
                                  ReusableRow(title: "Recovered", value: worldStats.recovered.toString()),
                                  ReusableRow(title: "Deaths", value: worldStats.deaths.toString()),
                                  ReusableRow(title: "Population", value: worldStats.population.toString()),
                                  ReusableRow(title: "Active", value: worldStats.active.toString()),
                                  ReusableRow(title: "Critical", value: worldStats.critical.toString()),
                                  ReusableRow(title: "Tests", value: worldStats.tests.toString()),
                                  ReusableRow(title: "Affected Countries", value: worldStats.affectedCountries.toString()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity, // This makes the button take the full width of the screen
                              child: ElevatedButton(
                                onHover: (value) {
                                  controller.forward();
                                },

                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CountryStatsScreen()));
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                                  shadowColor: MaterialStateProperty.all(Colors.black),
                                  elevation: MaterialStateProperty.all(8.0),
                                ),
                                child: Text(
                                  "Search by Country",
                                  style: TextStyle(color: Colors.grey[400], fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Handle empty state if needed
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

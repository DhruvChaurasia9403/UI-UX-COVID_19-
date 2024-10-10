import 'package:covid/Services/services_stats.dart';
import 'package:covid/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryStatsScreen extends StatefulWidget {
  const CountryStatsScreen({super.key});

  @override
  State<CountryStatsScreen> createState() => _CountryStatsScreenState();
}

class _CountryStatsScreenState extends State<CountryStatsScreen> {
  StatServices statServices = StatServices();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Country',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Trigger the UI update when search query changes
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show shimmer effect while data is loading
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10.0,
                                  width: 89,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[700],
                                  ),
                                ),
                                subtitle: Container(
                                  height: 10.0,
                                  width: 89,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[700],
                                  ),
                                ),
                                leading: Container(
                                  height: 50.0,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // Display error message if something went wrong
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    // Filter countries by search query
                    List<dynamic> filteredCountries = snapshot.data!.where((country) {
                      return country['country']
                          .toString()
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase());
                    }).toList();

                    // Display country data if available
                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        var country = filteredCountries[index];
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: country['country'],
                                      image: country['countryInfo']['flag'],
                                      totalCases: country['cases'] ?? 0, // Default value
                                      totalDeaths: country['deaths'] ?? 0, // Default value
                                      totalRecovered: country['recovered'] ?? 0, // Default value
                                      active: country['active'] ?? 0, // Default value
                                      critical: country['critical'] ?? 0, // Default value
                                      test: country['tests'] ?? 0, // Default value
                                      affectedCountries: country['affectedCountries'] ?? 0, // Default value
                                    ),
                                  ),
                                );
                              },
                              title: Text(country['country']),
                              subtitle: Text('Total Cases: ${country['cases'] ?? 0}'), // Default value
                              leading: Image(
                                height: 50.0,
                                width: 50.0,
                                image: NetworkImage(
                                  country['countryInfo']['flag'],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Handle the case where no data is available
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

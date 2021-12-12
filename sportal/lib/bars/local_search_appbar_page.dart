import 'package:flutter/material.dart';
import '../screens/Player.dart';
import '../screens/player_search_buildBody.dart';

class LocalSearchAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      //title: Text(MyApp.title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            showSearch(context: context, delegate: CitySearch());
          },
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: () {

          },
        ),
      ],
      backgroundColor: Colors.brown,
    ),

    body: PlayerSearchBuildBody() ,
  );
}

class CitySearch extends SearchDelegate<String> {
   List<Player> players = [
    Player(1, "Okan", "Torun", 22,"SLA","https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg","Türkiye","Bursa"),
    Player(2, "Samet", "Nalbant", 27,"MO","https://pbs.twimg.com/profile_images/1410182514652729345/lwIVc69M_400x400.jpg","Türkiye","Bilecik"),
    Player(3, "Mehmet Yalçın", "Alaman",18,"STP","https://media-exp1.licdn.com/dms/image/C4D03AQFzwdfVGxWbvQ/profile-displayphoto-shrink_200_200/0/1616803707483?e=1640822400&v=beta&t=3z4zEBDHf7IU7REmO_skD1OcU-kf5cKR3xY-Ru8AIlI","Almanya","Hmaburg"),
    Player(4, "Ömer Faruk", "Erol", 35,"SLB","https://media-exp1.licdn.com/dms/image/C5603AQHxk_oVYQkleA/profile-displayphoto-shrink_200_200/0/1623238342293?e=1640217600&v=beta&t=baRNJMLuBd7MhLrim2q8aBGgMPWD-NvgXIHHRx1dbpU","Türkiye","İstanbul"),
    Player(5, "Ahmet Fırat", "İdi", 24,"STP","https://pbs.twimg.com/profile_images/1299400134447382530/nYQXld7P_400x400.jpg","Türkiye","Tokat"),
  ];
 final cities = [
    'Berlin',
    'Paris',
    'Munich',
    'Hamburg',
    'London',
  ];

  final recentCities = [
    'Berlin',
    'Munich',
    'London',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, "");
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => close(context, ""),
  );

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_city, size: 120),
        const SizedBox(height: 48),
        Text(
          query,
          style: TextStyle(
            color: Colors.black,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
      final cityLower = city.toLowerCase();
      final queryLower = query.toLowerCase();

      return cityLower.startsWith(queryLower);
    }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      final suggestion = suggestions[index];
      final queryText = suggestion.substring(0, query.length);
      final remainingText = suggestion.substring(query.length);

      return ListTile(
        onTap: () {
          query = suggestion;

          // 1. Show Results
          showResults(context);

          // 2. Close Search & Return Result
          // close(context, suggestion);

          // 3. Navigate to Result Page
          //  Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ResultPage(suggestion),
          //   ),
          // );
        },
        leading: Icon(Icons.location_city),
        // title: Text(suggestion),
        title: RichText(
          text: TextSpan(
            text: queryText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: remainingText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
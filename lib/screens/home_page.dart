import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:smart_news/network/API.dart';
import 'package:smart_news/screens/articles/articles.dart';
import 'package:smart_news/services/database.dart';

/*Future<List<FeedModel>> getFeed(http.Client client) async {
  final response = await client.get(API.FEED);

  if (response.statusCode == 201 || response.statusCode == 200) {
    // Use the compute function to run parseSliders in a separate isolate.
    return compute(parseFeedResults, response.body);
  } else {
    throw Exception('Failed to search feed');
  }
}

// A function that converts a response body into a List<FeedModel)>.
List<FeedModel> parseFeedResults(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<FeedModel>((json) => FeedModel.fromJson(json)).toList();
}*/

fetchLiveFeed(http.Client client) async {
  final response = await client.get(
    API.FEED,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  var res = jsonDecode(response.body.toString());
  var data = res["data"];
  data.forEach((article) => DatabaseService().writeArticles(
      article["feedImage"], article["feedTitle"], article["feedDescription"]));

  return true;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchLiveFeed(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? '' : 'OFFLINE'}"),
                  ),
                ),
              ),
              Articles(),
            ],
          );
        },
        child: Articles(),
      ),
    );
  }
}

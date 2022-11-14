import 'package:aquatter/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _generateCards(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: snapshot.data ?? [],
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8,
                vertical: MediaQuery.of(context).size.height / 2.4),
            child: const LinearProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Widget>> _generateCards() async {
    List<Widget> result = [];
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        result.add(PostCard(
          user: element['username'],
          image: Image.network(
            element['lastImage']
            ),
          likes: element['likes'],
          liked: false,
        ));
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }
}

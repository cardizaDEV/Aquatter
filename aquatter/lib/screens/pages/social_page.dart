import 'dart:collection';
import 'package:aquatter/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  SwiperController swiperController = SwiperController();
  var postCards = Queue<Widget>();
  int actualCardIndex = 1;
  // ignore: prefer_typing_uninitialized_variables
  var initial;
  // ignore: prefer_typing_uninitialized_variables
  var distance;

  @override
  void initState() {
    _generateCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          )),
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          distance = details.globalPosition.dx - initial;
        },
        onPanEnd: (DragEndDetails details) {
          if (distance < 0) {
            if (actualCardIndex < postCards.length - 2) {
              swiperController.next();
            }
          } else {
            if (actualCardIndex >= 1) {
              swiperController.previous();
            }
          }
          setState(() {});
        },
        child: Swiper(
          loop: false,
          fade: 0.8,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          autoplay: false,
          controller: swiperController,
          itemCount: postCards.length,
          itemBuilder: (context, index) {
            actualCardIndex = index;
            return postCards.elementAt(index);
          },
        ),
      ),
    );
  }

  void _generateCards() async {
    final usersResponse = await http.get(
        Uri.parse('https://63722218025414c637071928.mockapi.io/Aquatter/user'));
    if (usersResponse.statusCode == 200) {
      List<Map<String, Map<String, dynamic>>> postList = [];
      List<dynamic> users = convert.jsonDecode(usersResponse.body);
      for (var user in users) {
        for (var post in user['posts']) {
          postList.add({user['username']: post});
        }
      }
      postList.sort(
        (a, b) {
          var postDateA = a.values.map((post) => post['postdate']);
          var postDateB = b.values.map((post) => post['postdate']);
          return postDateA.toString().compareTo(postDateB.toString());
        },
      );
      if (postList.isNotEmpty) {
        for (var post in postList) {
          var userId =
              post.values.map((e) => e['userId'].toString()).elementAt(0);
          var id = post.values.map((e) => e['id'].toString()).elementAt(0);
          final postResponse = await http.get(Uri.parse(
              // ignore: prefer_interpolation_to_compose_strings
              'https://63722218025414c637071928.mockapi.io/Aquatter/user/$userId/post/$id'));
          if (postResponse.statusCode == 200) {
            Map<String, dynamic> postMap =
                convert.jsonDecode(postResponse.body);
            postCards.add(PostCard(
                id: id,
                userId: userId,
                user: post.keys.elementAt(0),
                image: postMap['image'],
                likes: int.parse(postMap['likes'].toString()),
                liked: false,
                title: postMap['title'],
                comments: postMap['comments']));
            if (!mounted) return;
            setState(() {});
          } else if (postResponse.statusCode == 429) {
            await Future.delayed(const Duration(seconds: 1));
          } else {
            // ignore: avoid_print
            print(
                'Post Request failed with status: ${postResponse.statusCode}.');
          }
        }
      }
    } else if (usersResponse.statusCode == 429) {
      await Future.delayed(const Duration(seconds: 1));
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
    }
    if (!mounted) return;
    setState(() {});
  }
}

import 'dart:collection';
import 'dart:math';

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
  var initial;
  var distance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _generateCards();
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

  void _generateCards() {
    if (postCards.length <= 5 || actualCardIndex >= postCards.length - 10) {
      _generateNewCard();
    }
    setState(() {});
  }

  void _generateNewCard() async {
    final usersResponse = await http.get(
        Uri.parse('https://63722218025414c637071928.mockapi.io/Aquatter/user'));
    if (usersResponse.statusCode == 200) {
      var users = convert.jsonDecode(usersResponse.body) as List<dynamic>;
      int randomUser = Random().nextInt(users.length);
      users[randomUser];
      final postResponse = await http.get(Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          'https://63722218025414c637071928.mockapi.io/Aquatter/user/' +
              users[randomUser]['id'] +
              '/post'));
      if (postResponse.statusCode == 200) {
        var posts = convert.jsonDecode(postResponse.body) as List<dynamic>;
        int randomPost = Random().nextInt(posts.length + 1);
        randomPost = randomPost == 0 ? randomPost : randomPost - 1;
        if (posts.isNotEmpty) {
          var comments = posts[randomPost]['comments'] as List<dynamic>;
          postCards.add(PostCard(
              user: users[randomUser]['username'],
              image: posts[randomPost]['image'],
              likes: posts[randomPost]['likes'],
              liked: false,
              title: posts[randomPost]['title'],
              comments: comments.length));
        }
        if (!mounted) return;
        setState(() {});
      } else if (postResponse.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // ignore: avoid_print
        print('Request failed with status: ${postResponse.statusCode}.');
      }
    } else if (usersResponse.statusCode == 429) {
      await Future.delayed(const Duration(seconds: 1));
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${usersResponse.statusCode}.');
    }
    if (!mounted) return;
    setState(() {});
  }
}

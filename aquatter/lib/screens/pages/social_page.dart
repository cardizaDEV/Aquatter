import 'package:aquatter/components/post_card.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    String user = 'CardizaDEV';
    Image image = const Image(
      image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
    );

    return ListView(
      children: [
        PostCard(user: user, image: image, likes: 12,liked: false),
        PostCard(user: user, image: image, likes: 432,liked: true),
        PostCard(user: user, image: image, likes: 4356,liked: false),
        PostCard(user: user, image: image, likes: 1345,liked: false),
        PostCard(user: user, image: image, likes: 2345,liked: false),
        PostCard(user: user, image: image, likes: 234,liked: true),
        PostCard(user: user, image: image, likes: 654,liked: true),
        PostCard(user: user, image: image, likes: 6435,liked: false),
        PostCard(user: user, image: image, likes: 456456,liked: false),
        PostCard(user: user, image: image, likes: 234,liked: false),
        PostCard(user: user, image: image, likes: 2345234,liked: false),
        PostCard(user: user, image: image, likes: 2345234,liked: true),
      ],
    );
  }
}

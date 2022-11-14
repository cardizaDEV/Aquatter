import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostCardBottom extends StatelessWidget {
  const PostCardBottom({super.key, required this.likes, required this.liked});

  final int likes;
  final bool liked;

  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Row(
            children: [
              Icon(liked ? Icons.favorite : Icons.favorite_outline),
              const SizedBox(
                width: defaultPadding/2,
              ),
              Text(likes.toString())
            ],
          )),
          const SizedBox(
            width: defaultPadding,
          ),
          Text(parser.emojify('🐡'),
            style: const TextStyle(
              fontSize: defaultPadding*3,
            ),
          )
        ],
      ),
    );
  }
}
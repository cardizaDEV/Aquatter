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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Row(
                children: [
                  Tab(
                    height: defaultPadding*3,
                    child: liked ? Image.asset("lib/media/star_3.png") : Image.asset("lib/media/star_2.png"),
                  ),
                  const SizedBox(
                    width: defaultPadding/2,
                  ),
                  Text(likes.toString() , style: const TextStyle(
                    color: Colors.white,
                    fontSize: defaultPadding*3,
                  ),)
                ],
              )),
              const SizedBox(
                width: defaultPadding,
              ),
              Text(parser.emojify('🐡'),
                style: const TextStyle(
                  fontSize: defaultPadding*4,
                ),
              )
            ],
          ),
          const SizedBox(
            height: defaultPadding*2,
          )
        ],
      ),
    );
  }
}
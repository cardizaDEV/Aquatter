import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostCardBottom extends StatefulWidget {
  const PostCardBottom(
      {super.key,
      required this.likes,
      required this.liked,
      required this.user,
      required this.title});

  final int likes;
  final bool liked;
  final String user;
  final String title;

  @override
  State<PostCardBottom> createState() => _PostCardBottomState();
}

class _PostCardBottomState extends State<PostCardBottom> {
  int lines = 3;

  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 3,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      shadows: <Shadow>[
                        Shadow(
                          //offset: Offset(0.0, 0.0),
                          blurRadius: defaultPadding * 4,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                InkWell(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: lines,
                    style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        shadows: <Shadow>[
                          Shadow(
                            //offset: Offset(0.0, 0.0),
                            blurRadius: defaultPadding * 4,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),
                  ),
                  onTap: () {
                    lines == 20 ? lines = 3 : lines = 20;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  child: Row(
                children: [
                  Tab(
                    height: defaultPadding * 3,
                    child: widget.liked
                        ? Image.asset("lib/media/yellow_star.png")
                        : Image.asset("lib/media/white_star.png"),
                  ),
                  const SizedBox(
                    width: defaultPadding / 2,
                  ),
                  Text(
                    widget.likes.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 3,
                    ),
                  )
                ],
              )),
              const SizedBox(
                width: defaultPadding,
              ),
              Text(
                parser.emojify('🐡'),
                style: const TextStyle(
                  fontSize: defaultPadding * 4,
                ),
              )
            ],
          ),
          const SizedBox(
            height: defaultPadding * 2,
          )
        ],
      ),
    );
  }
}

import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/post_card_bottom.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {super.key,
      required this.user,
      required this.image,
      required this.likes,
      required this.liked});

  final String user;
  final Image image;
  final int likes;
  final bool liked;

  @override
  // ignore: no_logic_in_create_state, unnecessary_this
  State<PostCard> createState() => _PostCardState(this.likes,this.liked);
}

class _PostCardState extends State<PostCard> {

  int _likes;
  bool _liked;
  _PostCardState(this._likes,this._liked);

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: primaryColor.withOpacity(0.4),
          width: defaultPadding/4,
        )
      ),
      margin: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      elevation: defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.user, style: 
                const TextStyle(
                  fontSize: defaultPadding*2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          InkWell(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: defaultPadding/4, color: primaryColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: widget.image
              ),
            onDoubleTap: () {
              if (_liked) {
                  _liked = false;
                  _likes--;
                } else {
                  _liked = true;
                  _likes++;
                }
              setState(() {});
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          PostCardBottom(
            likes: _likes,
            liked: _liked,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}
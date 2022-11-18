import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/post_card_bottom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  const PostCard(
      {super.key,
      required this.user,
      required this.image,
      required this.likes,
      required this.liked,
      required this.title,
      required this.comments,
      required this.userId,
      required this.id});

  final String user;
  final String userId;
  final String id;
  final String title;
  final String image;
  final int likes;
  final List<dynamic> comments;
  final bool liked;

  @override
  // ignore: no_logic_in_create_state, unnecessary_this
  State<PostCard> createState() => _PostCardState(this.likes, this.liked);
}

class _PostCardState extends State<PostCard> {
  int _likes;
  bool _liked;
  _PostCardState(this._likes, this._liked);

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
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 10),
            child: InkWell(
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: primaryColor.withOpacity(0.4),
                      width: defaultPadding / 4,
                    )),
                margin: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding),
                elevation: defaultPadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.image)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PostCardBottom(
                          userId: widget.userId,
                          comments: widget.comments,
                          title: widget.title,
                          user: widget.user,
                          likes: _likes,
                          liked: _liked,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onDoubleTap: () {
                if (_liked) {
                  _liked = false;
                  _likes--;
                } else {
                  _liked = true;
                  _likes++;
                }
                _updateLikes();
                setState(() {});
              },
            )));
  }

  void _updateLikes() async {
    var userid = widget.userId;
    var id = widget.id;
    await http.put(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/user/$userid/post/$id'),
      body: {'likes': _likes.toString()},
    );
  }
}

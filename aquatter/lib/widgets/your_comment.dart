import 'package:aquatter/providers/comments_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourComment extends StatefulWidget {
  const YourComment(
      {super.key,
      required this.username,
      required this.userid,
      required this.postid});

  final String username;
  final String userid;
  final String postid;

  @override
  State<YourComment> createState() => _YourCommentState();
}

class _YourCommentState extends State<YourComment> {
  Widget body = Container();
  // ignore: prefer_final_fields
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    _removeCommentArea();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }

  void _removeCommentArea() {
    body = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ElevatedButton(
          child: const Text('Comment'),
          onPressed: () {
            _buildCommentArea();
            setState(() {});
          },
        ),
      ),
    );
  }

  void _buildCommentArea() {
    body = Card(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.username,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: defaultPadding * 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            TextField(
              autocorrect: false,
              controller: _commentController,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(),
                  labelText: 'Your comment'),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Comment'),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      Provider.of<CommentsProvider>(context, listen: false)
                          .postComment(widget.userid, widget.postid,
                              widget.username, _commentController.text);
                      Navigator.pop(context);
                    } else {
                      _commentController.clear();
                      _removeCommentArea();
                    }
                    setState(() {});
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

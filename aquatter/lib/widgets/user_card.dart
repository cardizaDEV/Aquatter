import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {super.key,
      required this.image,
      required this.username,
      required this.posts,
      required this.followers,
      required this.followed,
      required this.userId});

  final String image;
  final String username;
  final int posts;
  final int followers;
  final bool followed;
  final String userId;

  @override
  // ignore: no_logic_in_create_state, unnecessary_this
  State<UserCard> createState() =>
      _UserCardState(this.followers, this.followed);
}

class _UserCardState extends State<UserCard> {
  // ignore: unused_field, prefer_final_fields
  int _followers;
  // ignore: prefer_final_fields
  bool _followed;

  _UserCardState(this._followers, this._followed);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: primaryColor.withOpacity(0.4),
            width: defaultPadding / 4,
          )),
      elevation: defaultPadding,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  widget.username,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: defaultPadding * 2,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            Row(
              children: [
                Column(
                  children: [
                    const Text(
                      'Posts',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: defaultPadding * 1.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.posts.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: defaultPadding * 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Column(
                  children: [
                    const Text(
                      'Followers',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: defaultPadding * 1.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      _followers.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: defaultPadding * 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_followed == true) {
                        int response = await Provider.of<UserProvider>(context,
                                listen: false)
                            .removeFollow(widget.userId);
                        response == 200 ? _followed = false : null;
                      } else {
                        int response = await Provider.of<UserProvider>(context,
                                listen: false)
                            .addFollow(widget.userId);
                        response == 201 ? _followed = true : null;
                      }
                      setState(() {});
                    },
                    child: Text(_followed ? 'UnFollow' : 'Follow'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

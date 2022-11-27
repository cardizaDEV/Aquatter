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
  State<UserCard> createState() =>
      // ignore: no_logic_in_create_state, unnecessary_this
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
      ),
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
                child: InkWell(
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
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 10),
                          child: Card(
                            color: primaryBlack,
                              elevation: defaultPadding,
                              child: FutureBuilder(
                                future: Provider.of<UserProvider>(context)
                                    .getProfile(widget.username),
                                builder:
                                    (context, AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data ?? Container();
                                  } else {
                                    return Container();
                                  }
                                },
                              )),
                        );
                      },
                    );
                  },
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          _followed ? primaryBlack : Colors.white),
                      side: MaterialStatePropertyAll(BorderSide(
                          color: _followed ? Colors.transparent : primaryBlack,
                          width: 2)),
                    ),
                    onPressed: () async {
                      if (_followed == true) {
                        int response = await Provider.of<UserProvider>(context,
                                listen: false)
                            .removeFollow(widget.userId);
                        if (response == 200) {
                          _followed = false;
                          _followers--;
                        }
                      } else {
                        int response = await Provider.of<UserProvider>(context,
                                listen: false)
                            .addFollow(widget.userId);
                        if (response == 201) {
                          _followed = true;
                          _followers++;
                        }
                      }
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          .modifyCard(widget.userId, _followers, widget.posts,
                              widget.image, _followed, widget.username);
                      setState(() {});
                    },
                    child: Text(
                      _followed ? 'Following' : 'Follow',
                      style: TextStyle(
                          color: _followed ? Colors.white : primaryBlack),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

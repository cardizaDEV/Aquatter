import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    //Provider.of<UserProvider>(context, listen: false).searchForUsers('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: primaryBlack,
          image: DecorationImage(
            image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          )),
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: defaultPadding * 10,
            top: defaultPadding,
            right: defaultPadding,
            left: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(defaultPadding * 2),
                          width: 18,
                          child: const Icon(Icons.search),
                        )),
                    autocorrect: false,
                    maxLines: 1,
                    onSubmitted: (value) async {
                      Provider.of<UserProvider>(context, listen: false)
                          .searchForUsers(_searchController.text);
                    },
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Consumer<UserProvider>(builder: (context, provider, child) {
                    return Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          Provider.of<UserProvider>(context).userCards.length,
                      itemBuilder: (context, index) {
                        return Provider.of<UserProvider>(context)
                            .userCards[index];
                      },
                    ));
                  }),
                  FutureBuilder(
                    future:
                        Provider.of<UserProvider>(context).getMostFollowed(),
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: defaultPadding,
                            ),
                            const Text(
                              'Top Followed',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: defaultPadding * 3,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            snapshot.data ?? Container()
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

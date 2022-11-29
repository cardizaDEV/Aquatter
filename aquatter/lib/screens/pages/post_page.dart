import 'dart:io';

import 'package:aquatter/providers/image_picker_provider.dart';
import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // ignore: prefer_final_fields
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerProvider>(
      builder: (context, value, child) {
        if (value.image == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'No image selected',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: defaultPadding * 3,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                  onPressed: () async {
                    value.selectImage();
                  },
                  child: const Text("Select from gallery"))
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 10),
            child: Card(
                color: Colors.white.withOpacity(0.05),
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding),
                elevation: defaultPadding,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(value.image!.path),
                          fit: BoxFit.fitHeight,
                        )),
                    const SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autocorrect: false,
                        controller: _titleController,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryBlack,
                            labelStyle: const TextStyle(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: const OutlineInputBorder(),
                            labelText: 'Title'),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryBlack),
                            side: const MaterialStatePropertyAll(
                                BorderSide(color: Colors.white, width: 2)),
                          ),
                          onPressed: () async {
                            if (_titleController.text.isNotEmpty &&
                                value.image != null) {
                              String result = await Provider.of<PostsProvider>(
                                      context,
                                      listen: false)
                                  .addPost(
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userId,
                                      File(value.image!.path),
                                      _titleController.text);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: Card(child: Text(result)));
                                },
                              );
                              // ignore: use_build_context_synchronously
                              Provider.of<ImagePickerProvider>(context,
                                      listen: false)
                                  .empty();
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, 'MainScreen');
                            }
                          },
                          child: const Text(
                            'Post',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                )),
          );
        }
      },
    );
  }
}

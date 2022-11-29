import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileConfig extends StatefulWidget {
  const ProfileConfig({super.key});

  @override
  State<ProfileConfig> createState() => _ProfileConfigState();
}

class _ProfileConfigState extends State<ProfileConfig> {
  // ignore: prefer_final_fields
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(defaultPadding),
      color: Colors.white.withOpacity(0.05),
      child: Column(
        children: [
          Consumer<UserProvider>(
            builder: (context, value, child) {
              return TextField(
                  autocorrect: false,
                  controller: _descriptionController..text = value.description,
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: value.description,
                    fillColor: primaryBlack,
                    labelStyle: const TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: const OutlineInputBorder(),
                    labelText: 'Your description',
                  ));
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_descriptionController.text.isNotEmpty) {
                final result =
                    await Provider.of<UserProvider>(context, listen: false)
                        .changeDescription(_descriptionController.text);
                _descriptionController.clear();
                if (result == 200 || result == 204) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                                  context, 'MainScreen');
                }
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}

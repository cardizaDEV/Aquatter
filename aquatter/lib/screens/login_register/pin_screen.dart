import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/user_provider.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pinText = '';
  TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          )),
      child: Scaffold(
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(defaultPadding * 2),
            color: Colors.white.withOpacity(1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  right: screenHeight / 12,
                  left: screenHeight / 12,
                  top: screenHeight / 16,
                  bottom: screenHeight / 16),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                PinCodeTextField(
                  controller: pinCodeController,
                  autoFocus: true,
                  autoUnfocus: true,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    inactiveColor: primaryColor,
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  appContext: context,
                  length: 4,
                  onCompleted: (value) async {
                    if (await _isTheRealPincode(value) == true) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setUsername(await _getUsername());
                      // ignore: use_build_context_synchronously
                      Provider.of<PostsProvider>(context, listen: false)
                          // ignore: use_build_context_synchronously
                          .reloadPosts(Provider.of<UserProvider>(context, listen: false).username);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'MainScreen');
                    } else {
                      pinCodeController.clear();
                    }
                  },
                  onChanged: (String value) {
                    setState(() {
                      pinText = value;
                    });
                  },
                ),
                const SizedBox(
                  height: defaultPadding * 3,
                ),
                ElevatedButton(
                  child: const Text('Back'),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'FirstScreen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _isTheRealPincode(String pinCode) async {
    bool result = false;
    String username = await _getUsername();
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username'));
    if (usersResponse.statusCode == 200) {
      var usersList = convert.jsonDecode(usersResponse.body) as List<dynamic>;
      for (var element in usersList) {
        if (element['username'] == username) {
          if (element['pincode'] == pinCode) {
            return true;
          }
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${usersResponse.statusCode}.');
    }
    return result;
  }

  Future<String> _getUsername() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    return prefs.getString('username') ?? '';
  }
}

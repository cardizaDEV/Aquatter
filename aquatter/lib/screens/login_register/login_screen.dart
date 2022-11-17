import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: prefer_final_fields
  TextEditingController _passwordController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _usernameController = TextEditingController();
  bool _validationUsername = true;
  bool _validationPassword = true;

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
                TextField(
                  autocorrect: false,
                  maxLines: 1,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      errorText:
                          _validationUsername ? null : 'This user doesnt exist',
                      border: const OutlineInputBorder(),
                      labelText: 'Username'),
                ),
                const SizedBox(
                  height: defaultPadding,
                  width: defaultPadding,
                ),
                TextField(
                  autocorrect: false,
                  maxLines: 1,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      errorText: _validationPassword ? null : 'Wrong password',
                      border: const OutlineInputBorder(),
                      labelText: 'Password'),
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                  width: defaultPadding * 2,
                ),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    _passwordController.text.isEmpty ||
                            await _isTheRealPassword(_usernameController.text,
                                    _passwordController.text) ==
                                false
                        ? _validationPassword = false
                        : _validationPassword = true;
                    setState(() {});
                    _usernameController.text.isEmpty ||
                            await _usernameExisting(_usernameController.text) ==
                                false
                        ? _validationUsername = false
                        : _validationUsername = true;
                    setState(() {});
                    if (_validationPassword == true &&
                        _validationUsername == true) {
                      await _setLoged(_usernameController.text);
                      await
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'MainScreen');
                    }
                  },
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

  Future<bool> _usernameExisting(String username) async {
    bool result = false;
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/user?username=$username'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        if (element['username'] == username) {
          result = true;
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  Future<bool> _isTheRealPassword(String username, String password) async {
    bool result = false;
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/user?username=$username'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        if (element['username'] == username) {
          if (element['password'] == password) {
            result = true;
          }
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  Future<bool> _setLoged(String username) async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    await prefs.setString('username', username);
    return true;
  }
}

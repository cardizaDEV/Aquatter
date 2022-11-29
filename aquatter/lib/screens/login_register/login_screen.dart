import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            opacity: 1,
          )),
      child: Scaffold(
        backgroundColor: primaryBlack.withOpacity(0.9),
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
                  obscureText: true,
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
                            await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .isTheRealPassword(_usernameController.text,
                                        _passwordController.text) ==
                                false
                        ? _validationPassword = false
                        : _validationPassword = true;
                    setState(() {});
                    _usernameController.text.isEmpty ||
                            // ignore: use_build_context_synchronously
                            await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .usernameExisting(
                                        _usernameController.text) ==
                                false
                        ? _validationUsername = false
                        : _validationUsername = true;
                    setState(() {});
                    if (_validationPassword == true &&
                        _validationUsername == true) {
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          .setLoged(_usernameController.text);
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          .getUserId(_usernameController.text);
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          .searchForUsers('');
                      // ignore: use_build_context_synchronously
                      Provider.of<PostsProvider>(context, listen: false)
                          .reloadPosts(
                              // ignore: use_build_context_synchronously
                              Provider.of<UserProvider>(context, listen: false)
                                  .username);
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
}

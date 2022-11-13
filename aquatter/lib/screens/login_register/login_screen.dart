import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              margin: const EdgeInsets.all(defaultPadding*2),
              color: Colors.white.withOpacity(1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                  const TextField(
                    autocorrect: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Username'),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                    width: defaultPadding,
                  ),
                  const TextField(
                    autocorrect: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                    width: defaultPadding * 2,
                  ),
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () => loginVerification(context), //TODO
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

  void loginVerification(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'SocialScreen');
  }
}

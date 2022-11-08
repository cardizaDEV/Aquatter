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
            )
        ),
      child: Scaffold(
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
              right: screenHeight / 12,
              left: screenHeight / 12,
              top: screenHeight / 8,
              bottom: screenHeight / 12),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Placeholder(
              fallbackHeight: screenHeight / 10,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: screenHeight / 16),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                const TextField(
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
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
                  child: const Text('Send'),
                  onPressed: () => loginVerification(context),
                ),
                ElevatedButton(
                  child: const Text('Back'),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'FirstScreen'),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  void loginVerification(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'SocialScreen');
  }
}

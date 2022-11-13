import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

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
            body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 10, horizontal: defaultPadding * 4),
          child: Center(
            child: Card(
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
                  const Image(
                    fit: BoxFit.cover,
                    image: AssetImage("lib/media/Aquatter.png"),
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, 'LoginScreen'),
                      ),
                      ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, 'RegisterScreen'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}

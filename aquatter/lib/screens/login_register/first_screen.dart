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
              const Placeholder(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: screenHeight / 16),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'LoginScreen'),
                  ),
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'RegisterScreen'),
                  ),
                ],
              )
            ],
          ),
      )
    );
  }
}

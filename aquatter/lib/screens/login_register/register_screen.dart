import 'package:aquatter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/constants.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ignore: prefer_final_fields
  TextEditingController _emailController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _usernameController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _passwordController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _pincodeController = TextEditingController();
  // ignore: prefer_final_fields
  String _usernameError = 'Example: myUsername';
  bool _validationEmail = true;
  bool _validationUsername = true;
  bool _validationPassword = true;
  bool _validationPincode = true;

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
                      errorText: _validationUsername ? null : _usernameError,
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
                  controller: _emailController,
                  decoration: InputDecoration(
                      errorText: _validationEmail
                          ? null
                          : 'Example: myemail@gmail.com',
                      border: const OutlineInputBorder(),
                      labelText: 'Email'),
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
                      errorText:
                          _validationPassword ? null : 'Example: myPassword',
                      border: const OutlineInputBorder(),
                      labelText: 'Password'),
                ),
                const SizedBox(
                  height: defaultPadding,
                  width: defaultPadding,
                ),
                TextField(
                  autocorrect: false,
                  maxLines: 1,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: _pincodeController,
                  decoration: InputDecoration(
                      errorText: _validationPincode ? null : 'Example: 1234',
                      border: const OutlineInputBorder(),
                      labelText: 'Pin Code'),
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                  width: defaultPadding * 2,
                ),
                ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      _emailController.text.isEmpty
                          ? _validationEmail = false
                          : _validationEmail = true;
                      setState(() {});
                      _passwordController.text.isEmpty
                          ? _validationPassword = false
                          : _validationPassword = true;
                      setState(() {});
                      _usernameController.text.isEmpty ||
                              await Provider.of<UserProvider>(context, listen: false)
                                      .usernameExisting(
                                          _usernameController.text) ==
                                  true
                          ? _validationUsername = false
                          : _validationUsername = true;
                      setState(() {});
                      _pincodeController.text.isEmpty ||
                              _pincodeController.text.length != 4 ||
                              isNumeric(_pincodeController.text) == false
                          ? _validationPincode = false
                          : _validationPincode = true;
                      setState(() {});
                      _emailController.text.isEmpty ||
                              !(EmailValidator.validate(_emailController.text))
                          ? _validationEmail = false
                          : _validationEmail = true;
                      setState(() {});
                      if (_validationEmail == true &&
                          _validationUsername == true &&
                          _validationPassword == true &&
                          _validationPincode == true) {
                        // ignore: use_build_context_synchronously
                        await Provider.of<UserProvider>(context, listen: false).registerUser(
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _pincodeController.text);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'LoginScreen');
                      }
                    }),
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

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

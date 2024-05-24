import 'package:flutter/material.dart';
import 'package:nexa_test/pages/components/button_elevation.dart';
import 'package:nexa_test/pages/widgets/loading.dart';
import 'package:nexa_test/provider/auth_provider.dart';
import 'package:nexa_test/shared/assets.dart';
import 'package:nexa_test/shared/color_app.dart';
import 'package:nexa_test/shared/shared.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 100, // Adjust the height as needed
          child: const LoadingIndicator(),
        ),
      ),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //! Logo
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  ImageAssets.get(ImageAssets.logo),
                ),
              ),
              //! Text subtitle
              const Text(
                'Kesehatan adalah aset berharga',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8696BB)),
              ),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: username,
                cursorColor: ColorApp.primaryColor,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Image.asset(
                      IconAssets.get(IconAssets.userInput),
                    ),
                    fillColor: const Color(0xffFAFAFA),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 151, 151, 151),
                    ),
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 151, 151, 151),
                    ),
                    filled: true,
                    hintText: 'Username',
                    labelText: "Username",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffFAFAFA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 0, color: Color(0xffFAFAFA)))),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                cursorColor: ColorApp.primaryColor,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Image.asset(
                      IconAssets.get(IconAssets.key),
                    ),
                    fillColor: const Color(0xffFAFAFA),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 151, 151, 151),
                    ),
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 151, 151, 151),
                    ),
                    filled: true,
                    hintText: 'Password',
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffFAFAFA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 0, color: Color(0xffFAFAFA)))),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomElevationButton(
                height: 50,
                width: 200,
                color: ColorApp.primaryColor,
                text: "Masuk",
                onTap: () async {
                  _showLoadingDialog(context);
                  bool loginSuccess =
                      await Provider.of<AuthProvider>(context, listen: false)
                          .login(username.text, password.text);
                  _hideLoadingDialog(context);

                  if (!loginSuccess) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Login failed')));
                  }
                },
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

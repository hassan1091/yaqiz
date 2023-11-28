import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/page/home.dart';
import 'package:yaqiz/page/signup.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController idController;
  late TextEditingController passwordController;

  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight, horizontal: 16.0),
          child: Form(
              child: ListView(
            children: [
              Image.asset("assets/yaqiz_logo.png", height: 200,fit: BoxFit.cover),
              MyTextFormField(
                controller: idController,
                lable: "Employee ID",
                hint: "Enter Your Employee ID",
                type: TextInputType.number,
              ),
              const SizedBox(height: 12),
              MyTextFormField(
                controller: passwordController,
                lable: "Password",
                hint: "Enter Your Password",
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          value: isRemember,
                          onChanged: (value) {
                            setState(() {
                              isRemember = value ?? !isRemember;
                            });
                          }),
                      const Text("Remember Me")
                    ],
                  ),
                  InkWell(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _login, child: const Text("Login")),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account ?"),
                  InkWell(
                    onTap: _signup,
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }

  void _login() {
    ApiService()
        .login(idController.text, passwordController.text)
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(isAdmin: value),
            )))
        .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(title: Text(error.toString()));
              },
            ));
  }

  void _signup() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignupPage(),
        ));
  }
}

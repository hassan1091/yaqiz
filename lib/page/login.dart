import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/field_validation.dart';
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
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight, horizontal: 16.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset("assets/yaqiz_logo.png",
                      height: 200, fit: BoxFit.cover),
                  MyTextFormField(
                    controller: _idController,
                    lable: "Employee ID",
                    hint: "Enter Your Employee ID",
                    type: TextInputType.number,
                    validator: FieldValidation.validateRequired,
                  ),
                  const SizedBox(height: 12),
                  MyTextFormField(
                    controller: _passwordController,
                    lable: "Password",
                    hint: "Enter Your Password",
                    isPassword: true,
                    validator: FieldValidation.validateRequired,
                  ),
                  const SizedBox(height: 12),
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
    if (_formKey.currentState!.validate()) {
      ApiService()
          .login(_idController.text, _passwordController.text)
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(isSupervisor: value),
              )))
          .onError((error, stackTrace) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(title: Text(error.toString()));
                },
              ));
    }
  }

  void _signup() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignupPage(),
        ));
  }
}

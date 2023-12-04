import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/api/medel/user.dart';
import 'package:yaqiz/field_validation.dart';
import 'package:yaqiz/page/home.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSupervisor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight, horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              const Center(
                  child: Text(
                "Create an account",
                style: TextStyle(fontSize: 24),
              )),
              const SizedBox(height: 64),
              MyTextFormField(
                controller: _idController,
                hint: "Enter Your Employee ID",
                lable: "Employee ID",
                type: const TextInputType.numberWithOptions(),
                validator: FieldValidation.validateId,
              ),
              const SizedBox(height: 12),
              MyTextFormField(
                controller: _emailController,
                hint: "Email",
                lable: "Enter Your Email",
                validator: FieldValidation.validateEmail,
              ),
              const SizedBox(height: 12),
              MyTextFormField(
                controller: _phoneController,
                hint: "Enter Your Phone Number",
                lable: "Phone Number",
                type: const TextInputType.numberWithOptions(),
                validator: FieldValidation.validatePhone,
              ),
              const SizedBox(height: 12),
              MyTextFormField(
                controller: _passwordController,
                lable: "Password",
                hint: "Enter Your Password",
                isPassword: true,
                validator: FieldValidation.validatePassword,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      value: _isSupervisor,
                      onChanged: (value) {
                        setState(() {
                          _isSupervisor = value ?? !_isSupervisor;
                        });
                      }),
                  const Text("Supervisor")
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _signup, child: const Text("Signup")),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  InkWell(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      ApiService()
          .signup(User(
              employeeID: int.parse(_idController.text),
              employeeEmail: _emailController.text,
              employeePassword: _passwordController.text,
              employeePhone: int.parse(_phoneController.text),
              isAdmin: _isSupervisor))
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
}

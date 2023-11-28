import 'package:flutter/material.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController idController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController phoneController;

  bool isAdmin = false;

  @override
  void initState() {
    idController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight, horizontal: 16),
          child: Form(
            child: ListView(children: [
              const Center(
                  child: Text(
                "Create an account",
                style: TextStyle(fontSize: 24),
              )),
              const SizedBox(height: 64),
              MyTextFormField(
                controller: idController,
                hint: "Enter Your Employee ID",
                lable: "Employee ID",
                type: TextInputType.text,
              ),
              const SizedBox(height: 12),
              MyTextFormField(
                  controller: emailController,
                  hint: "Email",
                  lable: "Enter Your Email"),
              const SizedBox(height: 12),
              MyTextFormField(
                  controller: phoneController,
                  hint: "Enter Your Phone Number",
                  lable: "Phone Number"),
              const SizedBox(height: 12),
              MyTextFormField(
                controller: passwordController,
                lable: "Password",
                hint: "Enter Your Password",
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      value: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value ?? !isAdmin;
                        });
                      }),
                  const Text("Supervisor")
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: () {}, child: const Text("Signup")),
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
}

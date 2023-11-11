import 'package:flutter/material.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController messageController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  SizedBox(
                    height: kToolbarHeight,
                    child: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(height: 16),
                  const Text("Contact Us",
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const MyTextFormField(
                    lable: "Full Name",
                    hint: "Enter Your Full Name",
                  ),
                  const SizedBox(height: 16),
                  const MyTextFormField(
                    lable: "Email",
                    hint: "Enter Your Email",
                  ),
                  const SizedBox(height: 16),
                  const MyTextFormField(
                    lable: "Message",
                    hint: "Enter Your Message",
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(onPressed: () {}, child: const Text("Send"))
                ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    lable: "Full Name",
                    hint: "Enter Your Full Name",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    lable: "Title",
                    hint: "Enter Your Title",
                    controller: _titleController,
                  ),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    lable: "Message",
                    hint: "Enter Your Message",
                    controller: _messageController,
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(onPressed: _send, child: const Text("Send"))
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> _send() async {
    final uri = Uri.parse(
        'mailto:yaqiz.official@gmail.com?subject=${_titleController.text}&body=Dear ${_nameController.text},\n\n${_messageController.text}');
    await launchUrl(uri);
  }
}

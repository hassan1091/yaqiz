import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField(
      {Key? key,
      required this.lable,
      this.controller,
      this.hint,
      this.initial,
      this.isPassword = false,
      this.isReadOnly = false,
      this.isAddressMap = false,
      this.type,
      this.validator,
      this.onTap,
      this.onEditingComplete})
      : super(key: key);
  final String lable;
  final TextEditingController? controller;
  final String? hint;
  final String? initial;
  final TextInputType? type;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool isReadOnly;
  final bool isAddressMap;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool isSecure;

  void switchSecure() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  void initState() {
    isSecure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          label: Text(widget.lable),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: const OutlineInputBorder(),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: switchSecure,
                  icon:
                      Icon(isSecure ? Icons.visibility_off : Icons.visibility))
              : widget.isAddressMap
                  ? IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(Icons.add_location_alt_outlined))
                  : null,
          hintText: widget.hint),
      keyboardType: widget.type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      initialValue: widget.initial,
      inputFormatters: widget.type == TextInputType.number
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'\d')),
            ]
          : null,
      controller: widget.controller,
      obscureText: isSecure,
      readOnly: widget.isReadOnly,
      enableSuggestions: !isSecure,
      onEditingComplete: widget.onEditingComplete,
      onTap: !widget.isAddressMap ? widget.onTap : null,
    );
  }
}

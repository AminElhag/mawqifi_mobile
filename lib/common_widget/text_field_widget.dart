import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.textInputType,
      this.validator,
      this.controller,
      this.validationKey, this.text});

  final String hintText;
  final String labelText;
  final String? text;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final GlobalKey<FormState>? validationKey;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.hintText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.validationKey,
      child: TextFormField(
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        validator: widget.validator,
        controller: widget.controller,
      ),
    );
  }
}

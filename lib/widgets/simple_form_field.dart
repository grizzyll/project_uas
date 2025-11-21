import 'package:flutter/material.dart';

class SimpleFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  const SimpleFormField({super.key, required this.controller, required this.label, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    );
  }
}

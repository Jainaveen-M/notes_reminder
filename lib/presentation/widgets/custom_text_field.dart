import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10,
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 4),
            borderRadius: BorderRadius.circular(12),
          ),
          label: Text(hint),
        ),
      ),
    );
  }
}

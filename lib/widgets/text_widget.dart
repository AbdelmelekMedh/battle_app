import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final String? hint;

  const TextWidget({
    super.key,
    required this.controller,
    this.hint,
    this.validator,
    required this.label,
    required this.icon,
    this.obscureText = false,
    required this.keyboardType,
    required this.textInputAction,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: controller,
              validator: validator,
              minLines: maxLines == null ? 1 : null,
              maxLines: maxLines,
              decoration: InputDecoration(
                hint: Text(hint?.toString() ?? '', style: const TextStyle(color: Colors.black54)),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              obscureText: obscureText,
              style: const TextStyle(color: Colors.black87, fontSize: 18),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
            ),
          ),
        ],
      ),
    );
  }
}

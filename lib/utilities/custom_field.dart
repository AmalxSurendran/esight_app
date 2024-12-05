import 'package:flutter/services.dart';
import 'package:esight_app/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? child;

  const Customfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.child,
  });

  @override
  State<Customfield> createState() => _CustomfieldState();
}

class _CustomfieldState extends State<Customfield> {
  @override
  Widget build(BuildContext context) {
    // TextInputFormatter to add ₹ symbol
    final TextInputFormatter currencyFormatter =
        TextInputFormatter.withFunction(
      (oldValue, newValue) {
        String newText = newValue.text;

        // Only add ₹ at the beginning if the text is not empty
        if (newText.isNotEmpty && !newText.startsWith('₹')) {
          newText = '₹ $newText';
        }

        return TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Pallete.textcolor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Pallete.formtextcolor,
                  ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.textfieldcordercolor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.textfieldcordercolor,
              ),
            ),
            errorStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Pallete.warningred,
            ),
            border: const OutlineInputBorder(),
            suffixIcon: widget.suffixIcon,
          ),
          validator: widget.validator,
          inputFormatters: [currencyFormatter], // Apply formatter
        ),
        if (widget.child != null) ...[
          const SizedBox(height: 10),
          widget.child!,
        ],
      ],
    );
  }
}

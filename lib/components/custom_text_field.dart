import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData icon;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscure : false,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.left,

        cursorColor: Color(0xFF2ECC71),
        decoration: InputDecoration(
          labelText: widget.label,
          alignLabelWithHint: true,

          floatingLabelStyle: const TextStyle(color: Color(0xFF2ECC71)),

          filled: true,
          fillColor: const Color(0xFFF4F4F4),

          prefixIcon: Icon(widget.icon, color: Colors.grey),

          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  )
                  : null,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF2ECC71), width: 1.5),
          ),
        ),
      ),
    );
  }
}

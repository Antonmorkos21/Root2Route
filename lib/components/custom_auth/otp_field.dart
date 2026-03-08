import 'package:flutter/material.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key});
  @override
  State<OtpField> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpField> {
  final int length = 4;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (index) => TextEditingController());
    focusNodes = List.generate(length, (index) => FocusNode());
  }

  @override
  void dispose() {
    // إغلاق كل العناصر دفعة واحدة
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get otp => controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (index) => _buildOtpBox(index)),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < length - 1) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }

          if (otp.length == length) {
          }
        },
      ),
    );
  }
}

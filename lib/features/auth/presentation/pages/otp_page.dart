import 'package:flutter/material.dart';
class OtpPage extends StatelessWidget {
  final String mobile;
  const OtpPage({super.key, required this.mobile});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text('OTP: $mobile')),
  );
}

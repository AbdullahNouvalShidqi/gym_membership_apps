import 'package:flutter/material.dart';
import 'components.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgotPassword';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainLogo(),
              const MainTitle(),
              const SizedBox(height: 35),
              Form(key: _formKey, child: EmailFormField(emailCtrl: _emailCtrl)),
              const SizedBox(height: 24),
              ContinueButton(
                formKey: _formKey,
                emailCtrl: _emailCtrl,
              )
            ],
          ),
        ),
      ),
    );
  }
}

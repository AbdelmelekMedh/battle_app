import 'dart:convert';

import 'package:battle_app/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/gradient_container.dart';
import '../widgets/text_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final res = await AuthApi.signUp(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (res.statusCode == 200 && mounted) {
      Navigator.of(context).pushNamed('/signIn');
    } else if (mounted) {
      final body = json.decode(res.body);
      final errors = body['errors'];
      if (errors != null && errors is Map) {
        final messages =
            errors.values.expand((e) => e as List).join('\n');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messages)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(body['message'] ?? 'An unknown error occurred.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          const GradientContainer(),
          Form(
            key: _formKey,
            child: Column(
              children:[
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height / 8),
                        const Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 20),
                        TextWidget(
                          controller: _usernameController,
                          label: 'Username',
                          icon: FontAwesomeIcons.user,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              (value?.isEmpty ?? true) ? 'Username is required' : null,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 50),
                        TextWidget(
                          controller: _emailController,
                          label: 'Your email',
                          icon: FontAwesomeIcons.envelope,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              (value?.isEmpty ?? true) ? 'Email is required' : null,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 50),
                        TextWidget(
                          controller: _passwordController,
                          label: 'Create a password',
                          icon: FontAwesomeIcons.lock,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validator: (value) => (value?.isEmpty ?? true)
                              ? 'Password is required'
                              : null,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 50),
                        TextWidget(
                          controller: _confirmPasswordController,
                          label: 'Confirm password',
                          icon: FontAwesomeIcons.lock,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 20),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 15,
                            child: ElevatedButton(
                              onPressed: save,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(30))),
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

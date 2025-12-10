import 'package:battle_app/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/login_model.dart';
import '../services/shared_service.dart';
import '../widgets/gradient_container.dart';
import '../widgets/showMessage.dart';
import '../widgets/text_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final res = await AuthApi.signIn(
      _usernameController.text,
      _passwordController.text,
    );

    if (res.statusCode == 200) {
      LoginResponseModel logResModel = loginResponseModelFromJson(res.body);
      if (logResModel.token.isNotEmpty) {
        await SharedService.setLoginDetails(logResModel);
        if (mounted) {
          Navigator.of(context).pushNamed('/home', arguments: logResModel);
        }
      }
    } else {
      if (mounted) {
        showMessage(context, "Login Error", "Invalid username or password", "OK",
            () => Navigator.of(context).pop());
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
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height / 6),
                        const Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 8),
                        TextWidget(
                          controller: _usernameController,
                          label: 'Username',
                          icon: FontAwesomeIcons.user,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) => (value?.isEmpty ?? true)
                              ? 'Username is required'
                              : null,
                        ),
                        TextWidget(
                          controller: _passwordController,
                          label: 'Password',
                          icon: FontAwesomeIcons.lock,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) => (value?.isEmpty ?? true)
                              ? 'Password is required'
                              : null,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 20),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 15,
                            child: ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'LET\'S GO',
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
                Center(
                  child: InkWell(
                    onTap: () {
                      print("forget password?");
                    },
                    child: Text(
                      "forget password?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.4),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

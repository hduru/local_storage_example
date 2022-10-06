// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_storage_example/main.dart';
import 'package:local_storage_example/models/user.dart';
import 'package:local_storage_example/services/local_storage_service.dart';
import 'package:local_storage_example/ui/home_page.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LocalStorageService _preferenceService = locator<LocalStorageService>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  late User user;

  @override
  void initState() {
    super.initState();

    _getStorageData();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  void _getStorageData() async {
    var data = await _preferenceService.getUserInformation();
    setState(() {
      _emailController.text = data.email;
      _passwordController.text = data.password;
      _rememberMe = data.rememberMe;
    });
  }

  Widget _buildEmailTextField() => TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          suffixIcon: _emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _emailController.clear(),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          labelText: "Email",
          labelStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          hintText: "Enter email",
          hintStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
          ),
        ),
        autofillHints: const [AutofillHints.email],
      );

  Widget _buildPasswordTextField() => TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: _passwordController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _passwordController.clear(),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          labelText: "Password",
          labelStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          hintText: "Enter Password",
          hintStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
          ),
        ),
        autofillHints: const [AutofillHints.email],
      );

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey.shade600),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(onClicked) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        width: double.infinity,
        height: 66.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: const Color(0xFF392936),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            textStyle: const TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed: onClicked,
          child: const Text("LOGIN"),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF84abe0),
                    Color(0xFFa7c3e9),
                    Color(0xFFcadbf2),
                    Color(0xFFedf3fb),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEmailTextField(),
                        const SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                        const SizedBox(height: 20.0),
                        _buildRememberMeCheckbox(),
                        const SizedBox(height: 40.0),
                        _buildSignUpButton(() {
                          final form = _formKey.currentState!;
                          if (form.validate()) {
                            var userStorage = User(
                              email: _emailController.text,
                              password: _passwordController.text,
                              rememberMe: _rememberMe,
                            );

                            //Save Storage
                            _preferenceService.saveUserInformation(userStorage);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_page/helper/validation_mixin.dart';
import 'package:login_page/second_screen.dart';

import 'api/auth_api.dart';
import 'helper/constants.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> with ValidationMixin {
  String? email, password;
  bool obscureText = true;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        validator: validateEmail,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        validator: validatePassword,
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Widget _buildLoginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    onLoginButtonClick(context);
                  },
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  Widget _buildOrRow() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        '- OR -',
        style: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildFacebookBtn() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
        ],
      ),
      child: Icon(
        FontAwesomeIcons.facebook,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildFingerPrintBtn() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 1), blurRadius: 6.0)
        ],
      ),
      child: Icon(
        FontAwesomeIcons.fingerprint,
        color: Colors.black,
      ),
    );
  }

  Widget _buildContainer(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildEmailRow(),
                        _buildPasswordRow(),
                        _buildLoginButton(context),
                        _buildOrRow(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildFacebookBtn(),
                            SizedBox(
                              width: 20,
                            ),
                            _buildFingerPrintBtn(),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Dont have an account? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: mainColor,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children:[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                _buildLogo(),
                _buildContainer(context),
                _buildSignUpBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> onLoginButtonClick(context) async {
    bool validInput = formKey.currentState!.validate();
    if (validInput) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      var response = await authApi.signup(email!, password!);
      setState(() {
        isLoading = false;
      });

      if (response == null) {
        ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(SnackBar(content: Text("Sign up failed")));
      } else {
        var data = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SecondScreen(email: email!);
        }));
      }
    }
  }
}

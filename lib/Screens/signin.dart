import 'package:flutter/material.dart';
import 'package:WeTalk/backend/functions.dart';
import 'package:WeTalk/backend/services.dart';

class Signin extends StatefulWidget {
  final Function toggle;
  Signin(this.toggle);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var _formkey = GlobalKey<FormState>();

  bool isloading = false;
  Authmethods authmethods = Authmethods();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      authmethods.signup(email.text, password.text).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('WeTalk App'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: username,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter Username';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: "Username"),
                      ),
                      TextFormField(
                        controller: email,
                        validator: Functions().validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        validator: (String value) {
                          if (value.length < 8 && value.isEmpty) {
                            return 'Please provide 8+ character password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      FlatButton(
                          onPressed: () {
                            signup();
                          },
                          child: Text('Sign in')),
                      FlatButton(
                          onPressed: () {}, child: Text('Signin with google')),
                      Text("Have already account"),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            widget.toggle();
                          });
                        },
                        child: Text('Login Now'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

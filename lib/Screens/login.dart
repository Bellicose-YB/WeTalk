import 'package:flutter/material.dart';
import 'package:WeTalk/backend/functions.dart';
import 'package:WeTalk/backend/services.dart';

class Loginpage extends StatefulWidget {
  final Function toggle;

  Loginpage(this.toggle);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var _formkey = GlobalKey<FormState>();
  bool isloading = false;
  Authmethods authmethods = Authmethods();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  login() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      authmethods.login(email.text, password.text).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: email,
                  validator: Functions().validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                FlatButton(
                    onPressed: () {
                      login();
                    },
                    child: Text('Login')),
                FlatButton(onPressed: () {}, child: Text('Signin with google')),
                Text("Don't have an account"),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      widget.toggle();
                    });
                  },
                  child: Text('Register Now'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

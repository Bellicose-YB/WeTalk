import 'package:WeTalk/widgets/curvedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:WeTalk/backend/functions.dart';
import 'package:WeTalk/backend/services.dart';

class Signin extends StatefulWidget {
  final Function toggle;
  Signin(this.toggle);

  @override
  _SigninState createState() => _SigninState(toggle);
}

class _SigninState extends State<Signin> {
  var _formkey = GlobalKey<FormState>();
  bool isload = false;
  Authmethods authmethods = Authmethods();
  Function toggle;

  _SigninState(this.toggle);

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        isload = true;
      });
      try {
        User user = await authmethods.signup(email.text, password.text);
        if (user.id != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } catch (e) {
        print('Error : $e');
        setState(() {
          isload = false;
          showsnackbar(context, 'Enter correct Information');
        });
      }
    }
  }

  Widget _entryField(
      String title, TextEditingController controller, Function validator,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: validator,
              controller: controller,
              obscureText: isPassword,
              decoration:
                  InputDecoration(fillColor: Color(0xfff3f3f4), filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        signup();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(4, 6),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleButton() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isload = true;
        });
        try {
          FirebaseUser user = await authmethods.loginwithgoogle();
          if (user != null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          }
        } catch (e) {
          print('Error : $e');
          setState(() {
            isload = false;
            showsnackbar(context, 'Error Sign in with Google');
          });
        }
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 6),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    color: Colors.red[900],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset('assets/google_logo.png')),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(4, 6),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Sign in with Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have a account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () => toggle(),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'W',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.subtitle1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            //color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'e',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
            TextSpan(
              text: 'T',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'alk',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailusernamePasswordWidget() {
    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            _entryField("Username", username, Functions().validateUsername),
            _entryField("Email id", email, Functions().validateEmail),
            _entryField("Password", password, Functions().validatePassword,
                isPassword: true),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return isload
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  'Loading',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          )
        : Scaffold(
            body: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
                Positioned(
                    top: height * 0.20,
                    left: -MediaQuery.of(context).size.width * .45,
                    child: BezierContainer()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 5),
                        _emailusernamePasswordWidget(),
                        SizedBox(height: 20),
                        _submitButton(),
                        GestureDetector(
                          onTap: () {
                            if (email.text.length > 0 &&
                                email.text.contains('@')) {
                              authmethods.resetpassword(email.text);
                            } else {
                              showsnackbar(
                                  context, 'Enter correct Email address');
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        _divider(),
                        _googleButton(),
                        SizedBox(height: height * .005),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
  }

  void showsnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color(0xFFFCE4EC)),
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xFF1A237E),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:WeTalk/widgets/widgets.dart';
import 'package:WeTalk/Screens/home.dart';
import 'package:WeTalk/Screens/login.dart';
import 'package:WeTalk/Screens/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'WeTalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomeScreen(),
      },
      home: Connectionmain(),
    );
  }
}

class Connectionmain extends StatefulWidget {
  Connectionmain({Key key}) : super(key: key);

  @override
  _ConnectionmainState createState() => _ConnectionmainState();
}

class _ConnectionmainState extends State<Connectionmain> {
  bool _isonline;
  bool startpage = true;

  void toggle() {
    setState(() {
      startpage = !startpage;
    });
  }

  @override
  void initState() {
    _checkconnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this._isonline == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : (this._isonline
            ? Scaffold(
                body: startpage ? Loginpage(toggle) : Signin(toggle),
              )
            : Widgets().connectionerror());
  }

  void _checkconnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        this._isonline = true;
      });
    } else {
      setState(() {
        this._isonline = false;
      });
    }
  }
}

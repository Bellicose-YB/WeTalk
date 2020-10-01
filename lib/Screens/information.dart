import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({Key key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
          text: 'Hello my friends',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.subtitle1,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            //color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Please',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
            TextSpan(
              text: 'Come',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'onTry',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

Container registerAvatar(BuildContext context, bool avatar) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          avatar
              ? MediaQuery.of(context).size.width * 0.12
              : MediaQuery.of(context).size.width * 0.11,
        ),
        boxShadow: [
          avatar
              ? BoxShadow(color: Colors.red, blurRadius: 2)
              : BoxShadow(color: Colors.white, blurRadius: 2)
        ]),
    child: CircleAvatar(
      radius: avatar
          ? MediaQuery.of(context).size.width * 0.12
          : MediaQuery.of(context).size.width * 0.11,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.11,
        backgroundColor: Colors.amberAccent,
      ),
    ),
  );
}
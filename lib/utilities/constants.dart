import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 90.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  letterSpacing: 1.5,
);

const kConditionTextStyle = TextStyle(
  fontSize: 70.0,
);

const kTextFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  hintText: 'City, Country',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  fillColor: Colors.white,
  filled: true,
  icon: Icon(
    Icons.input,
    color: Colors.white,
    size: 35,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
  ),
);

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.newColor,this.newText, @required this.onPressed});
  final Color newColor;
  final String newText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: newColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text('$newText',style: TextStyle(
            color: Colors.white,fontSize: 17
          ),),
        ),
      ),
    );
  }
}
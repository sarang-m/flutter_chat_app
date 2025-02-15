import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatefulWidget {
  static const String tag ='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with
    SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1), vsync:this,
    );
    animation = ColorTween(begin:Colors.grey,end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
      //print(controller.value);
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                    text: ['Fire Chat'],
                    speed: Duration(milliseconds: 300),
                    textStyle: TextStyle(fontSize: 45.0,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(newColor: Colors.lightBlueAccent,newText: 'Log In',
              onPressed:(){
                Navigator.pushNamed(context, LoginScreen.tag);
              } ,),
            RoundedButton(newColor: Colors.blueAccent,newText: 'Register',
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.tag);
              }),
          ],
        ),
      ),
    );
  }
}



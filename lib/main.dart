import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black87),
        ),
      ),
      initialRoute:WelcomeScreen.tag,
      routes: <String, WidgetBuilder>{
        ChatScreen.tag:(context) => ChatScreen(),
        LoginScreen.tag:(context) => LoginScreen(),
        RegistrationScreen.tag:(context) => RegistrationScreen(),
        WelcomeScreen.tag:(context) => WelcomeScreen()
      },
    );
  }
}

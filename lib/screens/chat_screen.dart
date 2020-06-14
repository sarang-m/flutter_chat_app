import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {

  static const String tag = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  void messageStream()async{
   var snapShots =_fireStore.collection('messages').snapshots();
   await for(var snapShot in snapShots){
     for (var message in snapShot.documents){
       print(message.data);
     }
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                //_auth.signOut();
                //Navigator.pop(context);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      _fireStore.collection('messages').add({
                        'Text':messageText,
                        'Sender':loggedInUser.email
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],


        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot){
        if (snapshot.hasData){
          List<MessageBubble>messageBubbles = [];
          final messages = snapshot.data.documents.reversed;
          for (var message in messages){
            final messageText = message.data['Text'];
            final messageSender = message.data['Sender'];
            final currentSender = loggedInUser.email;
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentSender==messageSender,);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              children: messageBubbles,
            ),
          );
        }
      },

    );
  }
}



class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.text,this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,
            style: TextStyle(fontSize: 12.0,color: Colors.black45),),
          SizedBox(height: 5.0,),
          Material(
            elevation: 5.0,
            borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(30),bottomLeft:Radius.circular(30),
                bottomRight: Radius.circular(30.0)): BorderRadius.only(
                bottomRight: Radius.circular(30.0),topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            color: isMe ? Colors.lightBlueAccent : Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: Text('$text'),), textStyle: TextStyle(
              color: isMe ? Colors.white:Colors.black54 ,fontSize: 15.0),),
        ],
      ),
    );
  }
}





import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../model/message.dart';

class Messagingwidget extends StatefulWidget {
  @override
  _MessagingwidgetState createState() => _MessagingwidgetState();
}

class _MessagingwidgetState extends State<Messagingwidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage:$message");
        // final Notification = message['notification'];
        // setState(() {
        //   messages.add(
        //       Message(title: Notification['title'], body: Notification['body']));
        // });
        //Navigator.pushNamed(context, '/aboutus');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch:$message");
        //  Navigator.pushNamed(context, '/contact');
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume:$message");
        //Navigator.pushNamed(context, '/aboutus');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.getToken().then((token){
    //   print(token);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("firebase message"),
        ),
        body: ListView(children: messages.map(buildMessage).toList()),
         
          
      );
      
  }
 
  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatOrders extends StatefulWidget {
  const ChatOrders({super.key});

  @override
  State<ChatOrders> createState() => Chat_OrdersState();
}

class Chat_OrdersState extends State<ChatOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text('Logout')),
    ));
  }
}

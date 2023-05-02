import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rec_chat/Authenticate/LoginScree.dart';
import 'package:rec_chat/Screens/images_class.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;


  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  // void getMessages() async{
  //   final messages = await _firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }

// void messageStream() async {
//    await for( var snapshot in _firestore.collection('messages').snapshots()){
//      for(var message in snapshot.docs){
//        print(message.data());
//      }
//    }
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              'images/RecIMG.png',
              height: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Rec Chat')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                //add log out function
                _auth.signOut();
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamed(context,'log');

                });
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                  border: (Border(
                      top: BorderSide(
                color: Colors.orange,
                width: 2,
              )))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Write your message here ....',
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    color: Colors.blue[800],
                      onPressed: () {
                        Navigator.pushNamed(context,'Upload');
                      },
                      icon: Icon(Icons.camera_enhance_rounded)),
                  IconButton(
                      color: Colors.blue[800],
                      onPressed: () {
                        Navigator.pushNamed(context,'Upload');
                      },
                      icon: Icon(Icons.add_box_rounded)),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                          _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': signedInUser.email,
                            'time': FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder:(context,snapshot){
        List<MessageLine> messageWidjets = [];
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        final messages = snapshot.data!.docs.reversed;

        for(var message in messages ){
          final messageText = message.get('text');

          final messageSender = message.get('sender');
          final currentUser = signedInUser.email;

          if(currentUser == messageSender){

          }

          final messageWidjet = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );


          messageWidjets.add(messageWidjet);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidjets,
          ),
        );
      },);

  }
}




class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isMe, Key? key}) : super(key: key);

  final String? sender;
  final String? text;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12,color: Colors.yellow[800]),),
          Material(
            elevation: 5,
            borderRadius: isMe ? BorderRadius.only(
                topLeft:Radius.circular(30),
              bottomLeft:Radius.circular(30),
            bottomRight: Radius.circular(30)
            ):BorderRadius.only(
              topRight:Radius.circular(30),
              bottomLeft:Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe ?  Colors.blue[800] : Colors.deepOrange,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('$text+',
                    style: TextStyle(fontSize: 15, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

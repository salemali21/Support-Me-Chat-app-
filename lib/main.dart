import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:support_me/Authenticate/CreateAccount.dart';
import 'package:support_me/Authenticate/DocCreateAccount.dart';
import 'package:support_me/Authenticate/LoginScree.dart';
import 'package:support_me/Screens/Chat_Screen.dart';
import 'package:support_me/Screens/HomeScreen.dart';
import 'package:support_me/Screens/splashscreen.dart';
import 'package:support_me/Screens/splashscreen1.dart';
import 'package:support_me/Screens/splashscreen2.dart';
import 'package:support_me/Screens/welcomeScreen.dart';


import 'Screens/splashscreen3.dart';
import 'firebase_options.dart';
import 'page/MainPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'eslamChat',
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rec Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:  TEst(),
      initialRoute: _auth.currentUser != null ? 'home' : 'Splach_screen',
      routes: {
        'Splach_screen': (context) => SplashScreen(),
        'Splach_screen1': (context) => SplashScreen1(),
        'Splach_screen2': (context) => SplashScreen2(),
        'Splach_screen3': (context) => SplashScreen3(),
        'welcome_screen': (context) => WelcomeScreen(),
        'Chat_screen': (context) => ChatScreen(),
        // 'Upload': (context) => ImageUpload(),
        'log': (context) => LoginScreen(),
        'register': (context) => CreateAccount(),
        'DocRe': (context) => DocCreateAccount(),

        'home': (context) => HomeScreen(),
        'hope': (context) => MainPage(),


      },
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PlatformFile? pickedFile;
  File? file;
  ImagePicker image = ImagePicker();
  String url = "";
  var name;
  var name2;
  var color1 = Colors.redAccent[700];


  Future selectecdFile()async{
    final result = await FilePicker.platform.pickFiles();
    if (result!=null){
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "مدير الملفات",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* MaterialButton(
              onPressed: () {
                setState(() {
                  color1 = Colors.grey[700];
                });
              },
              color: color1,
              splashColor: Colors.white,
              child: Text(
                " Subscribe ",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  // backgroundColor: Colors.redAccent[700],
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),*/
            SizedBox(
              height: 50,
            ),
            Container(
              height: 200,
              child: Image.asset('assets/images/Picture1.png'),
            ),
            SizedBox(
              height: 80,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              elevation: 10.0,
              height: 50,
              onPressed: () {
                getfile();
              },
              child: Text(
                "  Get file",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.white
                ),
              ),
              color: Colors.deepOrange,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              elevation: 10.0,
              height: 50,
              onPressed: () {
                getImage();
              },
              child: Text(
                "  Get Image",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                    color: Colors.white,
                ),
              ),
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              elevation: 10.0,
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, 'hope');
              },
              child: Text(
                "Image Manager",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.white
                ),
              ),
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              elevation: 20.0,
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, 'Abo OMo eshta8al');
              },
              child: Text(
                "Files Manager",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.white
                ),
              ),
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }

  getfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      // allowedExtensions: ['pdf', 'doc'],
      allowMultiple: true,
    );

    if (result != null) {
      File c = File(result.files.single.path.toString());
      setState(() {
        file = c;
        name = result.names.toString();
      });
      uploadFile();
    }
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
    if (file != null) {
      uploadFileimage();
    }
  }

  uploadFile() async {
    try {
      var imagefile =
      FirebaseStorage.instance.ref().child("files").child("/${name.replaceAll(new RegExp(']'),'')}");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      if (url != null && file != null) {
        Fluttertoast.showToast(
          msg: "Done Uploaded",
          textColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.red,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        textColor: Colors.red,
      );
    }
  }


  uploadFileimage() async {
    try {
      var imagefile =
      FirebaseStorage.instance.ref().child("images").child("/${name.replaceAll(new RegExp(']'),'')}");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      if (url != null && file != null) {
        Fluttertoast.showToast(
          msg: "Done Uploaded",
          textColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.red,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        textColor: Colors.red,
      );
    }
  }


}
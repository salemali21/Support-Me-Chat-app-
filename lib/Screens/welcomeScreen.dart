import 'package:flutter/material.dart';
import 'package:rec_chat/components/MyButton.dart';
import 'package:rec_chat/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigationPage(String rout) {
    Navigator.of(context).pushNamed(rout);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: b8,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('assets/images/Spla1.jpg'),
                ),
              ],
            ),
            SizedBox(height: 30,),
Container(
padding: EdgeInsets.symmetric(horizontal: 80),
  child:   MyButton(color: ora,

      title: "Sign In",

      onPressed: (){

    Navigator.pushNamed(context, 'log');

      },

  ),
),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),

              child: MyButton(color: b3, title: "Sign Up", onPressed: (){
               // Navigator.pushNamed(context,  'register');
                final alert = AlertDialog(
                  backgroundColor: b8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "SIGN UP AS ",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: b3,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ],
                      )
                    ],
                  ),
                  content: Container(
                      width: 300.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ],
                      )),
                  actions: [
                    Divider(
                      color: Colors.black87,
                      height: 0,
                    ),
                    SizedBox(height: 9),
                    signUpAs(
                      'register',
                      "PATIENT",
                      "Routing to PATIENT_SIGN_UP",
                      "assets/images/patient2.png",
                    ),
                    SizedBox(height: 8),
                    signUpAs(
                      'DocRe',
                      "DOCTOR",
                      "Routing to DOCTOR_SIGN_UP",
                      "assets/images/surgeon-doctor.png",
                    ),
                    SizedBox(height: 8),
                    /*  signUpAs(
              PHARMACY_SIGN_UP,
              "PHARMACY",
              "Routing to PHARMACY_SIGN_UP",
              "assets/images/pharmacylogo.png",
            ),
            SizedBox(height: 8),*/
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return alert;
                    });
              },),
            ),
          ],
        ),
      ),
    );
  }
  Widget signUpAs(
      String rout, String title, String consolMessage, String image) {
    return TextButton(
      onPressed: () {
        navigationPage(rout);
        //  Navigator.of(context).pushNamed(SIGN_IN);

        print(consolMessage);
      },
      child: Container(
          alignment: Alignment.center,
          /*  width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),*/
          width: 500,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            /*    gradient: LinearGradient(
            colors: [b3, b1],*/

            //  ),
            color: b3,
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [SizedBox(width: 6), Image.asset(image)],
              ),
              Row(
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        //  fontWeight: FontWeight.bold
                        //  letterSpacing: 1
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_right),
                  SizedBox(width: 6),
                ],
              ),
            ],
          )),
    );
  }
}

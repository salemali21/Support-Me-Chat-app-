
import 'package:flutter/material.dart';
import 'package:rec_chat/Authenticate/CreateAccount.dart';
import 'package:rec_chat/Authenticate/Methods.dart';
import 'package:rec_chat/Screens/HomeScreen.dart';
import 'package:rec_chat/components/TextFormField.dart';
import 'package:rec_chat/constants/colors.dart';

import '../components/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: b8,
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios), onPressed: () {
                      Navigator.pop(context);

                    }),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Sign In to Contiue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset('assets/images/background2.jpg'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Enter Your Email', textEditingController: _email, keyboardType: TextInputType.emailAddress,color: Colors.blue,
                        icon: Icons.email_outlined,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Enter Your Password', textEditingController: _password, keyboardType: TextInputType.visiblePassword,color: Colors.blue,
                        icon: Icons.lock,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                 /* GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount())),
                    child: Text(
                      "< Create Account",
                      style: TextStyle(
                        color: w,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )*/
                  ElevatedButton(
                      style: const ButtonStyle(
                    //    backgroundColor: Colors.green,
                      ),
                      onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount()
                    ));
                  }, child: const Text('Create Account'))
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              showToast(text: 'Login Sucessfull', error: false);

              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              print("Login Failed");
              showToast(text: 'Login Failed', error: true);

              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
          showToast(text: 'Please fill form correctly', error: true);

        }
      },
      child: Container(
          height: size.height / 18,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: b3,
          ),
          alignment: Alignment.center,
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        textAlign: TextAlign.center,
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: const OutlineInputBorder(
            borderRadius:  BorderRadius.all(
    Radius.circular(10),),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepOrange,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

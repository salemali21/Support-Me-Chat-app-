import 'package:flutter/material.dart';
import 'package:rec_chat/Authenticate/Methods.dart';
import 'package:rec_chat/components/TextFormField.dart';

import '../Screens/HomeScreen.dart';
import '../constants/colors.dart';
/*ليه ده Stateful علشان دع شاشة ليها حالة يعني بتتغير عند حدوث شئ معين*/
class DocCreateAccount extends StatefulWidget {
  @override
  _DocCreateAccountState createState() => _DocCreateAccountState();
}

class _DocCreateAccountState extends State<DocCreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _spec = TextEditingController();

  //final TextEditingController _birth = TextEditingController();

  final TextEditingController _phonenumber = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: isLoading
      //الجزء ده معناه لو لسه في حاجة بتحمل يجيب صفحة بيضة فيها دايرة التحميل لحد متخلص
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
      //لو خلص يجيبلي صفحة قابلة للscroll
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
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {
                      Navigator.pop(context);
                    }),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
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
                      "Create Account to Contiue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: 180,
                    child: Image.asset('assets/images/background2.jpg'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Name', textEditingController: _name, keyboardType: TextInputType.text,color: Colors.blue,
                        icon: Icons.accessibility,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Gender: Male, Female', textEditingController: _gender, keyboardType: TextInputType.text,color: Colors.lightBlue,
                        icon: Icons.people_outline_sharp,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Spcialist', textEditingController: _spec, keyboardType: TextInputType.text,color: Colors.lightBlue,
                        icon: Icons.people_outline_sharp,obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Email', textEditingController: _email, keyboardType: TextInputType.emailAddress,color: Colors.lightBlue,
                        icon: Icons.email_sharp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: CustomTextField(hint: 'Password', textEditingController: _password, keyboardType: TextInputType.visiblePassword,color: Colors.lightBlue,
                        icon: Icons.people_outline_sharp,obscureText: true,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Login >",
                        style: TextStyle(
                          color: w,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty &&
            _gender.text.isNotEmpty ) {
          setState(() {
            isLoading = true;
          });

          createAccount(_name.text, _email.text, _password.text, _gender.text,).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 18,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: b3,
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
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
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: bla),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

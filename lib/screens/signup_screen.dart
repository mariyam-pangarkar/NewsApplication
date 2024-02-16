import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mary_news/reuse_textfield/Text_field.dart';
import 'package:mary_news/screens/homescreen.dart';



class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 26, 81, 123),
                  Color.fromARGB(255, 179, 62, 177),
                ]),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20.0, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Email id', Icons.verified_user, true,
                      _emailTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Username', Icons.lock, true,
                      _userTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Password', Icons.lock, false,
                      _passwordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  signInbutton(context, false, () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) {
                      print('created acc');

                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                    }).onError((error, stackTrace) {
                      print('Error ${error.toString()}');
                    });

                  }),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

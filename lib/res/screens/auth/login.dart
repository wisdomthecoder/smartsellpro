import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smartsellpro/res/screens/auth/register.dart';

import '../../styling/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginEmail = TextEditingController();

  TextEditingController loginPassword = TextEditingController();
  final bool _isLogin = true;

  String emaila = 'qwq';

  String passworda = '';

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: sizes.height * .15,
            ),
            const Icon(
              Icons.android,
              size: 90,
            ),
            SizedBox(
              height: sizes.height * .05,
            ),
            const Text(
              'Already a User!  Login',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: sizes.height * .06,
            ),
            SizedBox(
              height: sizes.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  obscureText: false,
                  controller: loginEmail,
                  onChanged: (value) {},

                  //cursorColor: Colors.amberAccent,
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.mail),
                      fillColor: Colors.white10,
                      filled: true,
                      //hintText: hinttext,
                      hintText: 'Email',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 1, 18, 2),
                          fontWeight: FontWeight.w500),
                      enabled: true,
                      focusedBorder: btnStyle,
                      enabledBorder: btnenabled

                      //fillColor: Color(0xfff3f3f4),
                      )),
            ),
            //Text(emaila),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: loginPassword,
                  obscureText: isVisible,
                  onChanged: (value) {},

                  //cursorColor: Colors.amberAccent,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined)),
                      fillColor: Colors.white10,
                      filled: true,
                      //hintText: hinttext,
                      hintText: 'Password',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 1, 18, 2),
                          fontWeight: FontWeight.w500),
                      enabled: true,
                      focusedBorder: btnStyle,
                      enabledBorder: btnenabled

                      //fillColor: Color(0xfff3f3f4),
                      )),
            ),
            SizedBox(
              height: sizes.height * .01,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (loginEmail.text.length < 4 ||
                      loginPassword.text.length < 8) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 102, 0, 149),
                          title: Row(
                            children: const [
                              Icon(Icons.warning),
                              Text('Errored Input'),
                            ],
                          ),
                          actions: [
                            const Text('password: Must be more than 8 chars'),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('Cancel'))
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: loginEmail.text, password: loginPassword.text);
                    } on FirebaseAuthException catch (error) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(error.toString()),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ),
            SizedBox(
              height: sizes.height * .1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont Have and Account'),
                TextButton(
                  onPressed: () {
                    Get.to(const UserRegisterPage());
                  },
                  child: const Text(
                    'Register',
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

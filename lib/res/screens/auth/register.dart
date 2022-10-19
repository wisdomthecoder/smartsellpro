import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartsellpro/res/models/user.dart';
import 'package:smartsellpro/res/widgets/text_field_registration.dart';
import 'login.dart';
import 'package:smartsellpro/res/screens/first_page.dart';

// import 'package:image_picker/image_picker.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({Key? key}) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  File? image;

  Future profilePicturePicker(ImageSource imageSource) async {
    final img = await ImagePicker().pickImage(
      source: imageSource,
    );
    if (img == null) return;

    final temporaryImg = File(img.path);

    setState(() {
      image = temporaryImg;
    });

    /* if (image == null) {
      this.image = picked.;
    } */
  }

  Future<void> sendImage() async {
    print('object');
    try {
      // User? _currentUser = await FirebaseAuth.instance.currentUser;
      // String uid = '';

      if (image != null) {
        // CustomFullScreenDialog.showDialog();
        Reference storageReference =
            FirebaseStorage.instance.ref().child('profile/profiles');
        UploadTask uploadTask = storageReference.putFile(image!);
        await uploadTask;
        String tx = await storageReference.getDownloadURL();
        imgurl = tx;
        ;
      }
    } catch (error) {
      print(error);
    }
  }

  String? imgurl;
  TextEditingController userName = TextEditingController();
  TextEditingController usersaddress = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Users Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
            width: double.infinity,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.vertical,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //alignment: Alignment.centerRight,
                  children: [
                    image == null
                        ? GestureDetector(
                            //backgroundColor: Colors.black,
                            child: const Icon(
                              Icons.person,
                              color: Colors.yellowAccent,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 10)
                              ],
                              size: 78,
                            ),
                          )
                        : SizedBox(
                            width: 120, height: 120, child: Image.file(image!)),
                    IconButton(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      iconSize: 35,
                      onPressed: () {
                        showModalBottomSheet(
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                ListTile(
                                  title: Text('Camera'),
                                  onTap: () =>
                                      profilePicturePicker(ImageSource.camera),
                                ),
                                ListTile(
                                  title: Text('Gallery'),
                                  onTap: () =>
                                      profilePicturePicker(ImageSource.camera),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Close',
                                  ),
                                ),
                              ],
                            );
                          },
                        ); //then((value) => Navigator.pop(context));
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                TextFields(
                    isPassword: false,
                    controller: userName,
                    hintText: 'Full Name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words),
                TextFields(
                    isPassword: false,
                    controller: usersaddress,
                    hintText: 'Address',
                    prefixIcon: Icons.location_on,
                    keyboardType: TextInputType.streetAddress,
                    textCapitalization: TextCapitalization.words),
                TextFields(
                    isPassword: false,
                    controller: email,
                    hintText: 'email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none),
                TextFields(
                    isPassword: true,
                    controller: password,
                    hintText: 'password',
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.none),
                TextFields(
                    isPassword: true,
                    controller: confirmPassword,
                    hintText: 'confirm Password',
                    prefixIcon: Icons.lock_outlined,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words),
                TextFields(
                    isPassword: false,
                    controller: phone,
                    hintText: 'Phone',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.words),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(imgurl);
                      if (userName.text.isEmpty ||
                          usersaddress.text.isEmpty ||
                          email.text.isEmpty ||
                          password.text.isEmpty ||
                          phone.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Text('Error'),
                            children: [
                              const Text(
                                  'Password Must be more Than 8 Characters'),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          )
                              .then((value) async {
                            sendImage().then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('userDetails')
                                  .doc('myDetails')
                                  .set(UserDetail(
                                    name: userName.text,
                                    shop_address: usersaddress.text,
                                    email: email.text,
                                    dateCreated: Timestamp.now(),
                                    profileImg: imgurl!,
                                    password: password.text,
                                    phoneNo: int.parse(phone.text),
                                  ).toJson())
                                  .then((value) => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 140, 1, 162),
                                            elevation: 90,
                                            alignment: Alignment.center,
                                            title: const Text(
                                              'Completed!',
                                              textAlign: TextAlign.center,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            children: [
                                              const Text(
                                                'You have been sucesffuly Registered!',
                                                textAlign: TextAlign.center,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.offAll(
                                                        const MainHome());
                                                  },
                                                  child: const Text(
                                                    'Ok',
                                                    textAlign: TextAlign.center,
                                                  ))
                                            ],
                                          );
                                        },
                                      ));
                            });
                            // User? _currentUser = await FirebaseAuth.instance.currentUser;
                            // String uid = '';

                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 140, 1, 162),
                                  elevation: 90,
                                  alignment: Alignment.center,
                                  title: const Text(
                                    'Completed!',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  children: [
                                    const Text(
                                      'You have been sucesffuly Registered!',
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.offAll(const MainHome());
                                        },
                                        child: const Text(
                                          'Ok',
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                );
                              },
                            );
                          });
                        } catch (error) {
                          if (error.toString().contains('already')) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 140, 1, 162),
                                  elevation: 90,
                                  alignment: Alignment.center,
                                  title: const Text(
                                    'Already Have and Account!',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  children: [
                                    const Text(
                                      'Please Login',
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.offAll(const MainHome());
                                        },
                                        child: const Text(
                                          'Ok',
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                );
                              },
                            );
                          } else if (error.toString().contains('password')) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text('Weak Password'),
                                );
                              },
                            );
                          }
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text('Already Have an Account'),
                TextButton(
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  child: const Text('Login'),
                ),
              ],
            )),
      ),
    );
  }
}

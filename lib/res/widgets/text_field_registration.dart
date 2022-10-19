import 'package:flutter/material.dart';

import '../styling/styles.dart';

class TextFields extends StatelessWidget {
  TextFields(
      {super.key,
      required this.isPassword,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      required this.keyboardType,
      required this.textCapitalization});

  bool isPassword;
  bool isVisible = true;
  TextEditingController controller;
  String hintText;
  IconData prefixIcon;
  TextInputType keyboardType;
  TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    if (isPassword == false) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            controller: controller,
            obscureText: isPassword,
            // controller: loginPassword,
            // obscureText: isVisible,
            //cursorColor: Colors.amberAccent,
            textCapitalization: textCapitalization,
            textAlign: TextAlign.start,
            scribbleEnabled: true,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                prefixIcon: Icon(prefixIcon),
                //fillColor: Colors.white,
                filled: true,
                //hintText: hinttext,
                hintText: hintText,
                labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 1, 18, 2),
                    fontWeight: FontWeight.w500),
                enabled: true,
                focusedBorder: btnStyle,
                enabledBorder: btnenabled

                //fillColor: Color(0xfff3f3f4),
                )),
      );
    } else {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: controller,
                obscureText: isVisible,
                onChanged: (value) {},

                //cursorColor: Colors.amberAccent,
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.visiblePassword,
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
          );
        },
      );
    }
  }
}

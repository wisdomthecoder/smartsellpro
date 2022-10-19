import 'package:flutter/material.dart';

import '../../styling/styles.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController? searchCon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: TextField(
          controller: searchCon,
          // controller: loginPassword,
          // obscureText: isVisible,
          onChanged: (value) {
            setState(() {});
          },

          //cursorColor: Colors.amberAccent,
          textCapitalization: TextCapitalization.none,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search),
            fillColor: Colors.transparent,
            filled: true,
            //hintText: hinttext,
            hintText: 'What are you Loking for!',
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 1, 18, 2),
                fontWeight: FontWeight.w500),
            enabled: true,
            focusedBorder: btnStyle,
            enabledBorder: btnenabled,
            //border: btnenabled

            //fillColor: Color(0xfff3f3f4),
          )),
    );
  }
}

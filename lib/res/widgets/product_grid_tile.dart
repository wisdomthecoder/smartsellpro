// import 'package:flutter/src/widgets/.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ProductsGridTile extends StatelessWidget {
  ProductsGridTile(
      {super.key,
      required this.img,
      required this.product_name,
      required this.product_price});
  String img;
  String product_name;
  int product_price;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 50,
            color: const Color.fromARGB(237, 25, 25, 25),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product_name),
                Text(product_price.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

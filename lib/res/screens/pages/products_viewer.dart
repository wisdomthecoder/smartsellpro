import 'package:flutter/material.dart';
import 'package:smartsellpro/res/models/product.dart';

class ProductsView extends StatelessWidget {
  ProductsView({required this.productToView});
  ProductModel productToView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
              tag: productToView.product_title,
              child: Image.network(productToView.product_img)),
        ],
      ),
    );
  }
}

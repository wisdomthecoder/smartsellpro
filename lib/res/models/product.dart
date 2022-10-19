import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  String product_title;
  String product_img;
  int price;
  dynamic details;
  bool isAdmin;
  String uid;
  int quantity;
  Timestamp datePosted;

  ProductModel(
      {required this.product_title,
      //required this.product_owner,
      required this.product_img,
      required this.price,
      required this.details,
      required this.uid,
      required this.isAdmin,
      required this.datePosted,
      required this.quantity});

  toJson() => {
        'product_title': product_title,
        //'product_owner': product_owner,
        'product_img': product_img,
        'price': price,
        'uid': uid,
        'datePosted': datePosted,
        'details': details,
        'quantity': quantity,
        'isAdmin': isAdmin,
      };
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        product_title: json['product_title'],
        // product_owner: json['product_owner'],
        quantity: json['quantity'],
        datePosted: json['datePosted'],
        product_img: json['product_img'],
        price: json['price'],
        uid: json['uid'],
        details: json['details'],
        isAdmin: json['isAdmin'],
      );
}

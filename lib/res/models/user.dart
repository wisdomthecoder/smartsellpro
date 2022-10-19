import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetail {
  String name, shop_address, email, password, profileImg;
  int phoneNo;
  Timestamp dateCreated;

  UserDetail(
      {required this.name,
      required this.profileImg,
      required this.shop_address,
      required this.email,
      required this.dateCreated,
      required this.password,
      required this.phoneNo});

  toJson() => {
        'name': name,
        'shop_address': shop_address,
        'email': email,
        'password': password,
        'dateCreated': dateCreated,
        'phoneNo': phoneNo,
        'profileImg': profileImg
      };
}

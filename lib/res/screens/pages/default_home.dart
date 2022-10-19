import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:smartsellpro/res/helpers/currency.dart';
import 'package:smartsellpro/res/screens/pages/products_viewer.dart';

import '../../models/product.dart';
import '../../styling/styles.dart';
import '../../styling/text_styles.dart';

var uid = FirebaseAuth.instance.currentUser!.uid;

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _DefaultHomeState();
}

class _DefaultHomeState extends State<DefaultHome> {
  CollectionReference userCollection = FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .collection('userDetails');

  getData() async {
    var record = await FirebaseFirestore.instance.collection('products').get();
    mapProductData(record);
    mapMyProductData(record);
  }

  List<ProductModel> productList = [];
  List<ProductModel> popularDeals = [];
  List<ProductModel> myProducts = [];

  mapProductData(QuerySnapshot<Map> records) {
    var _tempList = records.docs
        .map(
          (product) => ProductModel(
            details: product['details'],
            isAdmin: product['isAdmin'],
            price: product['price'],
            datePosted: product['datePosted'],
            uid: product['uid'],
            quantity: product['quantity'],
            product_img: product['product_img'],
            product_title: product['product_title'],
          ),
        )
        .toList();
    setState(() {
      productList = _tempList;
    });
  }

  mapMyProductData(QuerySnapshot<Map> records) {
    var _tempList = records.docs
        .map(
          (product) => ProductModel(
            details: product['details'],
            isAdmin: product['isAdmin'],
            price: product['price'],
            datePosted: product['datePosted'],
            uid: product['uid'],
            quantity: product['quantity'],
            product_img: product['product_img'],
            product_title: product['product_title'],
          ),
        )
        .toList();
    setState(() {
      for (var tempData in _tempList) {
        if (tempData.uid == uid) {
          myProducts.add(tempData);
        }
      }
    });
  }

  TextEditingController searchCon = TextEditingController();
  @override
  void initState() {
    getData();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(productList);
    return SafeArea(
        //child: Text('His'),
        child: FutureBuilder<DocumentSnapshot>(
      future: userCollection.doc('myDetails').get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // var data = snapshot.data!.data() as Map<String, dynamic>;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          var datas = snapshot.data?.data() as Map<String, dynamic>;
          return Scaffold(
            endDrawer: Drawer(
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
                    currentAccountPicture: ClipOval(
                      child: Image.network(
                        datas['profileImg'],
                      ),
                    ),
                    accountName: Text(
                      datas['name'],
                    ),
                    accountEmail: Text(
                      datas['email'],
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //color: Colors.red,
                    child: Column(
                      children: [
                        ListTile(
                            //leading: Icon(Icons.notifications),
                            title: Text(
                              'Welcome ${datas['name']}',
                              style: simpleText,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        getData();
                                      });
                                    },
                                    icon: Icon(Icons.refresh)),
                                IconButton(
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .31),
                        color: Color.fromARGB(13, 245, 245, 245),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Register As A Seller',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        duration: Duration(seconds: 2),
                                        message:
                                            'yet to be Added or Try updating app',
                                        icon: Icon(Icons.warning_amber),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Click Here',
                                  ),
                                ),
                              ],
                            ),
                            //color: Colors.amber,
                          )),
                          Expanded(
                              child: Container(
                            //color: Color.fromARGB(33, 149, 141, 118),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('asset/image/seller.png'),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Deals',
                        style: simpleText,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: TextStyle(color: Colors.tealAccent.shade200),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productList
                          .map((product) => Column(
                                children: [
                                  Hero(
                                    tag: product.product_title,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(ProductsView(
                                          productToView: product,
                                        ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        width: 100,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            product.product_img,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    product.product_title,
                                    style: productTitleAmount,
                                  ),
                                  Text(
                                    '${naira}${product.price.toString()}',
                                    style: productPriceAmount,
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your Products',
                        style: simpleText,
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: myProducts
                          .map((product) => Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        product.product_img,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    product.product_title,
                                    style: productTitleAmount,
                                  ),
                                  Text(
                                    '${naira}${product.price.toString()}',
                                    style: productPriceAmount,
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    ));
  }
}

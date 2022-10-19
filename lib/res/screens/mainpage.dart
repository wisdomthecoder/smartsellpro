import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smartsellpro/res/models/product.dart';
import 'package:smartsellpro/res/screens/add_product/add_product.dart';
//import 'package:transparent_image/transparent_image.dart';
import 'package:smartsellpro/res/screens/pages/cart.dart';
import 'package:smartsellpro/res/screens/pages/default_home.dart';
import 'package:smartsellpro/res/screens/pages/oders.dart';
import 'package:smartsellpro/res/screens/pages/profile.dart';
import 'package:smartsellpro/res/screens/pages/search_products.dart';

// import '../models/getfromfire.dart';

class SmartSellHome extends StatefulWidget {
  @override
  _SmartSellHomeState createState() => _SmartSellHomeState();
}

class _SmartSellHomeState extends State<SmartSellHome> {
  var index = 0;

  List screens = [
    DefaultHome(),
    ProductSearch(),
    Cart(),
    const ChatOrders(),
    const Profile(),
  ];
  // var docs = FirebaseFirestore.instance.collection('sellers').snapshots().
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: index >= 1
          ? null
          : FloatingActionButton(
              tooltip: 'Click to Add Product',
              onPressed: () {
                Get.to(() => AddProduct());
              },
              child: Icon(Icons.add),
            ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: const Color.fromARGB(0, 0, 184, 212),
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          elevation: 10,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(milliseconds: 300),
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.search_outlined,
              ),
              selectedIcon: Icon(Icons.search_sharp),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.shopping_bag_outlined,
              ),
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Oders',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline_outlined,
              ),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

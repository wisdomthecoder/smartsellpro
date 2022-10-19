import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartsellpro/res/models/product.dart';
import 'package:smartsellpro/res/screens/first_page.dart';
import 'package:smartsellpro/res/widgets/text_field_registration.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? productImg;
  var timestamp = Timestamp.now();
  String? productImgUrl;
  Future<void> sendImage() async {
    print('object');
    try {
      // User? _currentUser = await FirebaseAuth.instance.currentUser;
      // String uid = '';

      if (productImg != null) {
        // CustomFullScreenDialog.showDialog();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('product/uid/productsImg$timestamp');
        UploadTask uploadTask = storageReference.putFile(productImg!);
        await uploadTask;
        String tx = await storageReference.getDownloadURL();
        productImgUrl = tx;
        ;
      }
    } catch (error) {
      print(error);
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int quantity = 1;

  pickProductImg(ImageSource imageSource) async {
    final pickedImg = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 50,
      maxWidth: 300,
    );
    if (pickedImg == null) return;
    final temporaryPickFile = File(pickedImg.path);
    setState(() {
      productImg = temporaryPickFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //alignment: Alignment.centerRight,
              children: [
                productImg == null
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
                        width: 120,
                        height: 120,
                        child: ClipOval(child: Image.file(productImg!))),
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
                              onTap: () => pickProductImg(ImageSource.camera),
                            ),
                            ListTile(
                              title: Text('Gallery'),
                              onTap: () => pickProductImg(ImageSource.gallery),
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
                controller: titleController,
                hintText: 'Product Name',
                prefixIcon: Icons.handshake,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words),
            TextFields(
                isPassword: false,
                controller: detailsController,
                hintText: 'Simple Product Details',
                prefixIcon: Icons.details,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words),
            TextFields(
                isPassword: false,
                controller: priceController,
                hintText: 'Price',
                prefixIcon: Icons.currency_exchange_rounded,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words),
            TextFields(
                isPassword: false,
                controller: details,
                hintText: 'Details',
                prefixIcon: Icons.handshake,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words),
            SizedBox(
              height: 30,
            ),
            Text('Qauntity in Stock'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (quantity >= 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Text('-'),
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (quantity > 0) {
                      setState(() {
                        quantity++;
                      });
                    }
                  },
                  child: Text('+'),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  sendImage().then(
                    (value) => FirebaseFirestore.instance
                        .collection('products')
                        .doc()
                        .set(ProductModel(
                                product_title: titleController.text,
                                product_img: productImgUrl!,
                                price: int.parse(priceController.text),
                                quantity: quantity,
                                details: details.text,
                                datePosted: Timestamp.now(),
                                uid: FirebaseAuth.instance.currentUser!.uid,
                                isAdmin: true)
                            .toJson())
                        .then(
                          (value) => Get.offAll(MainHome()),
                        ),
                  );
                },
                child: Text('Upload'))
          ],
        ),
      ),
    );
  }
}

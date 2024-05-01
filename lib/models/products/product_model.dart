import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProductModel with ChangeNotifier{

  final String productId;
  final String productTitle;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQuantity;
  Timestamp? creadetDate;

  ProductModel({required this.productId,required this.productTitle, required this.productPrice, required this.productCategory,
      required this.productDescription, required this.productImage, required this.productQuantity,this.creadetDate});

  factory ProductModel.fromFireStore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String,dynamic>;
    return ProductModel(productId: data["productId"], productTitle: data["productTitle"], productPrice: data["productPrice"], productCategory: data["productCategory"], productDescription: data["productDescription"], productImage: data["productImage"], productQuantity: data["productQuantity"],creadetDate: data["createdDate"]);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier{
  final String userId;
  final String userName;
  final String userImage;
  final String userEmail;
  final Timestamp createdDate;
  final List userCart;
  final List userFavorites;

  UserModel({required this.userId, required this.userName, required this.userImage, required this.userEmail,
    required this.createdDate, required this.userCart, required this.userFavorites});
}
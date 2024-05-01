import 'package:flutter/material.dart';

class FavoriteModel with ChangeNotifier{
  final String favoriteId;
  final String productId;

  FavoriteModel({required this.favoriteId, required this.productId});
}
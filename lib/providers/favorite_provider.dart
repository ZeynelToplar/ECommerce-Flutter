import 'package:ecommerce_flutter/models/cart/cart_model.dart';
import 'package:ecommerce_flutter/models/favorite_model.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavoriteProvider with ChangeNotifier{
  final Map<String,FavoriteModel> _favoriteItems = {};
  Map<String,FavoriteModel> get getFavorites {
    return _favoriteItems;
  }
  void addOrRemoveFavorite({required String productId}){
    if(_favoriteItems.containsKey(productId)){
      _favoriteItems.remove(productId);
    }
    else{
      _favoriteItems.putIfAbsent(productId, () => FavoriteModel(favoriteId: const  Uuid().v4(), productId: productId));
    }
    notifyListeners();
  }

  bool isProductInFavorites({required String productId}){
    return _favoriteItems.containsKey(productId);
  }

  void clearFavorite(){
    _favoriteItems.clear();
    notifyListeners();
  }
}
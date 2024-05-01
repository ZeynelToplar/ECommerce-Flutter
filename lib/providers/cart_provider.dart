import 'package:ecommerce_flutter/models/cart/cart_model.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier{
  final Map<String,CartModel> _cartItems = {};
  Map<String,CartModel> get getCartItems {
    return _cartItems;
  }
  void addProductCart({required String productId}){
    _cartItems.putIfAbsent(productId, () => CartModel(cartId: const Uuid().v4(), productId: productId, quantity: 1));
    notifyListeners();
  }
  bool isProductInCart({required String productId}){
    return _cartItems.containsKey(productId);
  }
  double getTotal({required ProductProvider productProvider}){
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.findByProductId(value.productId);
      if(getCurrentProduct == null){
        total += 0;
      }
      else{
        total += double.parse(getCurrentProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQuantity(){
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void updateQuantity({required String productId,required int quantity}){
    _cartItems.update(productId, (value) => CartModel(cartId: value.cartId, productId: productId, quantity: quantity));
    notifyListeners();
  }

  void removeSingleItem({required String productId}){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearAllItems(){
    _cartItems.clear();
    notifyListeners();
  }
}
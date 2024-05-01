import 'package:ecommerce_flutter/models/favorite_model.dart';
import 'package:ecommerce_flutter/models/recently_viewed_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class RecentlyProductProvider with ChangeNotifier{
  final Map<String,RecentlyViewedProductModel> _viewedProductItems = {};
  Map<String,RecentlyViewedProductModel> get getViewedProducts {
    return _viewedProductItems;
  }
  void addViewedProducts({required String productId}){
    _viewedProductItems.putIfAbsent(productId, () => RecentlyViewedProductModel(viewedProductId: const Uuid().v4(), productId: productId));
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';

class RecentlyViewedProductModel with ChangeNotifier{
  final String viewedProductId;
  final String productId;

  RecentlyViewedProductModel({required this.viewedProductId, required this.productId});
}
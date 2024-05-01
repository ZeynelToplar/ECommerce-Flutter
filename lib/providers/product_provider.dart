import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/models/products/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier{
  List<ProductModel> products = [];
  List<ProductModel> get getProducts{
    return products;
  }

  final db = FirebaseFirestore.instance.collection("products");

  ProductModel ? findByProductId(String productId){
    if(products.where((e) => e.productId == productId).isEmpty){
      return null;
    }
    else{
      return products.firstWhere((e) => e.productId == productId);
    }
  }

  List<ProductModel> findByCategory({required String categoryName}){
    List<ProductModel> categoryList = products.where((e) => e.productCategory.toLowerCase().contains(categoryName.toLowerCase())).toList();
    return categoryList;
  }

  List<ProductModel> searchQuery({required String searchText, required List<ProductModel> passedList}){
    List<ProductModel> searchedList = passedList.where((e) => e.productTitle.toLowerCase().contains(searchText.toLowerCase())).toList();
    return searchedList;
  }


  Future<List<ProductModel>> getAll() async{
    try{
      await db.get().then((productSnapshot){
        products.clear();
        for(var element in productSnapshot.docs){
          products.insert(0, ProductModel.fromFireStore(element));
        }
      });
      notifyListeners();
      return products;
    }
    catch(e){
      rethrow;
    }
  }
}
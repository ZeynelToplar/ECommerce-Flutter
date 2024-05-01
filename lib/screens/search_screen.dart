import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_flutter/models/products/product_model.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/products/product_widget.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const routeName = "/SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTextController.dispose();
  }

  List<ProductModel> productListSearch = [];



  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<ProductProvider>(context);
    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = passedCategory == null ? productsProvider.products : productsProvider.findByCategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                  AssetsManager.card
              ),
            ),
          ),
          title: TitleTextWidget(label: passedCategory ?? "Search Products",),
        ),
        body: productList.isEmpty ?
        const Center(child: TitleTextWidget(label: "No products"),)
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      //setState(() {
                        FocusScope.of(context).unfocus();
                        searchTextController.clear();
                     // });
                    },
                    child: const Icon(Icons.close,color: Colors.red,)
                  ),
                ),
                onChanged: (value) {
                 // log("value of text is $value");
                },
                onSubmitted: (value) {
                  productListSearch = productsProvider.searchQuery(searchText: searchTextController.text,passedList: productList);
                },
              ),
              const SizedBox(height: 15,),

              if(searchTextController.text.isNotEmpty && productListSearch.isEmpty)...[
                const Center(
                  child: TitleTextWidget(label: "No product found"),
                )
              ],
              Expanded(
                child: DynamicHeightGridView(
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  itemCount: searchTextController.text.isNotEmpty ?
                  productListSearch.length : productList.length,
                  builder: (context, index) {
                    return ProductWidget(
                      productId: searchTextController.text.isNotEmpty ?
                          productListSearch[index].productId : productList[index].productId
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

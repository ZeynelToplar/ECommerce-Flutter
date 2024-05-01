import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_flutter/providers/favorite_provider.dart';
import 'package:ecommerce_flutter/screens/cart/bottom_checkout.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/screens/cart/cart_widget.dart';
import 'package:ecommerce_flutter/screens/cart/empty_bag.dart';
import 'package:ecommerce_flutter/widgets/products/product_widget.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final bool isEmpty = false;
  static const routeName = "/FavoritesScreen";

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return favoriteProvider.getFavorites.isEmpty ? Scaffold(
      body:  EmptyBagWiget(
        imagePath: AssetsManager.basket,
        title: "Your favorites is empty",
        subTitle: "Like your favorites is empty",
        buttonText: "Add wishlist",
      ),
    )
      : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios,size: 20,),
        ),
        title: TitleTextWidget(label: "Favorites (${favoriteProvider.getFavorites.length} items)",fontSize: 28,),
      ),
      body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: 2,
        itemCount: favoriteProvider.getFavorites.length,
        builder:  (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductWidget(
              productId: favoriteProvider.getFavorites.values.toList()[index].productId,
            ),
          );
        },
      )
    );
  }
}

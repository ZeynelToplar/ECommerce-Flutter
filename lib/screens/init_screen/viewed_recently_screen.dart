import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_flutter/providers/recently_viewed_product_provider.dart';
import 'package:ecommerce_flutter/screens/cart/bottom_checkout.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/screens/cart/cart_widget.dart';
import 'package:ecommerce_flutter/screens/cart/empty_bag.dart';
import 'package:ecommerce_flutter/widgets/products/product_widget.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});

  final bool isEmpty = false;
  static const routeName = "/ViewedRecentlyScreen";

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<RecentlyProductProvider>(context);
    return viewedProvider.getViewedProducts.isEmpty ? Scaffold(
      body:  EmptyBagWiget(
        imagePath: AssetsManager.watch,
        title: "Your recently viewed is empty",
        subTitle: "Like your recently viewed is empty",
        buttonText: "Shop Now",
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
        title: TitleTextWidget(label: "Recently Viewed (${viewedProvider.getViewedProducts.length} items)",fontSize: 28,),
      ),
      body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: 2,
        itemCount: viewedProvider.getViewedProducts.length,
        builder:  (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductWidget(
              productId: viewedProvider.getViewedProducts.values.toList()[index].productId,
            ),
          );
        },
      )
    );
  }
}

import 'dart:developer';

import 'package:ecommerce_flutter/constans/app_constans.dart';
import 'package:ecommerce_flutter/models/products/product_model.dart';
import 'package:ecommerce_flutter/providers/cart_provider.dart';
import 'package:ecommerce_flutter/providers/recently_viewed_product_provider.dart';
import 'package:ecommerce_flutter/widgets/products/heart_button.dart';
import 'package:ecommerce_flutter/widgets/products/product_details.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class TopProductWidget extends StatelessWidget {
  const TopProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<RecentlyProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addViewedProducts(productId: productModel.productId);
          await Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: productModel.productId);
        },
        child: SizedBox(
          width: size.width*0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    height: size.height*0.34,
                    width: size.width*0.45,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {

                            },
                            icon: HeartButtonWidget(size: 25,productId: productModel.productId),
                          ),
                          IconButton(
                              onPressed: () {
                                if(cartProvider.isProductInCart(productId: productModel.productId)){
                                  return;
                                }
                                cartProvider.addProductCart(productId: productModel.productId);
                              },
                              icon: Icon(
                                  cartProvider.isProductInCart(productId: productModel.productId)
                                  ? Icons.check_circle_outline
                                  : Icons.shopping_bag_outlined
                              )
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubTitleTextWidget(
                        label: "\$ ${productModel.productPrice}",
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

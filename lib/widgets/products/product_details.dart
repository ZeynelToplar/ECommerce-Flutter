import 'package:ecommerce_flutter/constans/app_constans.dart';
import 'package:ecommerce_flutter/providers/cart_provider.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/products/heart_button.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static const routeName = "/ProductDetailScreen";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findByProductId(productId!);
    return Scaffold(
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
        title: const AppNameTextWidget(fontSize: 28),
      ),
      body: getCurrentProduct == null
      ? const SizedBox.shrink()
      : SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentProduct.productImage,
              height: size.height*0.35,
              width: double.infinity,
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrentProduct.productTitle,
                          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      SubTitleTextWidget(label: "\$ ${getCurrentProduct.productPrice}",fontSize: 16,fontWeight: FontWeight.w700,color: Colors.green,),
                    ],
                  ),
                  const SizedBox(height: 20,),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeartButtonWidget(
                          backgroundColor: Colors.pinkAccent,
                           size: 25,
                          productId: getCurrentProduct.productId,
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                              ),
                              onPressed: () {
                                if(cartProvider.isProductInCart(productId: getCurrentProduct.productId)){
                                  return;
                                }
                                cartProvider.addProductCart(productId: getCurrentProduct.productId);
                              },
                              icon: Icon(
                                cartProvider.isProductInCart(productId: getCurrentProduct.productId)
                                ? Icons.check_circle_outline
                                : Icons.add_shopping_cart_outlined,
                              ),
                              label:  cartProvider.isProductInCart(productId: getCurrentProduct.productId)
                                ? const Text(
                                  "In Cart",style: TextStyle(fontWeight: FontWeight.w700),
                                 )
                                : const Text(
                                "Add to cart",style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleTextWidget(label: "About this item"),
                      SubTitleTextWidget(label: "Category: ${getCurrentProduct.productCategory}"),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  SubTitleTextWidget(label: getCurrentProduct.productDescription),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

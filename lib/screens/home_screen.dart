import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_flutter/constans/app_constans.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/providers/theme_provider.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/products/category_rounded_widget.dart';
import 'package:ecommerce_flutter/widgets/products/product_widget.dart';
import 'package:ecommerce_flutter/widgets/products/top_product_widget.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
                  child: Swiper(
                    itemCount: AppConstans.bannerImages.length,
                    pagination: const SwiperPagination(
                      builder:  DotSwiperPaginationBuilder(
                        activeColor: Colors.green,
                        color: Colors.red
                      )
                    ),
                    itemBuilder: (context, index) {
                      return Image.asset(AppConstans.bannerImages[index],fit: BoxFit.fill,);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitleTextWidget(label: "Top Product")
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height*0.22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.getProducts.length < 5 ? productProvider.getProducts.length : 5,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(value: productProvider.getProducts[index],child: const TopProductWidget(),);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const TitleTextWidget(label: "Categories"),
              const SizedBox(
                height: 15.0,
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                children: 
                  List.generate(AppConstans.categories.length, (index) {
                    return CategoryRoundedWidget(image: AppConstans.categories[index].image, name: AppConstans.categories[index].name);
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

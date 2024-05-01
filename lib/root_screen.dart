import 'dart:math';

import 'package:ecommerce_flutter/providers/cart_provider.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/screens/cart/cart_screen.dart';
import 'package:ecommerce_flutter/screens/home_screen.dart';
import 'package:ecommerce_flutter/screens/profile_screen.dart';
import 'package:ecommerce_flutter/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const routeName = "/RootScreen";

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  late List<Widget> screens;
  int currentScreen = 0;
  late PageController pageController;
  bool isLoadingProduct = true;
  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      ProfileScreen(),
      CartScreen(),
      SearchScreen(),
    ];
    pageController = PageController(initialPage: currentScreen);
  }

  @override
  void didChangeDependencies(){
    if(isLoadingProduct){
      getAllProducts();
    }
    super.didChangeDependencies();
  }

  Future<void> getAllProducts() async{
    final productProvider = Provider.of<ProductProvider>(context,listen: false);

    try{
      Future.wait(
        {productProvider.getAll()},
      );
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
      ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(selectedIcon: Icon(Icons.home_filled) , icon: Icon(Icons.home), label: "Home"),
          const NavigationDestination(selectedIcon: Icon(Icons.person) , icon: Icon(Icons.person_2_outlined), label: "Profile"),
          NavigationDestination(icon: Badge(
            backgroundColor: Colors.red,
            textColor: Colors.white,
            label: Text(cartProvider.getCartItems.length.toString()),
            child: const Icon(IconlyLight.bag_2),
          ) , selectedIcon: const Icon(IconlyLight.bag_2), label: "Cart"),
          const NavigationDestination(selectedIcon: Icon(Icons.search) , icon: Icon(Icons.search), label: "Search")
        ],
        selectedIndex: currentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index){
          setState(() {
            currentScreen = index;
          });
          pageController.jumpToPage(currentScreen);
        },
      ),
    );
  }
}

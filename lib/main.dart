import 'package:ecommerce_flutter/constans/theme_data.dart';
import 'package:ecommerce_flutter/firebase_options.dart';
import 'package:ecommerce_flutter/providers/cart_provider.dart';
import 'package:ecommerce_flutter/providers/favorite_provider.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/providers/recently_viewed_product_provider.dart';
import 'package:ecommerce_flutter/providers/theme_provider.dart';
import 'package:ecommerce_flutter/providers/user_provider.dart';
import 'package:ecommerce_flutter/root_screen.dart';
import 'package:ecommerce_flutter/screens/auth/forget_password_screen.dart';
import 'package:ecommerce_flutter/screens/auth/login_screen.dart';
import 'package:ecommerce_flutter/screens/auth/register_screen.dart';
import 'package:ecommerce_flutter/screens/home_screen.dart';
import 'package:ecommerce_flutter/screens/init_screen/favorites_screen.dart';
import 'package:ecommerce_flutter/screens/init_screen/viewed_recently_screen.dart';
import 'package:ecommerce_flutter/screens/search_screen.dart';
import 'package:ecommerce_flutter/widgets/orders/order_screen.dart';
import 'package:ecommerce_flutter/widgets/products/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
   return FutureBuilder<FirebaseApp>(
     future: Firebase.initializeApp(),
     builder: (context, snapshot) {
       if(snapshot.connectionState == ConnectionState.waiting){
         return const MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: Center(child: CircularProgressIndicator()),
           ),
         );
       }
       else if(snapshot.hasError){
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: Center(child: SelectableText(snapshot.error.toString())),
           ),
         );
       }
       return MultiProvider(providers: [
         ChangeNotifierProvider(create: (_) {
           return ThemeProvider();
         }),
         ChangeNotifierProvider(create: (_) {
           return ProductProvider();
         }),
         ChangeNotifierProvider(create: (_) {
           return CartProvider();
         }),
         ChangeNotifierProvider(create: (_) {
           return FavoriteProvider();
         }),
         ChangeNotifierProvider(create: (_) {
           return RecentlyProductProvider();
         }),
         ChangeNotifierProvider(create: (_) {
           return UserProvider();
         }),
       ],
         child: Consumer<ThemeProvider>(
           builder: (context, ThemeProvider, child) {
             return MaterialApp(
               title: 'E-Commerce App',
               debugShowCheckedModeBanner: false,
               theme: Styles.themeData(
                   isDarkTheme: ThemeProvider.getIsDarkTheme, context: context),
               home: user == null ? const LoginScreen() : const RootScreen(),
               //home: const RootScreen(),
               routes: {
                 ProductDetailScreen.routeName: (
                     context) => const ProductDetailScreen(),
                 FavoritesScreen.routeName: (
                     context) => const FavoritesScreen(),
                 ViewedRecentlyScreen.routeName: (
                     context) => const ViewedRecentlyScreen(),
                 RegisterScreen.routeName: (context) => const RegisterScreen(),
                 OrderScreen.routeName: (context) => const OrderScreen(),
                 ForgetPasswordScreen.routeName: (
                     context) => const ForgetPasswordScreen(),
                 SearchScreen.routeName: (context) => const SearchScreen(),
                 RootScreen.routeName: (context) => const RootScreen(),
                 LoginScreen.routeName: (context) => const LoginScreen(),
               },
             );
           },
         ),
       );
     }
   );
  }
}
